import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';

class HomeSwipe extends StatelessWidget {
  final double height;
  final String? images;

  const HomeSwipe({
    Key? key,
    this.images,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (images != null) {
      return Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.asset(images!, fit: BoxFit.fill,
                errorBuilder: (context, error, stackTrace) {
              return AppPlaceholder(
                child: Container(
                  color: Colors.white,
                  child: const Icon(Icons.error),
                ),
              );
            });
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: false,
          itemCount: images!.length,
          physics: const NeverScrollableScrollPhysics());
    }

    return Container(
      color: Theme.of(context).colorScheme.background,
      child: AppPlaceholder(
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          color: Colors.white,
        ),
      ),
    );
  }
}
