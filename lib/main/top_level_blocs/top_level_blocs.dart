import 'package:europharm_flutter/main/login_bloc/login_bloc.dart';
import 'package:europharm_flutter/network/repository/global_repository.dart';
import 'package:europharm_flutter/network/tokens_repository/tokens_repository.dart';
import 'package:europharm_flutter/screens/auth/bloc/bloc_auth.dart';
import 'package:europharm_flutter/screens/bottom_navigation_bar/cubit/bottom_nav_bar_cubit.dart';
import 'package:europharm_flutter/screens/documents_screen/bloc/bloc_documents_screen.dart';
import 'package:europharm_flutter/screens/orders_screen/bloc/bloc_orders_screen.dart';
import 'package:europharm_flutter/screens/ride_history_screen/bloc/bloc_ride_history.dart';
import 'package:europharm_flutter/screens/user_confirmation/bloc/bloc_verification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Providers for global blocs
class TopLevelBlocs extends StatelessWidget {
  final Widget child;

  const TopLevelBlocs({required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            context.read<TokensRepository>(),
          )..add(InitialLoginEvent()),
        ),
        BlocProvider(
          create: (context) => BlocAuth(
            repository: context.read<GlobalRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => BottomNavBarCubit(),
        ),
        BlocProvider(
          create: (context) =>
              BlocVerification()..add(EventInitialVerification()),
        ),
        BlocProvider(
          create: (context) => BlocRideHistory()..add(EventReadRideHistory()),
        ),
        BlocProvider(
          create: (context) =>
              BlocDocumentsScreen()..add(EventInitialDocumentsScreen()),
        ),
        BlocProvider(
          create: (context) =>
              BlocOrdersScreen()..add(EventInitialOrdersScreen()),
        ),
      ],
      child: child,
    );
  }
}
