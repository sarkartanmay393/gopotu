import 'package:flutter/material.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

class About_us extends StatefulWidget {
  const About_us({Key? key}) : super(key: key);

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
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
            "About Gopotu",
            style: TextStyles.appBarTitle,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GOPOTU, a one-stop solution to all your requirements, is now available at the play store. We have come up with a list of services for our users divided into three main categories: **shopping cart**, **services related to your home**, and **food delivery**. We have started our functioning in Malda, West Bengal, soon covering the complete state.\n\n"
                    "As our tagline suggests, we can help you with any possible solution to your daily problems anytime affordably and reliably. You need to download the app and enter it when you need something in **grocery or other items for your household**. GOPOTU provides the most expert mechanic to offer you satisfactory experiences for **electric repairing, appliance services, and others**. Besides every other regular requirement, **food delivery** is much in demand. So, we are offering that too as well. One app will serve you with all your requirements, and you don’t need to keep three-four different applications for these requirements.\n\n"
                    "Starting in 2021, GOPOTU aims to serve the entire household with the best quality possible at the most affordable rate. You need to download the app and create your profile for use. Our app will create a revolution in the service industry by offering shopping facilities, food delivery services, household requirements, and repair services under one roof.\n\n"
                    "**Our team**\n\n"
                    "We have a team of experts with long-term experience in this field. We only hire experienced and professional experts to ensure the best performance of every sector. **Delivery boys** that work with us maintain professional conduct while offering their services and prioritize customer satisfaction above anything else. Not only experience, but we also ensure that our experts are completely certified and have a basic idea about the industry.\n\n"
                    "We have a separate **customer care team** for every section of our services to manage the complaints and control the disputes dedicatedly. Our team members know the mission, vision, return policy, and other details related to the application to help the users in any given situation. You can rely upon us to get the best service at an affordable rate.\n\n"
                    "**Why choose GOPOTU?**\n\n"
                    "GOPOTU is the first initiative of this range in West Bengal. We have started our journey from Malda and soon will reach different parts of the state. No other application has offered such a huge collection of services before this and in an organized manner. We have a dedicated team for every section, with specialized knowledge to lead that section and develop better and more innovative ideas to serve our potential customer base.\n\n"
                    "We have an expert team of professionals who handle the functioning, services, and deliveries dedicatedly for their respective sections. Also, we have come up with the latest technological support to maintain our software to avoid any discrepancy when maximum users are using the app simultaneously across the state. Experienced professionals have created the app, keeping all the basic requirements in mind, as three sections work to keep the functioning smooth, hassle-free, and unaffected by each other. Rely on us; GOPOTU is always there with all the customers.",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: BottomNavigationBar(
        //   showUnselectedLabels: true,
        //   unselectedItemColor: Colors.black,
        //   selectedItemColor: Colors.red,
        //   items: <BottomNavigationBarItem>[
        //     BottomNavigationBarItem(
        //       icon: Container(
        //           height: ScreenConstant.defaultHeightForty,
        //           width: ScreenConstant.defaultHeightTwentyThree,
        //           child: Image.asset(
        //             "assets/Vectorhome.png",
        //           )),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Container(
        //           height: ScreenConstant.defaultHeightForty,
        //           width: ScreenConstant.defaultHeightTwentyThree,
        //           child: Image.asset(
        //             "assets/myorders.png",
        //           )),
        //       label: 'My Orders',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Container(
        //           height: ScreenConstant.defaultHeightForty,
        //           width: ScreenConstant.defaultHeightTwentyThree,
        //           child: Image.asset("assets/categories.png")),
        //       label: 'Categories',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Container(
        //           height: ScreenConstant.defaultHeightForty,
        //           width: ScreenConstant.defaultHeightTwentyThree,
        //           child: Image.asset("assets/cart.png")),
        //       label: 'Cart',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Container(
        //           height: ScreenConstant.defaultHeightForty,
        //           width: ScreenConstant.defaultHeightTwentyThree,
        //           child: Image.asset("assets/profile.png")),
        //       label: 'Profile',
        //     ),
        //   ],
        // )
    );
  }
}
