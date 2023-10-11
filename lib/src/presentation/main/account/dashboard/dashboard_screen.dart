import 'package:flutter/material.dart';
import 'package:heidi/src/utils/translate.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('dashboard')),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            GridItemButton(
              icon: Icons.group,
              title: Translate.of(context).translate("requests"),
              onPressed: () {
                // Add your action here
              },
            ),
            GridItemButton(
              icon: Icons.list,
              title: Translate.of(context).translate("all_listings"),
              onPressed: () {},
            ),
            GridItemButton(
              icon: Icons.local_offer,
              title: Translate.of(context).translate("my_listings"),
              onPressed: () {
                // Add your action here
              },
            ),
            GridItemButton(
              icon: Icons.group,
              title: Translate.of(context).translate("my_groups"),
              onPressed: () {
                // Add your action here
              },
            ),
          ],
        ),
      ),
    );
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
        backgroundColor: Theme.of(context).highlightColor,
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
