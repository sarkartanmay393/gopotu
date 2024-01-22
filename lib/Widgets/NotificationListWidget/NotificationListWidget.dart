import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';

class NotificationListWidget extends StatelessWidget {
  final int? index;
  final List<dynamic>? notificationListData;

  NotificationListWidget({this.index, this.notificationListData});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(ScreenConstant.sizeSmall),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  notificationListData![index!]['created_at'],
                  style: TextStyle(
                    fontSize: FontSizeStatic.mdSm,
                    color: AppColors.fakePriceInOrderDetails,
                    fontWeight: FontWeight.bold,
                    /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
                  ),
                )
              ],
            ),
            ListTile(
              leading: CircleAvatar(
                radius: ScreenConstant.sizeLarge,
                backgroundColor: AppColors.buttonColorSecondary,
                child: Icon(
                  Icons.notifications,
                  color: AppColors.secondary,
                ),
              ),
              title: Text(
                notificationListData![index!]['heading'],
                style: TextStyle(
                  fontSize: FontSizeStatic.lg,
                  color: AppColors.accentColor,
                  fontWeight: FontWeight.bold,
                  /* fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
                ),
              ),
              subtitle: Text(
                notificationListData![index!]['content'],
                style: TextStyle(
                  fontSize: FontSizeStatic.md,
                  /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
                  color: AppColors.fakePriceInOrderDetails,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
