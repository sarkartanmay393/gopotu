import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../DeviceManager/Colors.dart';
import 'ScreenConstants.dart';

class TextStyles {
  static TextStyle get splashBottomTitle => TextStyle(
      color: AppColors.splashBottomTitle,
      fontSize: FontSizeStatic.sm,
      /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get splashBottomSubTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get landingNext => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get getStarted => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get loginTitle => TextStyle(
      color: AppColors.loginTitle,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get loginSubTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.sm,
      /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get textFieldHints => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get hintTextFieldHints => TextStyle(
        color: AppColors.deliveryBoyExp,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get doNotAccount => TextStyle(
      color: AppColors.doNotAccount,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get newAccount => TextStyle(
      color: AppColors.createNewAccountText,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get bottomTextStyle => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get bottomTextStyle2 => TextStyle(
      color: AppColors.buttonColorSecondary,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get textFieldText => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get otpTitleText => TextStyle(
      color: AppColors.loginTitle,
      fontSize: FontSizeStatic.xxl,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get otpSubTitleText => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get addressListTitleText => TextStyle(
      color: AppColors.addressListTitle,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get addressListWidgetContainTitle => TextStyle(
      color: AppColors.addressListWidgetContainsColor,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get addressListWidgetContainSubTitle => TextStyle(
        color: AppColors.addressListWidgetContainsColor,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get addressType1 => TextStyle(
        color: AppColors.secondary,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get addressType2 => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get homeScreenAppBarTitle => TextStyle(
        color: AppColors.secondary,
        fontSize: FontSizeStatic.semiSm,
        overflow: TextOverflow.ellipsis,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get searchWidgetLevelText => TextStyle(
        color: AppColors.searchLevelText,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get categoryChangeText1 => TextStyle(
        color: AppColors.dashBoardChangeCategoryText2,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get categoryChangeText2 => TextStyle(
      color: AppColors.dashBoardChangeCategoryText,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get categoryChangeBottomText => TextStyle(
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get topStoreText => TextStyle(
      color: AppColors.topStoreForText,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get topStoreTitle => TextStyle(
      color: AppColors.topStoreStoreTitle,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get featuredCategoryTitle => TextStyle(
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get topStoreSubTitle => TextStyle(
        color: AppColors.topStoreStoreSubTitle,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get storeCount => TextStyle(
      color: AppColors.topStoreForText,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get viewAll => TextStyle(
        color: AppColors.viewAll,
        fontSize: FontSizeStatic.md,
        fontWeight: FontWeight.bold,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get storeDistance => TextStyle(
        color: AppColors.storeDistance,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get productTitle => TextStyle(
      color: AppColors.productTitle,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get productSubTitle => TextStyle(
        color: AppColors.topStoreStoreSubTitle,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get rate => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get chooseCategoryTitle => TextStyle(
      color: AppColors.shopCategory,
      fontSize: FontSizeStatic.xl,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get chooseCategorySubTitle => TextStyle(
        color: AppColors.searchLevelText,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get categoryTitle => TextStyle(
      color: AppColors.addressListTitle,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get categorySubTitle => TextStyle(
        color: AppColors.addressListWidgetContainsColor,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get appBarTitle => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.lg,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get manageOrder => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get orderIdTitle => TextStyle(
        color: AppColors.orderId,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get orderId => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get moreProductIndicator => TextStyle(
        color: AppColors.filterBox,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get productListTitleOnOrderListing => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.mdSm,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get productListSubTitleOnOrderListing => TextStyle(
        color: AppColors.orderId,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get productListSubTitleOnOrderListing2 => TextStyle(
        color: AppColors.ordersStatusBox3,
        fontSize: FontSizeStatic.semiSm,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get filterTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get filterContain => TextStyle(
        color: AppColors.ordersStatusBox3,
        fontSize: FontSizeStatic.md,
        /* /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins' */ fontFamily:
            'Poppins',
      );
  static TextStyle get orderDetails => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get deliveryBoyNameFirst => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.xxl,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get deliveryBoyName => TextStyle(
      color: AppColors.orderId,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get deliveryBoyWorkExp => TextStyle(
        color: AppColors.deliveryBoyExp,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get couponCode => TextStyle(
        color: AppColors.couponCode,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get total => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get amountSaveText => TextStyle(
        color: AppColors.ordersStatusBox3,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get deliveryAddressTitle => TextStyle(
      color: AppColors.addressListWidgetContainsColor,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get deliveryAddressSubTitle => TextStyle(
        color: AppColors.addressListWidgetContainsColor,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get downloadBannerTitleText => TextStyle(
      color: AppColors.downloadBannerTitle,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get downloadBannerSubTitleText => TextStyle(
        color: AppColors.downloadBannerSubTitle,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get storeName => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.xxl,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get welcomeText => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.w500,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get storeCategoryName => TextStyle(
        color: AppColors.secondary,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get storeLocation => TextStyle(
        color: AppColors.storeLocation,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get safetyText => TextStyle(
        color: AppColors.productTitle,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get ratingText => TextStyle(
        color: AppColors.secondary,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get addToCart => TextStyle(
      color: AppColors.dashBoardChangeCategoryText,
      letterSpacing: 2,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /* /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins' */ fontFamily:
          'Poppins');
  static TextStyle get topOfferText => TextStyle(
      color: AppColors.topStoreForText,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productName => TextStyle(
        fontSize: FontSizeStatic.maxMd,
        fontWeight: FontWeight.bold,
        /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
        color: Colors.black,
      );
  static TextStyle get productPrice => TextStyle(
        fontSize: FontSizeStatic.md,
        fontWeight: FontWeight.bold,
        /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
        color: Colors.black,
      );
  static TextStyle get fakePrice => TextStyle(
        fontSize: FontSizeStatic.md,
        decoration: TextDecoration.lineThrough,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get productQuantity => TextStyle(
        color: AppColors.filterBox,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get subCategoryName => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.sm,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productPriceInOrderDetails => TextStyle(
        color: AppColors.primary,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get fakePriceInOrderDetails => TextStyle(
        color: AppColors.fakePriceInOrderDetails,
        fontSize: FontSizeStatic.semiSm,
        decoration: TextDecoration.lineThrough,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get profileNameFirstLetter => TextStyle(
      color: AppColors.secondary,
      fontSize: 70,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get profileNameFirstLetter2 => TextStyle(
      color: AppColors.primary,
      fontSize: 40,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get profileOptionsTitle => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.maxMd,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get signOut => TextStyle(
        color: AppColors.primary,
        fontSize: FontSizeStatic.maxMd,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get profileName => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get drawerMyProfileName => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get profileContact => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.maxMd,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );

  static TextStyle get drawerItems => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get drawerTitle => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get drawerSubTitle => TextStyle(
        color: AppColors.secondary,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get drawerSubTitle2 => TextStyle(
        color: AppColors.drawerSubTitle,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get promoOfferTitle => TextStyle(
      color: AppColors.downloadBannerTitle,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get homeScreenOfferTitle => TextStyle(
      fontSize: FontSizeStatic.mdSm,
      fontWeight: FontWeight.w400,
      color: Colors.black,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get homeScreenOfferSubTitle => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get bottomOfferTitle => TextStyle(
        color: Colors.black,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get promoOfferSubTitle => TextStyle(
        color: AppColors.downloadBannerSubTitle,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );

  static TextStyle get paymentTypeTitle => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get yourPayableBill => TextStyle(
        color: AppColors.addressListWidgetContainsColor,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get totalPayablePrice => TextStyle(
      color: AppColors.primary,
      fontSize: FontSizeStatic.xll,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get includingAllTax => TextStyle(
        color: AppColors.storeLocation,
        fontSize: FontSizeStatic.sm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get goPotuOffer => TextStyle(
        color: AppColors.goPotuOffers,
        fontWeight: FontWeight.bold,
        /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
        fontSize: FontSizeStatic.sm,
      );
  static TextStyle get viewTC => TextStyle(
        color: AppColors.couponCode,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get promoCodeText => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.semiSm,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins',
      letterSpacing: 5);
  static TextStyle get goPotuOfferSubTitle => TextStyle(
        color: AppColors.goPotuOffersSubTitle,
        fontSize: FontSizeStatic.mdSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get goPotuOfferTitle => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.md,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get availableOffer => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get orderPlaced => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.xll,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get orderPlacedOrderId => TextStyle(
        color: AppColors.accentColor,
        fontSize: FontSizeStatic.lg,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get orderPlacedId => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.xl,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productDetailsProductName => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.sm,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productDetailsDiscountText => TextStyle(
        color: AppColors.filterBox,
        fontSize: FontSizeStatic.mdSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get productPriceInProductDetails => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productDesTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get productDesSubTitle => TextStyle(
        color: AppColors.productDes,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get aboutTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get aboutSubTitle => TextStyle(
        color: AppColors.productDes,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get companyWebSite => TextStyle(
        color: AppColors.couponCode,
        fontSize: FontSizeStatic.semiSm,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get aboutPrivacy => TextStyle(
      color: AppColors.secondary,
      fontSize: FontSizeStatic.mdSm,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get companyTrustTitle => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.maxMd,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get companyTrustSubTitle => TextStyle(
        color: Color(0xFFFF4E00),
        fontSize: FontSizeStatic.semiSm,
        height: 1.2,
        /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins',
      );
  static TextStyle get shareYour => TextStyle(
      color: Color(0xFF0029F3),
      fontSize: FontSizeStatic.md,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get notDeliveryMessage => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.lg,
      /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins');
  static TextStyle get storeNotFoundMessage => TextStyle(
      color: AppColors.accentColor,
      fontSize: FontSizeStatic.xll,
      fontWeight: FontWeight.bold,
      /*fontFamily: 'Proxima-Bold' */ fontFamily: 'Poppins');
  static TextStyle get noDataTextTitle => TextStyle(
      color: AppColors.landingTitle,
      fontSize: FontSizeStatic.lg,
      /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins');
  static TextStyle get outOfStock => TextStyle(
      color: Colors.red,
      fontSize: FontSizeStatic.maxMd,
      /* fontFamily: 'Proxima-Regular' */ fontFamily: 'Poppins');
}
