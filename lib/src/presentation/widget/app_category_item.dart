import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

enum CategoryView { full, icon, cardLarge }

class AppCategory extends StatelessWidget {
  const AppCategory({
    Key? key,
    this.type = CategoryView.full,
    this.item,
    this.onPressed,
  }) : super(key: key);

  final CategoryView type;
  final CategoryModel? item;
  final VoidCallback? onPressed;
  static String profilePicUrl = Application.picturesURL;

  @override
  Widget build(BuildContext context) {
    final memoryCacheManager = DefaultCacheManager();
    switch (type) {
      case CategoryView.full:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              height: 120,
              alignment: Alignment.topLeft,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
          );
        }

        return GestureDetector(
          onTap: onPressed,
          child: SizedBox(
            height: 120,
            child: CachedNetworkImage(
              imageUrl: "${Application.picturesURL}${item!.image}",
              cacheManager: memoryCacheManager,
              imageBuilder: (context, imageProvider) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8),
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: item!.color,
                              ),
                              child: Icon(
                                item!.icon,
                                color: Colors.white,
                                size: 18,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8, right: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    item!.title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${item!.count} ${Translate.of(context).translate('location')}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall!
                                        .copyWith(color: Colors.white),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
              placeholder: (context, url) {
                return AppPlaceholder(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                );
              },
              errorWidget: (context, url, error) {
                return AppPlaceholder(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                    child: const Icon(Icons.error),
                  ),
                );
              },
            ),
          ),
        );

      case CategoryView.icon:
        if (item == null) {
          return AppPlaceholder(
            child: Container(
              padding: const EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 8,
                          width: 100,
                          color: Colors.white,
                        ),
                        Container(
                          height: 8,
                          width: 100,
                          color: Colors.white,
                          padding: const EdgeInsets.only(top: 4),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }

        return InkWell(
          onTap: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item!.color,
                ),
                child: Icon(
                  item!.icon,
                  color: Colors.white,
                  size: 18,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item!.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${item!.count} ${Translate.of(context).translate('location')}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              )
            ],
          ),
        );

      ///Case View Card large
      case CategoryView.cardLarge:
        if (item == null) {
          return SizedBox(
            width: 120,
            child: AppPlaceholder(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        }

        return SizedBox(
          width: 120,
          child: GestureDetector(
            onTap: onPressed,
            child: Card(
              elevation: 2,
              margin: const EdgeInsets.all(0),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: CachedNetworkImage(
                imageUrl: "$profilePicUrl${item!.image}",
                cacheManager: memoryCacheManager,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                            Colors.black.withOpacity(0.3), BlendMode.darken),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            item!.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        )
                      ],
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      child: const Icon(Icons.error),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      default:
        return Container();
    }
  }
}
