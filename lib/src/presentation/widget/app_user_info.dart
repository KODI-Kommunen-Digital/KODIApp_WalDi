import 'package:flutter/material.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/utils/configs/application.dart';

import 'app_placeholder.dart';

enum UserViewType { basic, information, qrcode }

class AppUserInfo extends StatelessWidget {
  final UserModel? user;
  final VoidCallback? onPressed;
  final UserViewType type;
  final bool showDirectionIcon;

  const AppUserInfo({
    Key? key,
    this.user,
    this.onPressed,
    this.type = UserViewType.basic,
    required this.showDirectionIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    switch (type) {
      case UserViewType.information:
        if (user == null) {
          return InkWell(
            onTap: () {
              onPressed;
            },
            child: AppPlaceholder(
              child: Row(
                children: <Widget>[
                  Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 100,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 10,
                          width: 150,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        if (user!.description.isNotEmpty) {
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(
                user!.description,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          );
        }
        Widget networkImage = SizedBox(
          width: 60,
          height: 60,
          child: ClipOval(
              child: Image.network(
            user!.image == 'Keine Angabe' || user!.image == ""
                ? Application.defaultPicturesURL
                : "${Application.picturesURL}${user!.image}?cache=$uniqueKey",
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          )),
        );
        return InkWell(
          onTap: onPressed,
          child: Row(
            children: <Widget>[
              networkImage,
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      user!.username,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    // description,
                    const SizedBox(height: 4),
                    Text(
                      user!.email,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Visibility(
                  visible: showDirectionIcon,
                  child: const Icon(Icons.navigate_next, color: Colors.white))
            ],
          ),
        );

      case UserViewType.qrcode:
        return Container();

      default:
        if (user == null) {
          return AppPlaceholder(
            child: Row(
              children: <Widget>[
                Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 150,
                      color: Colors.white,
                    ),
                  ],
                )
              ],
            ),
          );
        }
        return InkWell(
          onTap: () {},
          child: Row(
            children: <Widget>[
              ClipOval(
                  child: Image.network(
                "${Application.picturesURL}${user!.image}",
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              )),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    user!.username,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user!.email,
                    style: Theme.of(context).textTheme.bodySmall,
                  )
                ],
              )
            ],
          ),
        );
    }
  }
}
