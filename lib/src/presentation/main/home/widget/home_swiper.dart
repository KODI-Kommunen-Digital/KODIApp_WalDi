import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';

class HomeSwipe extends StatelessWidget {
  final double height;
  final String? images;

  const HomeSwipe({
    super.key,
    this.images,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    if (images != null) {
      return Swiper(
          itemBuilder: (BuildContext context, int index) {
            return CachedNetworkImage(
              imageUrl: "${Application.picturesURL}admin/Homepage.jpg",
              cacheManager: memoryCacheManager,
              placeholder: (context, url) {
                return AppPlaceholder(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                );
              },
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return AppPlaceholder(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.error),
                  ),
                );
              },
            );
          },
          autoplayDelay: 3000,
          autoplayDisableOnInteraction: false,
          autoplay: false,
          itemCount: images!.length,
          physics: const NeverScrollableScrollPhysics());
    }

    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: AppPlaceholder(
        child: Container(
          margin: const EdgeInsets.only(bottom: 2),
          color: Colors.white,
        ),
      ),
    );
  }
}
