import 'package:file/file.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_potu_user/Controller/ProfileController/ProfileController.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextFieldValidators.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';
import 'package:go_potu_user/GlobalConstants/StringConstants/Strings.dart';
import 'package:go_potu_user/Store/HiveStore.dart';
import 'package:go_potu_user/Widgets/AppButtonWidget/AppButtonWidget.dart';
import 'package:go_potu_user/Widgets/TextFieldWidgets/RequireTextField.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileDetails extends StatefulWidget {
  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  final ProfileController _profileController = Get.put(ProfileController());

  final ProfileController profileController = Get.find();

  Future<bool> _onBackPressed() {
    if (_profileController.name.text == null ||
        _profileController.name.text.isEmpty ||
        HiveStore().get(Keys.profileData)['name'] !=
            _profileController.name.text) {
      _profileController.name.text = HiveStore().get(Keys.profileData)['name'];
    }
    Get.back();
    return Future.value(false);
  }

  Uint8List? _image;

  File? SelectImage;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: AppColors.secondary,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: AppColors.primary,
            elevation: 0,
            title: Text(
              "My Profile",
              style: TextStyles.appBarTitle,
            ),
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
          ),
          body: Column(
            children: [
              SizedBox(
                height: ScreenConstant.defaultHeightForty,
              ),
              // Container(
              //   height: ScreenConstant.defaultHeightOneHundred,
              //   width: ScreenConstant.defaultHeightOneHundred,
              //   decoration: BoxDecoration(
              //     shape: BoxShape.circle,
              //     color: AppColors.primary,
              //     border: Border.all(
              //       width: 5,
              //       color: AppColors.profileCircleBorder,
              //     ),
              //   ),
              //   child: Obx(() => Center(
              //           child: Text(
              //         profileController.profileName
              //             .toString()
              //             .substring(0, 1)
              //             .toUpperCase(),
              //         style: TextStyles.profileNameFirstLetter,
              //       ))),
              // ),
              Container(
                height: ScreenConstant.sizeMedium,
              ),
              Center(
                child: Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            backgroundImage: MemoryImage(_image!),
                            radius: 100,
                          )
                        : CircleAvatar(
                      backgroundImage: AssetImage(
                          "assets/profile (1).png"),
                            radius: 80,
                          ),
                    Positioned(
                        bottom: -0,
                        left: 110,
                        child: IconButton(
                            onPressed: () {
                              showImagePickerOption(context);
                            },
                            icon: Container(
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle),
                                height: ScreenConstant.sizeExtraLarge,
                                width: ScreenConstant.sizeExtraLarge,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: ScreenConstant.defaultWidthTwenty,
                                  color: Colors.white,
                                ))))
                  ],
                ),
              ),
              // Obx(
              //   () => Text(
              //     profileController.profileName.toUpperCase(),
              //     style: TextStyles.profileName,
              //   ),
              // ),
              Container(
                height: ScreenConstant.sizeExtraSmall,
              ),
              Text(
                "+91 ${HiveStore().get(Keys.profileData)['mobile']}",
                style: TextStyles.profileContact,
              ),
              Container(
                height: ScreenConstant.sizeLarge,
              ),
              ListView(
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenConstant.sizeLarge),
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                children: [
                  Container(
                    height: ScreenConstant.sizeXXXL,
                  ),
                  Text(
                    "First Name",
                    style: TextStyles.textFieldHints,
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  Container(
                    height: ScreenConstant.defaultHeightFortyFive,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: RequireTextField(
                        type: Type.fullName,
                        controller: _profileController.name),
                  ),
                  Container(
                    height: ScreenConstant.sizeMedium,
                  ),
                  /*Text(AppStrings.lastName,style: TextStyles.textFieldHints,),
                Container(
                  height: ScreenConstant.sizeExtraSmall,
                ),
                RequireTextField(
                  //controller: _signUpController.lastNameController,
                  type: Type.userLName,
                ),
                Container(
                  height: ScreenConstant.sizeMedium,
                ),*/
                  Text(
                    AppStrings.email,
                    style: TextStyles.textFieldHints,
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autofocus: false,
                    maxLines: 1,
                    style: TextStyles.textFieldText,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) => Validator.validateEmail(value!),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFF6F5F8),
                      enabled: false,
                      hintText: "${HiveStore().get(Keys.profileData)['email']}",
                      hintStyle: TextStyles.hintTextFieldHints,
                      contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
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
                    AppStrings.mobileNumber,
                    style: TextStyles.textFieldHints,
                  ),
                  Container(
                    height: ScreenConstant.sizeExtraSmall,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    autofocus: false,
                    maxLines: 1,
                    style: TextStyles.textFieldText,
                    decoration: InputDecoration(
                      hintText:
                          "+91 ${HiveStore().get(Keys.profileData)['mobile']}",
                      hintStyle: TextStyles.hintTextFieldHints,
                      contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
                      filled: true,
                      fillColor: Color(0xFFF6F5F8),
                      enabled: false,
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
                  /*RequireTextField(
                  hintText: "+91 ${HiveStore().get(Keys.profileData)['mobile']}",
                  // controller: _signInController.numberController,
                  enable: false,
                  type: Type.phone,
                ),*/
                  Container(
                    height: ScreenConstant.sizeXXXL,
                  ),
                  // AppButton(
                  //   elevation: 0,
                  //   buttonText: AppStrings.UpdateDetails,
                  //   onPressed: () {
                  //     FocusScope.of(context).unfocus();
                  //     _profileController.editProfilePress();
                  //   },
                  //   color: AppColors.buttonColorSecondary,
                  //   textStyle: TextStyles.bottomTextStyle,
                  // ),
                ],
              ),
            ],
          ),
          // bottomNavigationBar: BottomNavigationBar(
          //   showUnselectedLabels: true,
          //   unselectedItemColor: Colors.black,
          //   selectedItemColor: Colors.red,
          //   items: <BottomNavigationBarItem>[
          //     BottomNavigationBarItem(
          //       icon: Container(
          //           height: ScreenConstant.defaultHeightForty,
          //           width: ScreenConstant.defaultHeightTwentyfive,
          //           child: Image.asset(
          //             "assets/Vectorhome.png",
          //           )),
          //       label: 'Home',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Container(
          //           height: ScreenConstant.defaultHeightForty,
          //           width: ScreenConstant.defaultHeightTwentyfive,
          //           child: Image.asset(
          //             "assets/orders.png",
          //           )),
          //       label: 'My Orders',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Container(
          //           height: ScreenConstant.defaultHeightForty,
          //           width: ScreenConstant.defaultHeightTwentyfive,
          //           child: Image.asset("assets/categories.png")),
          //       label: 'Categories',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Container(
          //           height: ScreenConstant.defaultHeightForty,
          //           width: ScreenConstant.defaultHeightTwentyfive,
          //           child: Image.asset("assets/Group.png")),
          //       label: 'Cart',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Container(
          //           height: ScreenConstant.defaultHeightForty,
          //           width: ScreenConstant.defaultHeightTwentyfive,
          //           child: Image.asset("assets/profile.png")),
          //       label: 'Profile',
          //     ),
          //   ],
          // )
      ),
    );
  }
}

void showImagePickerOption(BuildContext context) {
  showModalBottomSheet(
      context: context,
      builder: (builder) {
        return SizedBox(
          height: ScreenConstant.defaultHeightTwoHundred,
          width: 500,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 80),
                child: InkWell(
                  onTap: (() {
                    _pickImageFromGallery();
                  }),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.image,
                          size: 80,
                        ),
                        Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: ScreenConstant.defaultHeightTwentyeight,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, top: 80),
                child: InkWell(
                  onTap: (() {
                    _pickImageFromCamera();
                  }),
                  child: SizedBox(
                    child: Column(
                      children: [
                        Icon(
                          Icons.camera_alt,
                          size: 80,
                        ),
                        Text(
                          "Camera",
                          style: TextStyle(
                            fontSize: FontSizeStatic.maxMd,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      });
}

void _pickImageFromGallery() async {
  final returnImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (returnImage == null) return;
}

Future _pickImageFromCamera() async {
  final returnImage = await ImagePicker().pickImage(source: ImageSource.camera);
  if (returnImage == null) return;
}
