import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/SupportTicketController/SupportTicketController.dart';
import 'package:go_potu_user/DeviceManager/Assets.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';

class CustomerCareService extends StatefulWidget {
  CustomerCareService({Key? key}) : super(key: key);

  @override
  State<CustomerCareService> createState() => _CustomerCareServiceState();
}

class _CustomerCareServiceState extends State<CustomerCareService> {
  final SupportTicketController supportController =
      Get.put(SupportTicketController());

  @override
  Widget build(BuildContext context) {
    String userIdString = HiveStore().get(Keys.loginUserId);
    print("userIdString : ${userIdString}");
    return Scaffold(
      backgroundColor: AppColors.secondary,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.primary,
        elevation: 0,
        title: Text(
          AppStrings.NeedHelp,
          style: TextStyles.appBarTitle,
        ),
      ),
      body: Obx(() => ListView(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            children: [
              Image(
                image: AssetImage(Assets.supportImage),
              ),
              Container(
                color: AppColors.gapColor,
                height: ScreenConstant.sizeMedium,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: ScreenConstant.sizeExtraLarge,
                    right: ScreenConstant.sizeExtraLarge,
                    top: ScreenConstant.sizeExtraLarge),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Share your problem/ Suggestions with us",
                        style: TextStyles.shareYour),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    Text(
                      "Name",
                      style: TextStyles.textFieldHints,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    RequireTextField(
                      controller: supportController.nameController!,
                      type: Type.fullName,
                    ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    userIdString.isNumericOnly
                        ? Text(
                            "Registered Contact Number",
                            style: TextStyles.textFieldHints,
                          )
                        : Text(
                            "Registered Mail Id",
                            style: TextStyles.textFieldHints,
                          ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    userIdString.isNumericOnly
                        ? RequireTextField(
                            //controller: supportController.nameController,
                            type: Type.phone,
                            hintText:
                                "+91 ${HiveStore().get(Keys.loginUserId)}",
                            enable: false,
                          )
                        : RequireTextField(
                            //controller: supportController.nameController,
                            type: Type.phone,
                            hintText: "${HiveStore().get(Keys.loginUserId)}",
                            enable: false,
                          ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    Text(
                      "Alternative Contact Number",
                      style: TextStyles.textFieldHints,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    RequireTextField(
                      controller: supportController.alternativePhoneController,
                      type: Type.phone,
                    ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    supportController.isCancel.value
                        ? Text(
                            "Your Order ID",
                            style: TextStyles.textFieldHints,
                          )
                        : Offstage(),
                    supportController.isCancel.value
                        ? Container(
                            height: ScreenConstant.sizeExtraSmall,
                          )
                        : Offstage(),
                    supportController.isCancel.value
                        ? TextFormField(
                            controller: supportController.orderIdController,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            style: TextStyles.textFieldText,
                            decoration: InputDecoration(
                              enabled: false,
                              filled: true,
                              fillColor: Color(0xFFF6F5F8),
                              contentPadding:
                                  EdgeInsets.all(ScreenConstant.sizeSmall),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          )
                        : Offstage(),
                    supportController.isCancel.value
                        ? Container(
                            height: ScreenConstant.sizeMedium,
                          )
                        : Offstage(),
                    Text(
                      "Issue Type",
                      style: TextStyles.textFieldHints,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    supportController.isCancel.value
                        ? Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              side: new BorderSide(
                                  color: AppColors.textFieldBorderColor,
                                  width: 1.0),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ListTile(
                              title: Center(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    value: supportController.cancelReason.value,
                                    onChanged: (newValue) {
                                      setState(() {
                                        supportController.cancelReason.value =
                                            newValue!;
                                        print(
                                            "supportController.cancelReason.value: ${supportController.cancelReason.value}");
                                      });
                                    },
                                    items:
                                        <String>["Cancel Order"]?.map((type) {
                                      return DropdownMenuItem<String>(
                                        child: new Text(
                                          type,
                                          style: TextStyles.orderIdTitle,
                                        ),
                                        value: type,
                                      );
                                    })?.toList(),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : TextFormField(
                            controller: supportController.issueTypeController,
                            keyboardType: TextInputType.name,
                            autofocus: false,
                            style: TextStyles.textFieldText,
                            decoration: InputDecoration(
                              filled: true,
                              enabled: false,
                              fillColor: Color(0xFFF6F5F8),
                              contentPadding:
                                  EdgeInsets.all(ScreenConstant.sizeSmall),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: AppColors.textFieldBorderColor,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    width: 1.0,
                                    style: BorderStyle.solid),
                              ),
                            ),
                          ),
                    Container(
                      height: ScreenConstant.sizeMedium,
                    ),
                    Text(
                      "Issue Details",
                      style: TextStyles.textFieldHints,
                    ),
                    Container(
                      height: ScreenConstant.sizeExtraSmall,
                    ),
                    TextFormField(
                      controller: supportController.issueDetailsController,
                      keyboardType: TextInputType.name,
                      autofocus: false,
                      maxLength: 500,
                      maxLines: 5,
                      style: TextStyles.textFieldText,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.all(ScreenConstant.sizeSmall),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: AppColors.textFieldBorderColor,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.redAccent,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.redAccent,
                              width: 1.0,
                              style: BorderStyle.solid),
                        ),
                      ),
                    ),
                    Container(
                      height: ScreenConstant.sizeSmall,
                    ),
                  ],
                ),
              ),
              /*Padding(
            padding:  EdgeInsets.only(left: ScreenConstant.sizeLarge),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Checkbox(
                    value: false, onChanged: (h){}
                    ),
                RichText(
                  text: TextSpan(
                    text: "Accept Order Replace Policy. ",
                    style: TextStyles.doNotAccount,
                    children: <TextSpan>[
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                           // Get.offAllNamed(signUp);
                          },
                        text: "Read it",
                        style: TextStyles.newAccount,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),*/
              Padding(
                padding: EdgeInsets.all(ScreenConstant.sizeExtraLarge),
                child: AppButton(
                  elevation: 0,
                  buttonText: AppStrings.RequestNow,
                  onPressed: () {
                    FocusManager.instance.primaryFocus!.unfocus();
                    supportController.supportPress();
                  },
                  textStyle: TextStyles.bottomTextStyle,
                ),
              ),
            ],
          )),
    );
  }
}
