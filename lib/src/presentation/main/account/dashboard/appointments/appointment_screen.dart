import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_user.dart';
import 'package:heidi/src/presentation/main/account/dashboard/dashboard_screen.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/translate.dart';

class AppointmentScreen extends StatelessWidget {
  final UserModel user;

  const AppointmentScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Translate.of(context).translate('appointments')),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          padding: const EdgeInsets.all(16.0),
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: <Widget>[
            GridItemButton(
              icon: Icons.calendar_today,
              title: Translate.of(context).translate("my_appointments"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.myAppointments,
                );
              },
            ),
            // GridItemButton(
            //   icon: Icons.calendar_today_outlined,
            //   title: Translate.of(context).translate("requests"),
            //   onPressed: () {
            //     Navigator.pushNamed(
            //       context,
            //       Routes.appointmentRequests,
            //     );
            //   },
            // ),
            GridItemButton(
              icon: Icons.calendar_month,
              title: Translate.of(context).translate("my_bookings"),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  Routes.myBookings,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
