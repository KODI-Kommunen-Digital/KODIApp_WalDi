// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heidi/src/presentation/cubit/authentication/cubit.dart';
import 'package:heidi/src/presentation/main/account/account.dart';
import 'package:heidi/src/presentation/main/discovery/discovery.dart';
import 'package:heidi/src/presentation/main/home/home.dart';
import 'package:heidi/src/presentation/main/wishlist/wishlist_screen.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class AppContainer extends StatefulWidget {
  const AppContainer({Key? key}) : super(key: key);

  @override
  State<AppContainer> createState() => _AppContainerState();

}

class _AppContainerState extends State<AppContainer> {
  String _selectedPage = Routes.home;

  late bool login;

  @override
  void initState() {
    super.initState();
  }

  ///check route need auth
  bool _requireAuth(String route) {
    switch (route) {
      case Routes.home:
      case Routes.discovery:
        return false;
      default:
        return true;
    }
  }

  ///Export index stack
  int _exportIndexed(String route) {
    switch (route) {
      case Routes.home:
        return 0;
      case Routes.discovery:
        return 1;
      case Routes.wishList:
        return 2;
      case Routes.account:
        return 3;
      default:
        return 0;
    }
  }

  ///Handle When Press Notification
  // void _notificationHandle(RemoteMessage message) {
  //   final notification = NotificationModel.fromJson(message);
  //   if (notification.target != null) {
  //     Navigator.pushNamed(
  //       context,
  //       notification.target!,
  //       arguments: notification.item,
  //     );
  //   }
  // }

  ///Force switch home when authentication state change
  void _listenAuthenticateChange(AuthenticationState authentication) async {
    if (authentication == const AuthenticationState.failed() &&
        _requireAuth(_selectedPage)) {
      final result = await Navigator.pushNamed(
        context,
        Routes.signIn,
        arguments: _selectedPage,
      ).then((value) {
        setState(() {});
      });
      if (result != null) {
        setState(() {
          _selectedPage = result as String;
        });
      } else {
        setState(() {
          _selectedPage = Routes.home;
        });
      }
    }
  }

  ///On change tab bottom menu and handle when not yet authenticate
  void _onItemTapped(String route) async {
    // if (AppBloc.userCubit.state == null && _requireAuth(route)) {
    //   final result = await Navigator.pushNamed(
    //     context,
    //     Routes.signIn,
    //     arguments: route,
    //   );
    //   if (result == null) return;
    // }
    setState(() {
      _selectedPage = route;
    });
  }

  ///Build Item Menu
  Widget _buildMenuItem(String route) {
    Color? color;
    String title = 'home';
    IconData iconData = Icons.help_outline;
    switch (route) {
      case Routes.home:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
      case Routes.discovery:
        iconData = Icons.touch_app_rounded;
        title = 'services';
        break;
      case Routes.wishList:
        iconData = Icons.bookmark_outline;
        title = 'wish_list';
        break;
      case Routes.account:
        iconData = Icons.account_circle_outlined;
        title = 'maccount';
        break;
      default:
        iconData = Icons.home_outlined;
        title = 'home';
        break;
    }
    if (route == _selectedPage) {
      color = Theme.of(context).primaryColor;
    }
    return IconButton(
      onPressed: () {
        _onItemTapped(route);
      },
      padding: EdgeInsets.zero,
      icon: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: color,
          ),
          const SizedBox(height: 2),
          Text(
            Translate.of(context).translate(title),
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 10,
                  color: color,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  ///Build submit button
  Widget? _buildSubmit() {
      return FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: (){},
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      );
  }

  ///Build bottom menu
  Widget _buildBottomMenu() {
    return BottomAppBar(
      child: SizedBox(
        height: 56,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMenuItem(Routes.home),
            _buildMenuItem(Routes.discovery),
            const SizedBox(width: 56),
            _buildMenuItem(Routes.wishList),
            _buildMenuItem(Routes.account),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const submitPosition = FloatingActionButtonLocation.centerDocked;
    // var isLogin = false;
    return Scaffold(
      body: BlocListener<AuthenticationCubit, AuthenticationState>(
        listener: (context, authentication) async {
          _listenAuthenticateChange(authentication);
        },
        child: IndexedStack(
          index: _exportIndexed(_selectedPage),
          children: const <Widget>[
            HomeScreen(),
            DiscoveryScreen(),
            WishlistScreen(),
            AccountScreen()
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomMenu(),
      floatingActionButton: _buildSubmit(),
      floatingActionButtonLocation: submitPosition,
    );
  }
}
