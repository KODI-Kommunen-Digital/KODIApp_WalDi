import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/change_password/change_password_screen.dart';
import 'package:heidi/src/presentation/main/account/contact_us/contact_us_screen.dart';
import 'package:heidi/src/presentation/main/account/contact_us/contact_us_success/contact_us_success.dart';
import 'package:heidi/src/presentation/main/account/edit_profile/edit_profile_screen.dart';
import 'package:heidi/src/presentation/main/account/legal/imprint/imprint.dart';
import 'package:heidi/src/presentation/main/account/legal/legal.dart';
import 'package:heidi/src/presentation/main/account/legal/privacy_policy/privacy.dart';
import 'package:heidi/src/presentation/main/account/profile/cubit/profile_cubit.dart';
import 'package:heidi/src/presentation/main/account/profile/profile_screen.dart';
import 'package:heidi/src/presentation/main/account/setting/settings_screen.dart';
import 'package:heidi/src/presentation/main/add_listing/add_listing_screen.dart';
import 'package:heidi/src/presentation/main/add_listing/add_listing_success/add_listing_success.dart';
import 'package:heidi/src/presentation/main/dashboard/all_listings/all_listings_screen.dart';
import 'package:heidi/src/presentation/main/dashboard/all_listings/cubit/all_listings_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/all_requests/all_requests_screen.dart';
import 'package:heidi/src/presentation/main/dashboard/all_requests/cubit/all_requests_cubit.dart';
import 'package:heidi/src/presentation/main/dashboard/dashboard_screen.dart';
import 'package:heidi/src/presentation/main/dashboard/my_listings/my_listings_screen.dart';
import 'package:heidi/src/presentation/main/discovery/mitreden_webview.dart';
import 'package:heidi/src/presentation/main/home/list_product/list_product.dart';
import 'package:heidi/src/presentation/main/home/product_detail/image_zoom/image_zoom_screen.dart';
import 'package:heidi/src/presentation/main/home/product_detail/product_detail.dart';
import 'package:heidi/src/presentation/main/login/forgot_password/forgot_password_screen.dart';
import 'package:heidi/src/presentation/main/login/signin/signin_screen.dart';
import 'package:heidi/src/presentation/main/login/signup/signup.dart';
import 'package:heidi/src/presentation/main/account/profile_settings/profile_settings_screen.dart';
import 'package:heidi/src/presentation/main/account/faq/cubit/faq_cubit.dart';
import 'package:heidi/src/presentation/main/account/faq/faq_screen.dart';

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
  static const String contactUsSuccess = "/contactUsSuccess";
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
  static const String imageZoom = "/imageZoom";
  static const String profileSettings = "/profileSettings";
  static const String mitredenWebview = "/mitredenWebview";
  static const String faq = "/faq";
  static const String allListings = "/allListings";
  static const String allRequests = "/allRequests";
  static const String dashboard = "/dashboard";
  static const String myListings = "/myListings";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case listProduct:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (context) {
            return ListProductScreen(arguments: arguments);
          },
        );

      case productDetail:
        return MaterialPageRoute(
          builder: (context) {
            return ProductDetailScreen(
                item: settings.arguments as ProductModel);
          },
        );

      case mitredenWebview:
        return MaterialPageRoute(
          builder: (context) {
            return MitredenWebview(link: settings.arguments as String);
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
      case allListings:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AllListingsCubit(),
              child: AllListingsScreen(user: arguments["user"] as UserModel),
            );
          },
        );

      case allRequests:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => AllRequestsCubit(),
              child: AllRequestsScreen(user: arguments["user"] as UserModel),
            );
          },
        );
      case setting:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;
            return SettingsScreen(
              user: arguments['user'] as UserModel?,
            );
          },
        );

      case imageZoom:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return ImageZoomScreen(
                sourceId: arguments['sourceId'] as int,
                imageList: arguments['imageList']! as List<ImageListModel>?,
                pdf: arguments['pdf'] ?? '');
          },
          fullscreenDialog: true,
        );

      case submit:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return AddListingScreen(
              item: arguments['item'] as ProductModel?,
              isNewList: arguments['isNewList'] as bool,
            );
          },
          fullscreenDialog: true,
        );

      case profile:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: ProfileScreen(
                user: arguments['user'] as UserModel,
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );

      case submitSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const AddListingSuccessScreen();
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

      case profileSettings:
        return MaterialPageRoute(
          builder: (context) {
            return const ProfileSettingsScreen();
          },
        );

      case contactUs:
        return MaterialPageRoute(
          builder: (context) {
            return const ContactUsScreen();
          },
        );

      case contactUsSuccess:
        return MaterialPageRoute(
          builder: (context) {
            return const ContactUsSuccessScreen();
          },
          fullscreenDialog: true,
        );
      case faq:
        return MaterialPageRoute(
          builder: (context) {
            return BlocProvider(
              create: (context) => FaqCubit(),
              child: const FaqScreen(),
            );
          },
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: DashboardScreen(
                user: arguments['user'] as UserModel,
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );

      case myListings:
        return MaterialPageRoute(
          builder: (context) {
            final Map<String, dynamic> arguments =
                settings.arguments as Map<String, dynamic>;
            return BlocProvider(
              create: (context) => ProfileCubit(
                context.read(),
                arguments['user'] as UserModel,
              ),
              child: MyListingsScreen(
                user: arguments['user'] as UserModel,
                isEditable: arguments['editable'] as bool,
              ),
            );
          },
        );
      default:
        const SignInScreen();

        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
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
