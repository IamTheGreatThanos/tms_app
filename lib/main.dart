import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:europharm_flutter/utils/scroll_glow_disable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'generated/l10n.dart';
import 'main/dependency_initializer/dependency_initializer.dart';
import 'main/dependency_provider/dependency_provider.dart';
import 'main/login_bloc/login_bloc.dart';
import 'main/top_level_blocs/top_level_blocs.dart';
import 'managers/error_handler/error_handler.dart';
import 'managers/secure_storage_manager/secure_storage_manager.dart';
import 'managers/url_manager/url_manager.dart';
import 'managers/user_store.dart';
import 'network/dio_wrapper/dio_wrapper.dart';
import 'network/repository/global_repository.dart';
import 'network/repository/hive_repository.dart';
import 'network/services/network_service.dart';
import 'network/tokens_repository/tokens_repository.dart';
import 'widgets/dynamic_link_layer/dynamic_link_layer.dart';

const String baseUrl = 'http://185.129.50.172/api/v1/';

String get projectBaseUrl {
  if (kDebugMode) return baseUrl;
  return '';
}

void main() async {
  ///Global managers initialization
  Future<bool> _initialize(BuildContext context) async {
    try {
      await Firebase.initializeApp();
      // final FirebaseAnalytics analytics = FirebaseAnalytics();
      // final FirebaseAnalyticsObserver observer =
      //     FirebaseAnalyticsObserver(analytics: analytics);
      await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
      context.read<ErrorHandler>().initialize(S.of(context));
      final docDir = await getApplicationDocumentsDirectory();
      Hive.init(docDir.path);
      await context.read<SecureStorage>().init();
      final urlManager = context.read<UrlManager>();
      await context.read<HiveRepository>().init();
      await context.read<UserStore>().init(context.read<HiveRepository>());
      await context
          .read<TokensRepository>()
          .init(context.read<HiveRepository>());
      await context.read<DioWrapper>().init(
            baseURL: projectBaseUrl,
            tokensRepository: context.read<TokensRepository>(),
            globalRepository: context.read<GlobalRepository>(),
            loginBloc: context.read<LoginBloc>(),
          );
      context.read<NetworkService>().init(context.read<DioWrapper>());
      context
          .read<GlobalRepository>()
          .init(context.read<NetworkService>(), context.read<HiveRepository>());
    } catch (e, stackTrace) {
      await FirebaseCrashlytics.instance.recordError(e, stackTrace,
          reason: 'Dependencies are not initialized', fatal: true);
    }
    return true;
  }

  runApp(
    DependenciesProvider(
      child: TopLevelBlocs(
        child: MaterialApp(
          builder: (context, child) {
            return ScrollConfiguration(
              behavior: DisableGlowScrollBehavior(),
              child: child!,
            );
          },
          title: 'Europharm',
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
            ),
            scaffoldBackgroundColor: ColorPalette.white,
            fontFamily: 'Gilroy',
            textSelectionTheme: const TextSelectionThemeData().copyWith(
              cursorColor: ColorPalette.black,
            ),
          ),
          home: DependenciesInitializer(
            loadingIndicatorScreen: const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
            initializer: _initialize,
            child: const MainAuthorization(),
          ),
        ),
      ),
    ),
  );
}

class MainAuthorization extends StatelessWidget {
  const MainAuthorization({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is AuthorizedState) {
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (_) => MainAuthorization()),
          //     (route) => route.isFirst);
          // Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
          Navigator.of(context).popUntil((route) => route.isFirst);
        }
      },
      buildWhen: (p, c) => (c is LoadingLoginState ||
          c is UnauthorizedState ||
          c is AuthorizedState),
      builder: (context, state) {
        if (state is LoadingLoginState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            ),
          );
        }
        if (state is UnauthorizedState) {
          return const Application(
            false,
            key: ValueKey(0),
          );
        }
        if (state is AuthorizedState) {
          return const Application(
            true,
            key: ValueKey(1),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class Application extends StatelessWidget {
  final bool isAuthenticated;

  const Application(
    this.isAuthenticated, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DynamicLinkLayer(isAuthenticated: isAuthenticated);
  }
}
