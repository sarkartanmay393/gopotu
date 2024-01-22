import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_potu_user/DeviceManager/Colors.dart';
import 'package:go_potu_user/DeviceManager/ScreenConstants.dart';
import 'package:go_potu_user/DeviceManager/TextFieldValidators.dart';
import 'package:go_potu_user/DeviceManager/TextStyles.dart';

enum Type {
  addressLine,
  landmark,
  emailOrPhone,
  passWord,
  signInPassWord,
  name,
  postalCode,
  emailandphone,
  phone,
  email,
  useremail,
  sNo,
  otp,
  verifiedEmail,
  verifiedPhone,
  verifiedSNo,
  biography,
  date,
  location,
  IBAN,
  autoCompleteFacility,
  autoCompleteStudy,
  autoCompleteDiploma,
  autoCompleteCertifications,
  autoCompleteLang,
  autoNationality,
  userFirstName,
  userLastName,
  userMobile,
  userFName,
  userLName,
  userName,
  confirmPass,
  fullName
}

// ignore: must_be_immutable
class RequireTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Type type;
  final caption;
  var errorFree;
  FocusNode? myFocusNode;
  final hintText;
  final mobileNumber;
  final readWriteStatus;
  final onTap;
  final labelText;
  final autoValidate;
  final autoSubmit;
  final verified;
  final suggestions;
  final autoKey;
  final isPast;
  final enable;
  final maxLine;
  //final RxList<AllLanguage> resultList;

  RequireTextField({
    required this.type,
    this.controller,
    this.caption,
    this.errorFree,
    this.myFocusNode,
    this.hintText,
    this.mobileNumber,
    this.readWriteStatus,
    this.onTap,
    this.labelText,
    this.autoValidate,
    this.autoSubmit,
    this.verified = false,
    this.suggestions,
    this.autoKey,
    this.isPast = false,
    this.enable = true,
    this.maxLine = 1,
    //this.resultList,
  });

  @override
  _RequireTextFieldState createState() => _RequireTextFieldState();
}

class _RequireTextFieldState extends State<RequireTextField> {
  late TextEditingController _controller;
  late Type type;

  var _value;

  bool _errorFree = true;

  bool validate = false;

  get errorFree => _errorFree;

  Type get _type => widget.type ?? _type;
  var searchTextField;

  TextEditingController get _thisController => widget.controller ?? _controller;
  late GlobalKey<NavigatorState> navigatorKey;
  bool indicator = true;

  @override
  void initState() {
    super.initState();
    navigatorKey = new GlobalKey<NavigatorState>();
    if (widget.controller == null) {
      _controller = TextEditingController(text: '');
    } else {
      widget.controller!.addListener(_handleControllerChanged);
    }
    if (widget.mobileNumber != null) {
      _thisController.text = widget.mobileNumber;
    }
  }

  void _handleControllerChanged() {
    if (_thisController.text != _value || _value.trim().isNotEmpty)
      didChange(_thisController.text);
  }

  void didChange(var value) {
    setState(() {
      _value = value;
    });
  }

