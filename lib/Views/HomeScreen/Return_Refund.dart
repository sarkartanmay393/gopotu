import 'package:flutter/material.dart';

import '../../DeviceManager/Colors.dart';

class Return_Refund extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child:  Icon(Icons.chevron_left_rounded,size: 35,color: Colors.white,),
        ),
        backgroundColor: AppColors.primary,
        title: Text('Return and Refund Policy',style: TextStyle(color: Colors.white),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "GOPOTU has a separate and no question ‘Refund and Return Policy. It allows all the members to return the products at the time of delivery under the Mart section if you are not satisfied with the quality of the packaging is open or affected due to some unknown reason. Our delivery partner will inform us of the return, and we will initiate the refund after checking the matter thoroughly. We also offer credit points of the same value as the product you returned, which you can use later for any purchase.\n\n"
                    "You can order your products from a single shop with a definite order ID; the order ID will be different for other shops and related products. We follow this policy to keep the products separate for easy return and refund. GOPOTU has a particular minimum cart value to avoid delivery charges in Mart and Food delivery section. If your order total is less than that, you need to pay an extra delivery charge as per the distance.\n\n"
                    "For all the sections of our products and services, if any user puts the wrong contact number or address and misses out on the service or delivery of the product, then GOPOTU is not responsible in any manner.\n\n"
                    "We have separate functioning for the three sections of our services, and so the policies are mentioned in the same manner individually below.\n\n"
                    "Policies for Mart Section\n\n"
                    "You can return or decline to accept the products you have ordered from our mart section at the time of delivery anytime. In that case, you will get a refund minus the delivery charges. But when you have ordered a product, you cannot change the item or quantity. You need to cancel that order for any changes and start afresh under a new order ID...\n\n"
                    "Policies for Food Delivery services\n\n"
                    "In this section, we have different policies for our restaurant-merchant collaborators. If the customers return the food for any reason or no reason, you have to accept those food items, and if customers require, you have to resend the order in the right manner to maintain our standard. Restaurants need to confirm the order after the order is placed. Once you confirm the order, you need to provide and deliver the food item ordered within the stipulated time. The total amount of business will be calculated and shared on the next business day, and we have a particular team of experts who take care of daily accounts with restaurants and different food joints. The payment date may get changed, and restaurant owners will be informed about the changes priorly, and the payments will be cleared without any discrepancies. GOPOTU will not pay for the cancelled products, and the restaurant has to accept them in this way. Customers also need to abide by some of the policies that our team has come up with. When the delivery person has reached your doorstep with the food, you cannot cancel your order. Also, the payment cannot be refunded further. If GOPOTU fails to receive or confirm the order after completing the payment, you will receive the refund within 5-7 working days. If there is an issue, you can contact our customer service section for further details. If GOPOTU cancels the order, we also initiate a refund within 5-7 working days.\n\n"
                    "Policies for services section\n\n"
                    "Customers need to read the guidelines minutely before booking services like personal care services. You must have the required space and facilities to avail of some of the services. Otherwise, your booking can go in vain. For home care services like electric wiring, appliance repair or servicing, you also need to explain the issue in detail to help us understand your requirement in detail. Once you have booked the services, you can cancel only before an hour and not after that. You are bound to pay a basic charge if no extra services have been required. But for situations where your home and personal care require something more, it will add extra to your bill. If you cancel the scheduled booking at the last moment, you have to pay the basic charge for the executive expert. The services provider salons, experts, and professionals must also maintain some guidelines. If they perform any extra services, they are supposed to mention that while closing the enquiry to keep a record for future requirements. All the services as per the client will be calculated on the next business day and will be paid within a week. Our team will also work on the compliant section and consult on these matters with the service providers. GOPOTU is the third party that connects the service providers with the customers.",
                style: TextStyle(fontSize: 16.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => _buildInstruction(item)).toList(),
    );
  }

  Widget _buildInstruction(String instruction) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Text('• $instruction'),
    );
  }
}

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
        // ));

