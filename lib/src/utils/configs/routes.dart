import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/main/account/change_password/change_password_screen.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/edit_profile_screen.dart';
import 'package:heidi/src/presentation/main/account/legal/imprint/imprint.dart';
import 'package:heidi/src/presentation/main/account/legal/legal.dart';
import 'package:heidi/src/presentation/main/account/legal/privacy_policy/privacy.dart';
import 'package:heidi/src/presentation/main/account/setting/settings_screen.dart';
import 'package:heidi/src/presentation/main/add_listing/add_listing_screen.dart';
import 'package:heidi/src/presentation/main/home/list_product/list_product.dart';
import 'package:heidi/src/presentation/main/home/product_detail/product_detail.dart';
import 'package:heidi/src/presentation/main/login/forgot_password/forgot_password_screen.dart';
import 'package:heidi/src/presentation/main/login/signin/signin_screen.dart';
import 'package:heidi/src/presentation/main/login/signup/signup.dart';

class RouteArguments<T> {
  final T? item;
  final VoidCallback? callback;
  RouteArguments({this.item, this.callback});
}

class Routes {
  static const String home = "/home";
  static const String discovery = "/discovery";
  static const String wishList = "/wishList";
  static const String account = "/account";
  static const String signIn = "/signIn";
  static const String signUp = "/signUp";
  static const String forgotPassword = "/forgotPassword";
  static const String productDetail = "/productDetail";
  static const String searchHistory = "/searchHistory";
  static const String category = "/category";
  static const String profile = "/profile";
  static const String submit = "/submit";
  static const String editProfile = "/editProfile";
  static const String changePassword = "/changePassword";
  static const String changeLanguage = "/changeLanguage";
  static const String contactUs = "/contactUs";
  static const String aboutUs = "/aboutUs";
  static const String gallery = "/gallery";
  static const String themeSetting = "/themeSetting";
  static const String listProduct = "/listProduct";
  static const String filter = "/filter";
  static const String review = "/review";
  static const String writeReview = "/writeReview";
  static const String setting = "/setting";
  static const String fontSetting = "/fontSetting";
  static const String picker = "/picker";
  static const String galleryUpload = "/galleryUpload";
  static const String categoryPicker = "/categoryPicker";
  static const String gpsPicker = "/gpsPicker";
  static const String submitSuccess = "/submitSuccess";
  static const String openTime = "/openTime";
  static const String socialNetwork = "/socialNetwork";
  static const String tagsPicker = "/tagsPicker";
  static const String webView = "/webView";
  static const String booking = "/booking";
  static const String bookingManagement = "/bookingManagement";
  static const String bookingDetail = "/bookingDetail";
  static const String scanQR = "/scanQR";
  static const String deepLink = "/deepLink";
  static const String legal = "/legal";
  static const String imprint = "/imprint";
  static const String privacy = "/privacy";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case listProduct:
        return MaterialPageRoute(
          builder: (context) {
            return ListProductScreen(selectedCityId: settings.arguments as int);
          },
        );

      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(item: settings.arguments as ProductModel);
          },
        );

      case signIn:
        return MaterialPageRoute(
          builder: (context) {
            return const SignInScreen();
          },
          fullscreenDialog: true,
        );

      case signUp:
        return MaterialPageRoute(
          builder: (context) {
            return const SignUpScreen();
          },
        );

      case forgotPassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ForgotPasswordScreen();
          },
        );

        case editProfile:
        return MaterialPageRoute(
          builder: (context) {
            return const EditProfileScreen();
          },
        );

        case setting:
        return MaterialPageRoute(
          builder: (context) {
            return const SettingsScreen();
          },
        );

      case submit:
        return MaterialPageRoute(
          builder: (context) {
            return AddListingScreen(item: settings.arguments as ProductModel?);
          },
          fullscreenDialog: true,
        );

      case submitSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const AddListingScreen();
          },
          fullscreenDialog: true,
        );

        case changePassword:
        return MaterialPageRoute(
          builder: (context) {
            return const ChangePasswordScreen();
          },
        );

        case legal:
        return MaterialPageRoute(
          builder: (context) {
            return const LegalScreen();
          },
        );

        case imprint:
        return MaterialPageRoute(
          builder: (context) {
            return const ImprintScreen();
          },
        );

        case privacy:
        return MaterialPageRoute(
          builder: (context) {
            return const PrivacyScreen();
          },
        );

      default:
        const SignInScreen();

        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          fullscreenDialog: true,
        );
    }
  }

  ///Singleton factory
  static final Routes _instance = Routes._internal();

  factory Routes() {
    return _instance;
  }

  Routes._internal();
}
