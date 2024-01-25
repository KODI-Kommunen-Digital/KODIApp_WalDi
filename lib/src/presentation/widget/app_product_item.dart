import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:heidi/src/presentation/main/home/widget/empty_product_item.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

class AppProductItem extends StatelessWidget {
  const AppProductItem(
      {Key? key,
      this.item,
      this.onPressed,
      required this.type,
      this.trailing,
      required this.isRefreshLoader,
      this.cityName})
      : super(key: key);

  final ProductModel? item;
  final ProductViewType type;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final bool isRefreshLoader;
  final String? cityName;

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    final memoryCacheManager = DefaultCacheManager();
    switch (type) {
      case ProductViewType.small:
        if (item == null) {
          return const EmptyProductItem();
        }
        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Row(
            children: <Widget>[
              item?.pdf != '' && item?.image == 'admin/News.jpeg'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: SizedBox(
                          width: 120,
                          height: 140,
                          child: const PDF().cachedFromUrl(
                            "${Application.picturesURL}${item?.pdf}?cacheKey=$uniqueKey",
                            placeholder: (progress) =>
                                Center(child: Text('$progress %')),
                            errorWidget: (error) =>
                                Center(child: Text(error.toString())),
                          )),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: CachedNetworkImage(
                        imageUrl: item?.sourceId == 2
                            ? item!.image
                            : "${Application.picturesURL}${item!.image}",
                        cacheManager: memoryCacheManager,
                        placeholder: (context, url) {
                          return AppPlaceholder(
                            child: Container(
                              width: 120,
                              height: 140,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                            ),
                          );
                        },
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: 120,
                            height: 140,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                          );
                        },
                        errorWidget: (context, url, error) {
                          return AppPlaceholder(
                            child: Container(
                              width: 120,
                              height: 140,
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
                      ),
                    ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item!.title,
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      (cityName != null)
                          ? "${item?.category ?? ''} - $cityName"
                          : item?.category ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 2),
                    Visibility(
                      visible: item!.startDate.isNotEmpty &&
                          item!.endDate.isNotEmpty,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.startDate} ${Translate.of(context).translate('to')} ${item?.endDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    // Visibility(
                    //   visible: item!.startDate.isNotEmpty &&
                    //       item?.startDate == item?.endDate,
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       color: Colors.white30,
                    //       borderRadius: BorderRadius.circular(10),
                    //     ),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(3.5),
                    //       child: Text(
                    //         "${item?.startDate} ${Translate.of(context).translate('to')} ${item?.endDate}",
                    //         style: Theme.of(context)
                    //             .textTheme
                    //             .bodySmall!
                    //             .copyWith(fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Visibility(
                      visible:
                          item!.startDate.isNotEmpty && item!.endDate == "",
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.startDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: item?.categoryId == 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.5),
                          child: Text(
                            "${item?.createDate}",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
              ),
              trailing ?? Container()
            ],
          ),
        );
      case ProductViewType.grid:
        if (item == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: item?.sourceId == 2
                    ? item!.image
                    : "${Application.picturesURL}${item!.image}",
                cacheManager: memoryCacheManager,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: 120,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(4),
                              child: Icon(
                                item!.favorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.white,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
                placeholder: (context, url) {
                  return AppPlaceholder(
                    child: Container(
                      height: 120,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return AppPlaceholder(
                    child: Container(
                      height: 120,
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
              const SizedBox(height: 8),
              Text(
                item?.category ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                item!.title,
                maxLines: 2,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              Text(
                item!.address,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        );

      case ProductViewType.list:
        if (item == null) {
          return const EmptyProductItem();
        }

        return InkWell(
          onTap: () async {
            onPressed!();
          },
          child: Stack(
            children: [
              Row(
                children: <Widget>[
                  item?.pdf != '' && item?.image == 'admin/News.jpeg'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: SizedBox(
                              width: 120,
                              height: 140,
                              child: const PDF().cachedFromUrl(
                                "${Application.picturesURL}${item?.pdf}?cacheKey=$uniqueKey",
                                placeholder: (progress) =>
                                    Center(child: Text('$progress %')),
                                errorWidget: (error) =>
                                    Center(child: Text(error.toString())),
                              )),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: item?.sourceId == 2
                                ? item!.image
                                : "${Application.picturesURL}${item!.image}",
                            cacheManager: memoryCacheManager,
                            placeholder: (context, url) {
                              return AppPlaceholder(
                                child: Container(
                                  height: 120,
                                  width: 140,
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                  ),
                                ),
                              );
                            },
                            imageBuilder: (context, imageProvider) {
                              return Container(
                                width: 120,
                                height: 140,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              );
                            },
                            errorWidget: (context, url, error) {
                              return AppPlaceholder(
                                child: Container(
                                  width: 120,
                                  height: 140,
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
                          ),
                        ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          item!.title,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          (cityName != null)
                              ? "${item?.category ?? ''} - $cityName"
                              : item?.category ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        if (item?.categoryId == 3)
                          Container(
                            padding: const EdgeInsets.all(3.5),
                            decoration: BoxDecoration(
                              color: Colors.white30,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              item?.endDate == ""
                                  ? "${item?.startDate}"
                                  : "${item?.startDate} ${Translate.of(context).translate('to')} ${item?.endDate}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        Text(
                          item?.categoryId == 1 ? "${item?.createDate}" : "",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 4),
                        const SizedBox(height: 8),
                        const Row(
                          children: <Widget>[
                            SizedBox(width: 4),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        );

      default:
        return Container(width: 160.0);
    }
  }

  Future<void> savePDFLocally(String pdfContent) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$pdfContent';
    final file = File(filePath);

    if (!await file.exists()) {
      await file.writeAsBytes(pdfContent.codeUnits);
    }
  }
}
