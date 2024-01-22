import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import '../Router/RouteConstants.dart';
import '../Store/HiveStore.dart';
import '../Store/ShareStore.dart';
import 'AppException.dart';
import 'Url.dart';

class CoreService {
  Future apiService({
    GlobalKey? key,
    header,
    body,
    bool multiPart = false,
    params,
    METHOD? method,
    SSL ssl = SSL.HTTPS,
    baseURL = baseUrl,
    endpoint,
    filePath,
    String? fileKey,
    attachmentList,
    nextFileKey,
    bool loader = true,
    bool isHome = false,
  }) async {
    if (await networkCheck()) {
      Get.snackbar(
        AppLabels.OfflineTitle,
        AppStrings.OfflineMessage,
        icon: Icon(
          Icons.signal_cellular_connected_no_internet_4_bar_sharp,
          color: AppColors.primary,
        ),
        titleText: Text(
          AppLabels.OfflineTitle,
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the title
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        messageText: Text(
          AppStrings.OfflineMessage,
          style: TextStyle(
            fontFamily:
                'Poppins', // Replace with the desired font family for the message
          ),
        ),
      );
    } else {
      var param;
      if (multiPart) {
        param = {
          'uploadType': params.toString(),
        };
      } else {
        param = params;
      }
      var endPoint = endpoint;
      var uri;
      if (ssl == SSL.HTTP) {
        uri =
            Uri.http(Uri.encodeFull(baseURL), Uri.encodeFull(endPoint), param);
      } else {
        uri =
            Uri.https(Uri.encodeFull(baseURL), Uri.encodeFull(endPoint), param);
      }

      Map<String, String> requestHeaders = method == METHOD.MULTIPART
          ? {
              'Content-type': 'multipart/form-data',
            }
          : {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            };
      if (header != null) {
        requestHeaders.addAll(header);
      }
      if (body != null && method != METHOD.MULTIPART) {
        body = json.encode(body);
      }
      debugPrint("Header :  $requestHeaders");
      debugPrint("Body :  $body");
      debugPrint("Params :  $params");
      debugPrint("URL :  $uri");
      debugPrint("Method :  $method");

      switch (method) {
        case METHOD.GET:
          {
            var responseJson;
            try {
              loader
                  ? Get.dialog(isHome ? homePageLoader() : normalLoader(),
                      barrierDismissible: false)
                  : Offstage();
              final response = await http
                  .get(uri, headers: requestHeaders)
                  .timeout(const Duration(minutes: 2));
              responseJson = _returnResponse(response, loader);
            } on UnauthorisedException catch (e) {
              print("EEEEE= $e");
              Get.back();
              Get.snackbar(
                "Sorry!",
                json.decode(e.getMessage())['message'],
                backgroundColor: AppColors.secondary,
                icon: Icon(
                  Icons.not_interested_rounded,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  "Sorry!",
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  json.decode(e.getMessage())['message'],
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );

              // Get.showSnackbar(GetSnackBar(
              //   snackPosition: SnackPosition.BOTTOM,
              //   message: json.decode(e.getMessage())['message'],
              //   duration: const Duration(seconds: 2),
              //   margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              // ));

              ShareStore().clear();
              HiveStore().delete(Keys.accessToken);
              HiveStore().delete(Keys.guestToken);
              HiveStore().delete(Keys.profileData);
              HiveStore().delete(Keys.userNumber);
              HiveStore().delete(Keys.shopType);
              HiveStore().delete(Keys.typeSelectIndex);
              HiveStore().delete(Keys.isDefaultAddressSet);
              HiveStore().put(Keys.landingShow, "true");
              Get.offAllNamed(signIn);
            } on SocketException {
              Get.back();
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
            } catch (error) {
              Get.back();
            }
            return responseJson;
          }

        case METHOD.PUT:
          {
            var responseJson;
            try {
              Get.dialog(isHome ? homePageLoader() : normalLoader(),
                  barrierDismissible: false);
              final response =
                  await http.put(uri, headers: requestHeaders, body: body);
              responseJson = _returnResponse(response, loader);
            } on SocketException {
              Get.back();
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
            } catch (error) {
              Get.back();
            }
            return responseJson;
          }

        case METHOD.DELETE:
          {
            var responseJson;
            try {
              final response = await http.delete(uri, headers: requestHeaders);
              responseJson = _returnResponse(response, loader);
            } on SocketException {
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              Get.back();
            } catch (error) {
              Get.back();
            }
            return responseJson;
          }

        case METHOD.PATCH:
          {
            var responseJson;
            try {
              Get.dialog(isHome ? homePageLoader() : normalLoader(),
                  barrierDismissible: false);
              final response =
                  await http.patch(uri, headers: requestHeaders, body: body);
              responseJson = _returnResponse(response, loader);
            } on SocketException {
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              Get.back();
            } catch (error) {
              Get.back();
            }
            return responseJson;
          }

        case METHOD.POST:
          {
            var responseJson;
            try {
              loader
                  ? Get.dialog(
                      isHome ? homePageLoader() : normalLoader(),
                      barrierDismissible: false,
                    )
                  : Offstage();
              debugPrint("body: $body");
              final response = await http
                  .post(uri, headers: requestHeaders, body: body)
                  .timeout(const Duration(minutes: 2));
              responseJson = _returnResponse(response, loader);
            } on UnauthorisedException catch (e) {
              print("EEEEE= $e");
              Get.back();
              Get.snackbar(
                "Sorry!",
                json.decode(e.getMessage())['message'],
                backgroundColor: AppColors.secondary,
                icon: Icon(
                  Icons.not_interested_rounded,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  "Sorry!",
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  json.decode(e.getMessage())['message'],
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );

              // Get.showSnackbar(GetSnackBar(
              //   snackPosition: SnackPosition.BOTTOM,
              //   message: json.decode(e.getMessage())['message'],
              //   duration: const Duration(seconds: 2),
              //   margin: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
              // ));

              ShareStore().clear();
              HiveStore().delete(Keys.accessToken);
              HiveStore().delete(Keys.guestToken);
              HiveStore().delete(Keys.profileData);
              HiveStore().delete(Keys.userNumber);
              HiveStore().delete(Keys.shopType);
              HiveStore().delete(Keys.typeSelectIndex);
              HiveStore().delete(Keys.isDefaultAddressSet);
              HiveStore().put(Keys.landingShow, "true");
              Get.offAllNamed(signIn);
            } on SocketException {
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              Get.back();
            } on Exception {
              Get.back();
              debugPrint("Exception block : Try again or revisit the screen.");
              Get.snackbar(
                "Server issue",
                "Please Try again or revisit the screen. ",
                icon: Icon(
                  Icons.not_interested_rounded,
                  color: AppColors.secondary,
                ),
                titleText: Text(
                  "Server issue",
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  "Please Try again or revisit the screen. ",
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              throw UnknownException("Try again or revisit the screen.");
            } catch (error) {
              Get.back();
              debugPrint("Catch block:  $error");
            }
            return responseJson;
          }

        case METHOD.MULTIPART:
          {
            var responseJson;
            Get.dialog(isHome ? homePageLoader() : normalLoader(),
                barrierDismissible: false);
            try {
              var request = http.MultipartRequest(
                'POST',
                uri,
              );
              if (header != null) {
                request.headers.addAll(header);
              }
              if (body != null) {
                request.fields.addAll(body);
              }
              if (filePath is RxList<File>) {
                List<http.MultipartFile> data = <http.MultipartFile>[];
                for (int i = 0; i < filePath.length; i++) {
                  final mimeTypeData = lookupMimeType(filePath[i].path,
                          headerBytes: [0xFF, 0xD8])!
                      .split('/');
                  data.add(await http.MultipartFile.fromPath(
                      '$fileKey[$i]', filePath[i].path,
                      contentType:
                          MediaType(mimeTypeData[0], mimeTypeData[1])));
                }
                request.files.addAll(data);
              } else {
                //request.fields.addAll(body);
                final mimeTypeData =
                    lookupMimeType(filePath, headerBytes: [0xFF, 0xD8])!
                        .split('/');
                request.files.add(await http.MultipartFile.fromPath(
                    fileKey!, filePath,
                    contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
                debugPrint("Request : $request");
              }
              if (attachmentList != null && nextFileKey != null) {
                if (attachmentList is RxList<File>) {
                  List<http.MultipartFile> data = <http.MultipartFile>[];
                  for (int i = 0; i < filePath.length; i++) {
                    final mimeTypeData = lookupMimeType(filePath[i].path,
                            headerBytes: [0xFF, 0xD8])!
                        .split('/');
                    data.add(await http.MultipartFile.fromPath(
                        '$nextFileKey[$i]', attachmentList[i].path,
                        contentType:
                            MediaType(mimeTypeData[0], mimeTypeData[1])));
                  }
                  request.files.addAll(data);
                } else {
                  final mimeTypeData =
                      lookupMimeType(filePath, headerBytes: [0xFF, 0xD8])!
                          .split('/');
                  request.files.add(await http.MultipartFile.fromPath(
                      nextFileKey, attachmentList,
                      contentType:
                          MediaType(mimeTypeData[0], mimeTypeData[1])));
                  debugPrint("Request : $request");
                }
              }
              final http.StreamedResponse response = await request.send();
              debugPrint(response.reasonPhrase);
              responseJson = await http.Response.fromStream(response);
              responseJson = _returnResponse(responseJson, loader);
            } on SocketException {
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              Get.back();
            } catch (error) {
              debugPrint(error.toString());
              Get.back();
            }
            return responseJson;
          }

        default:
          {
            var responseJson;
            try {
              Get.dialog(
                  Center(
                      child: CircularProgressIndicator(
                    color: AppColors.primary,
                  )),
                  barrierDismissible: false);
              final response =
                  await http.post(uri, headers: requestHeaders, body: body);
              responseJson = _returnResponse(response, loader);
            } on SocketException {
              Get.snackbar(
                AppLabels.OfflineTitle,
                AppStrings.OfflineMessage,
                icon: Icon(
                  Icons.signal_cellular_connected_no_internet_4_bar_sharp,
                  color: AppColors.primary,
                ),
                titleText: Text(
                  AppLabels.OfflineTitle,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the title
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                messageText: Text(
                  AppStrings.OfflineMessage,
                  style: TextStyle(
                    fontFamily:
                        'Poppins', // Replace with the desired font family for the message
                  ),
                ),
              );
              Get.back();
            } catch (error) {
              Get.back();
            }
            return responseJson;
          }
      }
    }
  }

  dynamic _returnResponse(http.Response response, loader) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json
            .decode(Utf8Decoder().convert(response.body.toString().codeUnits));
        debugPrint("Result : $responseJson");
        loader ? Get.back() : Offstage();
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occurred while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }

  Future<bool> networkCheck() async {
    try {
      final result = await InternetAddress.lookup('$baseUrl');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return false;
      } else {
        return true;
      }
    } on SocketException catch (_) {
      return true;
    }
  }

  Widget homePageLoader() {
    return Center(
      child: Container(
        height: ScreenConstant.defaultHeightSeventy,
        width: ScreenConstant.defaultHeightSeventy,
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            Assets.loadingGif,
          ),
        )),
      ),
    );
  }

  // Widget normalLoader() {
  //   return Center(
  //     child: Container(
  //       height: ScreenConstant.defaultHeightSeventy,
  //       width: ScreenConstant.defaultHeightSeventy,
  //       decoration: BoxDecoration(
  //           image: DecorationImage(
  //         image: AssetImage(
  //           Assets.loadingGif,
  //         ),
  //       )),
  //     ),
  //   );
  // }

  Widget normalLoader() {
    return Center(
        child: Container(
            height: ScreenConstant.sizeXXL,
            width: ScreenConstant.sizeXXL,
            decoration: BoxDecoration(
                color: AppColors.secondary,
                border: Border.all(
                  color: AppColors.secondary,
                ),
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: CircularProgressIndicator(
                color: AppColors.primary,
                strokeWidth: 1.5,
              ),
            )));
  }
}

enum METHOD {
  GET,
  PUT,
  POST,
  DELETE,
  PATCH,
  MULTIPART,
}

enum SSL {
  HTTP,
  HTTPS,
}
