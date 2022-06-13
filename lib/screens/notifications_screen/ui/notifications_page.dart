import 'package:europharm_flutter/network/models/dto_models/response/error.dart';
import 'package:europharm_flutter/network/models/notification_dto.dart';
import 'package:europharm_flutter/screens/notifications_screen/bloc/notifications_bloc.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<NotificationsBloc>(context)
        .add(const NotificationsEvent.loadNotifications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Уведомления',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        leading: IconButton(
          icon: SvgPicture.asset(
            "assets/images/svg/arrow_back.svg",
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ),
      // backgroundColor: ColorPalette.background,
      body: SafeArea(
        child: BlocConsumer<NotificationsBloc, NotificationsState>(
          listener: (context, state) {
            state.whenOrNull(errorState: (AppError error) {});
          },
          builder: (context, state) {
            return state.maybeWhen(
              loadedState: (List<NotificationDTO> notifications) {
                return ListView.separated(
                  itemCount: notifications.length,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 200,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1F000000),
                            offset: Offset(0, 3),
                            blurRadius: 8,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 3),
                            blurRadius: 1,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Text(
                              'Причина: ${notifications[index].reason}',
                            ),
                          ),
                          Flexible(
                            child: Text(
                              'Заказ: #0000000${notifications[index].order?.id}',
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      thickness: 2,
                      color: ColorPalette.lightGrey,
                    );
                  },
                );
              },
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
