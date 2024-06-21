import 'package:flutter/material.dart';
import 'package:heidi/src/utils/translate.dart';

class AppointmentSuccess extends StatelessWidget {
  final bool success;

  const AppointmentSuccess({super.key, required this.success});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Icon(
              (success) ? Icons.check : Icons.close,
              color: Colors.white,
              size: 32,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            Translate.of(context).translate(
                (success) ? 'booking_success_title' : 'booking_fail_title'),
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            Translate.of(context).translate(
                (success) ? 'booking_success_message' : 'booking_fail_message'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
    );
  }
}
