import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model_forum_group.dart';
import 'package:heidi/src/presentation/main/home/widget/empty_product_item.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/translate.dart';

class ForumGroupItem extends StatelessWidget {
  const ForumGroupItem({
    Key? key,
    this.item,
    this.onPressed,
  }) : super(key: key);

  final ForumGroupModel? item;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();

    if (item == null) {
      return const EmptyProductItem();
    }

    return InkWell(
      onTap: onPressed,
      child: Stack(
        children: [
          Row(
            children: <Widget>[
              CachedNetworkImage(
                imageUrl: item?.image == 'admin/News.jpeg'
                    ? "${Application.picturesURL}${item?.image}"
                    : "${Application.picturesURL}${item!.image}?cacheKey=$uniqueKey",
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: 120,
                    height: 140,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(11),
                    ),
                  );
                },
                placeholder: (context, url) {
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
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      item?.forumName ?? '',
                      maxLines: 2,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                        item?.isPrivate == 0
                            ? Translate.of(context).translate('public')
                            : Translate.of(context).translate('private'),
                        maxLines: 2,
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                        )),
                    const SizedBox(height: 10.0,),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 0, 50, 0),
                      decoration: BoxDecoration(
                        color: Colors.grey[500],
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        item?.isJoined == false ? 'Anfrage verschickt' : 'zur Gruppe',
                      ),
                    ),
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
  }
}
