import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/authentication_cubit.dart';
import 'package:heidi/src/presentation/main/account/cubit/user_cubit.dart';
import 'package:heidi/src/presentation/main/login/signin/cubit/login_cubit.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final userCubit = UserCubit();
  static final languageCubit = LanguageCubit();
  static final themeCubit = ThemeCubit();
  static final authenticateCubit = AuthenticationCubit();
  // static final accountCubit = AccountCubit();
  static final loginCubit = LoginCubit();
  // static final homeCubit = HomeCubit();
  // static final wishListCubit = WishListCubit();
  // static final reviewCubit = ReviewCubit();
  // static final messageCubit = MessageCubit();
  // static final submitCubit = SubmitCubit();
  // static final searchCubit = SearchCubit();
  // static final productDetailCubit = ProductDetailCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    // BlocProvider<ProductDetailCubit>(
    //   create: (context) => productDetailCubit,
    // ),
    BlocProvider<LanguageCubit>(
      create: (context) => languageCubit,
    ),
    BlocProvider<ThemeCubit>(
      create: (context) => themeCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticateCubit,
    ),
    // BlocProvider<AccountCubit>(
    //   create: (context) => accountCubit,
    // ),
    BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
    ),
    // BlocProvider<HomeCubit>(
    //   create: (context) => homeCubit,
    // ),
    // BlocProvider<WishListCubit>(
    //   create: (context) => wishListCubit,
    // ),
    // BlocProvider<ReviewCubit>(
    //   create: (context) => reviewCubit,
    // ),
    // BlocProvider<MessageCubit>(
    //   create: (context) => messageCubit,
    // ),
    // BlocProvider<SubmitCubit>(
    //   create: (context) => submitCubit,
    // ),
    // BlocProvider<SearchCubit>(
    //   create: (context) => searchCubit,
    // ),
  ];

  static void dispose() {
    // applicationCubit.close();
    // userCubit.close();
    languageCubit.close();
    themeCubit.close();
    // homeCubit.close();
    // wishListCubit.close();
    // authenticateCubit.close();
    // accountCubit.close();
    // loginCubit.close();
    // reviewCubit.close();
    // messageCubit.close();
    // submitCubit.close();
    // searchCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
