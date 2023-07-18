import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

class EmptyProductItem extends StatelessWidget {
  const EmptyProductItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppPlaceholder(
      child: Row(
        children: <Widget>[
          Container(
            width: 84,
            height: 84,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 4),
              Container(
                height: 10,
                width: 180,
                color: Colors.white,
              ),
              const SizedBox(height: 4),
              Container(
                height: 10,
                width: 150,
                color: Colors.white,
              ),
              const SizedBox(height: 8),
              Container(
                height: 10,
                width: 100,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
