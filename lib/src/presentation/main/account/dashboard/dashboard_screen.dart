import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/data/repository/user_repository.dart';
import 'package:heidi/src/utils/configs/preferences.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class DashboardScreen extends StatelessWidget {
  final bool isEditable;

  const DashboardScreen({required this.isEditable, super.key});

  Future<UserModel?> getUser() async {
    final prefs = await Preferences.openBox();
    final userId = prefs.getKeyValue(Preferences.userId, 0);
    final user = await UserRepository.fetchUser(userId);
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(Translate.of(context).translate("dashboard")),
        ),
        body: FutureBuilder(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              UserModel? user = snapshot.data;
              return Center(
                child: GridView.count(
                  crossAxisCount: 2,
                  padding: const EdgeInsets.all(16.0),
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  children: <Widget>[
                    if (user?.roleId == 1)
                      GridItemButton(
                        icon: Icons.group,
                        title: Translate.of(context).translate("requests"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.allRequests, arguments: {
                            "user": user,
                          });
                        },
                      ),
                    if (user?.roleId == 1)
                      GridItemButton(
                        icon: Icons.list,
                        title: Translate.of(context).translate("all_listings"),
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(Routes.allListings, arguments: {
                            "user": user,
                          });
                        },
                      ),
                    GridItemButton(
                      icon: Icons.local_offer,
                      title: Translate.of(context).translate("my_listings"),
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          Routes.myListings,
                          arguments: {'user': user, 'editable': true},
                        );
                      },
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(Translate.of(context).translate("error_message")),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ));
  }
}

class GridItemButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onPressed;

  const GridItemButton(
      {super.key,
      required this.title,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF3D3D3D),
        padding: const EdgeInsets.all(16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 48.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 18.0, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