  @override
  void didUpdateWidget(RequireTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null)
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      if (widget.controller != null) {
        _thisController.text = widget.controller!.text;
        if (oldWidget.controller == null) _controller;
      }
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case Type.userFName:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: widget.maxLine,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateFName(value!)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
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
          );
        }
        break;
      case Type.userFirstName:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: widget.maxLine,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateFName(value!)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }
        break;
      case Type.fullName:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: widget.maxLine,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateFullName(value!)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
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
          );
        }
        break;
      case Type.userLName:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateLName(value!)),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
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
          );
        }
        break;
      case Type.userLastName:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateLName(value!)),
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }
        break;

      case Type.passWord:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            obscureText: indicator,
            maxLines: 1,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ],
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validatePassword(value!);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              suffixIcon: IconButton(
                icon: Icon(
                  indicator ? Icons.visibility_off_rounded : Icons.visibility,
                  color: Colors.black,
                  size: ScreenConstant.sizeLarge,
                ),
                onPressed: () {
                  setState(() {
                    indicator = !indicator;
                  });
                },
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
          );
        }
        break;

      case Type.confirmPass:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            obscureText: indicator,
            maxLines: 1,
            inputFormatters: [
              LengthLimitingTextInputFormatter(30),
            ],
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateEmailAndMobile(value);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              suffixIcon: IconButton(
                icon: Icon(
                  indicator ? Icons.visibility_off_rounded : Icons.visibility,
                  color: Colors.black,
                  size: ScreenConstant.sizeLarge,
                ),
                onPressed: () {
                  setState(() {
                    indicator = !indicator;
                  });
                },
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
          );
        }
        break;

      case Type.emailandphone:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.text,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateEmailAndMobile(value);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              filled: widget.enable ? false : true,
              fillColor: widget.enable ? Colors.white : Color(0xFFF6F5F8),
              enabled: widget.enable,
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
          );
        }
        break;

      case Type.phone:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.number,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateMobile(value!);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              filled: widget.enable ? false : true,
              fillColor: widget.enable ? Colors.white : Color(0xFFF6F5F8),
              enabled: widget.enable,
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
          );
        }
        break;
      case Type.userMobile:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.number,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateMobile(value!);
            },
            inputFormatters: [
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              filled: true,
              fillColor: Colors.grey.shade200,
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          );
        }
        break;

      case Type.email:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateEmail(value);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
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
          );
        }
        break;
      case Type.useremail:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.emailAddress,
            autofocus: false,
            maxLines: 1,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return Validator.validateEmail(value);
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: AppColors.textFieldBorderColor,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.redAccent,
                    width: 1.0,
                    style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          );
        }
        break;
      case Type.addressLine:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: widget.maxLine,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateAddressLine(value!)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
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
          );
        }
        break;
      case Type.landmark:
        {
          return TextFormField(
            controller: _thisController,
            keyboardType: TextInputType.name,
            autofocus: false,
            maxLines: widget.maxLine,
            style: TextStyles.textFieldText,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: ((value) => validateLandmark(value!)),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(ScreenConstant.sizeSmall),
              hintText: widget.hintText,
              hintStyle: TextStyles.hintTextFieldHints,
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
          );
        }
        break;

      default:
        {
          return Container();
        }
        break;
    }
  }

  void toggle() {
    setState(() {
      indicator = !indicator;
    });
  }

  // String validateMobile(String value) {
  //   String pattern = r'(^[0-9]*$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value?.length == 0) {
  //     return "validateMobile";
  //   } else if (value.length <= 8) {
  //     return "validateMobile";
  //   } else if (value.length > 10) {
  //     return "validateMobile";
  //   } else if (!regExp.hasMatch(value)) {
  //     return "validateMobile";
  //   }
  //   return null;
  // }

  String? validateMobile(String value) {
    String pattern = r'(^[0-9]*$)';
    RegExp regExp = RegExp(pattern);

    if (value == null || value.isEmpty) {
      return "Mobile number is required.";
    } else if (value.length < 10) {
      return "Mobile number should be at least 10 digits.";
    } else if (value.length > 10) {
      return "Mobile number should not exceed 10 digits.";
    } else if (!regExp.hasMatch(value)) {
      return "Mobile number should contain only digits.";
    }

    return null;
  }

  String? validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "validateEmail";
    } else if (!regExp.hasMatch(value)) {
      return "validateEmail";
    } else {
      return null;
    }
  }

  String? validateFName(String value) {
    if (value.length == 0) {
      return "First name required";
    } else {
      return null;
    }
  }

  String? validateLandmark(String value) {
    if (value.length == 0) {
      return "LandMark is required";
    } else {
      return null;
    }
  }

  String? validateAddressLine(String value) {
    if (value.length == 0) {
      return "Address Line is required";
    } else {
      return null;
    }
  }

  String? validateFullName(String value) {
    if (value.length == 0) {
      return "Full name required";
    } else {
      return null;
    }
  }

  String? validateLName(String value) {
    if (value.length == 0) {
      return "Last name required";
    } else {
      return null;
    }
  }

  String? validatePassword(String value) {
    String pattern =
        r"(^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&.*':;€#])[A-Za-z\d@$!%*?&.*':;€#]{8,}$)";
    RegExp regExp = new RegExp(pattern);
    if (value.length < 6) {
      return "Wrong Ppass";
    } else if (!regExp.hasMatch(value)) {
      return "Wrong Ppass";
    }
    return null;
  }

  String? validateSignInPassword(String value) {
    String pattern =
        r"(^(?=.*[a-z])(?=.*[A-Z])(?=.*[@$!%*?&.*':;€#])[A-Za-z\d@$!%*?&.*':;€#]{8,}$)";
    RegExp regExp = new RegExp(pattern);
    if (value.length < 6) {
      return "validateSignInPassword";
    } else if (!regExp.hasMatch(value)) {
      return "validateSignInPassword";
    }
    return null;
  }
}
