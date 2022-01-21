import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:europharm_flutter/generated/l10n.dart';
import 'package:europharm_flutter/screens/orders_screen/ui/orders_screen.dart';
import 'package:europharm_flutter/styles/color_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'cubit/bottom_nav_bar_cubit.dart';
import 'custom_animated_bottom_bar.dart';

class BottomNavigationBarScreen extends StatefulWidget {
  const BottomNavigationBarScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationBarScreen> createState() =>
      _BottomNavigationBarScreenState();
}

class _BottomNavigationBarScreenState extends State<BottomNavigationBarScreen> {
  final List<GlobalKey<NavigatorState>> navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        if (state is BottomNavBarInitial) {
          return WillPopScope(
            onWillPop: () async {
              bool isPop = true;
              isPop = await navigatorKeys[state.currentPageIndex]
                      .currentState
                      ?.maybePop() ??
                  false;
              return !isPop;
            },
            child: Scaffold(
              body: IndexedStack(
                index: state.currentPageIndex,
                children: [
                  Navigator(
                    key: navigatorKeys[0],
                    onGenerateRoute: (route) => MaterialPageRoute(
                      builder: (context) => OrdersScreen(),
                    ),
                  ),
                  Navigator(
                    key: navigatorKeys[1],
                    onGenerateRoute: (route) => MaterialPageRoute(
                      builder: (context) => Container(),
                    ),
                  ),
                  Navigator(
                    key: navigatorKeys[2],
                    onGenerateRoute: (route) => MaterialPageRoute(
                      builder: (context) => Container(),
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  left: 57,
                  right: 57,
                  bottom: 22,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                        BoxShadow(
                          color: Color.fromRGBO(16, 51, 115, 0.2),
                          blurRadius: 30,
                          offset: Offset(0, 0),
                        )
                      ]
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: CustomAnimatedBottomBar(
                      containerHeight: 60,
                      backgroundColor: Colors.white,
                      selectedIndex: state.currentPageIndex,
                      showElevation: true,
                      itemCornerRadius: 24,
                      curve: Curves.easeIn,
                      onItemSelected: (index) {
                        context
                            .read<BottomNavBarCubit>()
                            .changeCurrentPage(index);
                      },
                      items: [
                        BottomNavBarItem(
                          icon: "assets/images/svg/orders.svg",
                          title: S.of(context).orders,
                          activeColor: ColorPalette.white,
                          inactiveColor: ColorPalette.lightBlue,
                          textAlign: TextAlign.center,
                        ),
                        BottomNavBarItem(
                          icon: "assets/images/svg/schedule.svg",
                          title: S.of(context).schedule,
                          activeColor: ColorPalette.white,
                          inactiveColor: ColorPalette.lightBlue,
                          textAlign: TextAlign.center,
                        ),
                        BottomNavBarItem(
                          icon: "assets/images/svg/user.svg",
                          title: S.of(context).user,
                          activeColor: ColorPalette.white,
                          inactiveColor: ColorPalette.lightBlue,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //     boxShadow: [
              //       BoxShadow(
              //         blurRadius: 8.0,
              //         spreadRadius: -2.0,
              //         color: ColorPalette.black.withOpacity(
              //           0.04,
              //         ),
              //       ),
              //     ],
              //   ),
              //   child: _NavigationBar(
              //     activePageIndex: state.currentPageIndex,
              //     onTap: (pageIndex) => context
              //         .read<BottomNavBarCubit>()
              //         .changeCurrentPage(pageIndex),
              //   ),
              // ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _CustomBottomNavBarItem extends StatelessWidget {
  final String icon;
  final int activeIndex;
  final int index;
  final Function(int index) onTap;

  const _CustomBottomNavBarItem({
    Key? key,
    required this.icon,
    required this.activeIndex,
    required this.onTap,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: SvgPicture.asset(
        // "$icon${index == activeIndex ? "_active" : ""}.svg",
        "$icon.svg",
        color: const Color(0xFF83B1F4),
        // color:
        //     index == activeIndex ? ColorPalette.black : ColorPalette.lightGray,
      ),
      onPressed: () => onTap.call(index),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  final List<Widget> items;

  const _CustomBottomNavBar({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: ColorPalette.white,
                height: 71,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ...items,
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
