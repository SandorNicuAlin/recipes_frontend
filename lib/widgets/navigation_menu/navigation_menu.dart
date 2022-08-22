import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../colors/my_colors.dart';
import '../../providers/notification_provider.dart';
import '../../classes/app_notification.dart';

class NavigationMenu extends StatelessWidget {
  const NavigationMenu({Key? key, this.selectedIndex, this.onTapCallback})
      : super(key: key);

  final int? selectedIndex;
  final Function(int)? onTapCallback;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: MediaQuery.of(context).size.height * 10 / 100,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              blurRadius: 25,
            ),
          ],
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
          child: BottomNavigationBar(
            selectedIconTheme:
                const IconThemeData(size: 30, color: MyColors.greenColor),
            unselectedIconTheme:
                const IconThemeData(size: 30, color: Colors.black),
            selectedFontSize: 12,
            unselectedFontSize: 12,
            elevation: 16,
            items: <BottomNavigationBarItem>[
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_book_outlined,
                ),
                label: 'Recipes',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.inventory_2_outlined,
                ),
                label: 'Stock',
              ),
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none,
                    ),
                    Consumer<NotificationProvider>(
                      builder: (context, notificationProvider, child) {
                        List<AppNotification> unseenNotifications = [];
                        for (AppNotification notification
                            in notificationProvider.notifications) {
                          if (!notification.seen) {
                            unseenNotifications.add(notification);
                          }
                        }
                        return unseenNotifications.isEmpty
                            ? const Text('')
                            : Positioned(
                                right: 0,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Text(
                                      unseenNotifications.length > 9
                                          ? '9+'
                                          : unseenNotifications.length
                                              .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                      },
                    )
                  ],
                ),
                label: 'Activity',
              ),
              const BottomNavigationBarItem(
                icon: Icon(
                  Icons.account_box_outlined,
                ),
                label: 'Account',
              ),
            ],
            currentIndex: selectedIndex!,
            selectedItemColor: MyColors.greenColor,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            onTap: onTapCallback,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
