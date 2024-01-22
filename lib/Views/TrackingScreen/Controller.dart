import 'dart:convert';
import 'package:http/http.dart' as http;

import 'OrderTrackingResponseModel.dart';

class ApiController {
  final String apiUrl;

  ApiController(this.apiUrl);

  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Replace these class names with the actual class names you've defined
        ApiResponse apiResponse = ApiResponse.fromJson(jsonResponse);

        Order orderData = Order.fromJson(apiResponse.data.order as Map<String, dynamic>);


        int orderId = orderData.id;
        int shopId = orderData.shopId;
        String orderType = orderData.type;
        String customerName = orderData.custName;
        // ... access other order details

        List<Banner> bannerDataList = (apiResponse.data.banner as List<dynamic>)
            .map<Banner>((banner) => Banner.fromJson(banner))
            .toList();

        Shop shop = orderData.shop;
        int shopIdFromOrder = shop.id;
        String shopName = shop.shopName;

        // ... access other shop details

        // Access other values as needed

      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
