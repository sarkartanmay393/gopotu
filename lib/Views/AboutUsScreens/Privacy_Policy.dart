import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class Privacy_Policy extends StatefulWidget {
  const Privacy_Policy({Key? key}) : super(key: key);

  @override
  State<Privacy_Policy> createState() => _Privacy_PolicyState();
}

class _Privacy_PolicyState extends State<Privacy_Policy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.primary,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.keyboard_arrow_left,
              color: Colors.white,
              size: ScreenConstant.sizeXL,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            "Privacy Policy",
            style: TextStyles.appBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Introduction\n\n"
                    "Welcome to the Privacy Policy of Gopoto. This Privacy Policy is intended to inform you about how we collect, use, and disclose the personal information that we collect from you when you use our platform. Using our platform, you consent to the collection, use, and disclosure of your personal information as described in this Privacy Policy.\n\n"
                    "The information we collect and how we use it\n\n"
                    "We collect this information:\n\n"
                    "**Information You Provide to Us**\n\n"
                    "We collect the information you provide us when you create an account, use our services, or communicate with us. This information may include your name, email address, phone number, payment information, and other personal information. We use this information to provide you with our services, communicate with you, and process your transactions.\n\n"
                    "**Your account information**\n\n"
                    "When you create an account with us, we collect your name, email address, phone number, and other personal information. We use this information to create and manage your account, provide you with our services, and communicate with you.\n\n"
                    "**Personal Information:** We may collect personal information such as your name, email address, phone number, and address when you register on our platform, place an order, or communicate with us. We may also collect information about your interests, preferences, and demographics to personalize your experience and improve our services.\n\n"
                    "**Transactional Information:** We may collect transactional information such as your purchase history, order details, and payment information when you place an order on our platform. This information is used to process your orders, provide customer support, and comply with legal requirements.\n\n"
                    "**Device Information:** We may collect device information such as your IP address, browser type, and operating system when you access our platform. We may use this information to detect and prevent fraudulent activities, improve our services, and analyze user behaviour.\n\n"
                    "...\n\n"
                    "**Contact Us**\n\n"
                    "If you have any questions or concerns about this Privacy Policy or our privacy practices, please contact us at support@gopotu.com.",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
    );

  }
}
