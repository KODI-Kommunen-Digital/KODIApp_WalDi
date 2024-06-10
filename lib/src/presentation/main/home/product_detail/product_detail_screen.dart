// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously
import 'dart:io';
import 'dart:math' as math;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_favorite.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/main/home/product_detail/cubit/cubit.dart';
import 'package:heidi/src/presentation/widget/app_button.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/presentation/widget/app_user_info.dart';
import 'package:heidi/src/utils/configs/application.dart';
import 'package:heidi/src/utils/configs/routes.dart';
import 'package:heidi/src/utils/multiple_gesture_detector.dart';
import 'package:heidi/src/utils/translate.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({Key? key, required this.item}) : super(key: key);

  final ProductModel item;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final _scrollController = ScrollController();
  final _productDetailCubit = ProductDetailCubit();
  Color? _iconColor = Colors.white;
  int currentImageIndex = 0;

  final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers = {
    Factory(() => EagerGestureRecognizer())
  };

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _productDetailCubit.onLoad(widget.item);
  }

  @override
  void dispose() {
    _productDetailCubit.close();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    Color? color;
    if (_scrollController.position.extentBefore < 110) {
      color = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white;
    }
    if (color != _iconColor) {
      setState(() {
        _iconColor = color;
      });
    }
  }

  void _showMessage(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            Translate.of(context).translate('explore_product'),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            AppButton(
              Translate.of(context).translate('close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
              type: ButtonType.text,
            ),
          ],
        );
      },
    );
  }

  ///Phone action
  void _phoneAction(String phone) async {
    String cleanedPhone = phone.replaceAll(' ', '');
    try {
      await launchUrl(Uri.parse('tel:$cleanedPhone'));
    } catch (e, stackTrace) {
      if (!mounted) return;
      _showMessage(Translate.of(context).translate('cannot_make_action'));
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  ///Mail action
  void _mailAction(String email) async {
    try {
      launchUrl(Uri.parse('mailto:$email'));
      // launch('mailto:$email');
    } catch (e, stackTrace) {
      _showMessage(Translate.of(context).translate('cannot_make_action'));
      await Sentry.captureException(e, stackTrace: stackTrace);
    }
  }

  void _makeAction(String link) async {
    if (!link.startsWith("https://") && !link.startsWith("http://")) {
      link = "https://$link";
    }

    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(link));

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SafeArea(
          top: false,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                color: Colors.black,
                padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        link,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).size.height - kToolbarHeight - 30,
                child: WebViewWidget(
                  controller: webViewController,
                  gestureRecognizers: gestureRecognizers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  ///Build content UI
  Widget _buildContent(ProductModel? product, List<FavoriteModel>? favoriteList,
      UserModel? userDetail, bool isLoggedIn, bool isDarkMode) {
    String uniqueKey = UniqueKey().toString();
    List<Widget> action = [];
    Widget actionGalleries = Container();
    Widget banner = AppPlaceholder(
      child: Container(
        color: Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
      ),
    );
    Widget address = Container();
    Widget phone = Container();
    Widget fax = Container();
    Widget email = Container();
    Widget website = Container();
    Widget startDate = Container();
    Widget endDate = Container();
    Widget openHours = Container();
    Widget attachments = Container();
    Widget createdDate = Container();
    Widget description = Container();
    Widget bookAppointment = Container();
    Widget info = AppPlaceholder(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              height: 16,
              width: 150,
              color:
                  Theme.of(context).textTheme.bodyLarge?.color ?? Colors.white,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 16,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 20,
                      width: 150,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                ),
                Container(
                  height: 10,
                  width: 100,
                  color: Theme.of(context).textTheme.bodyLarge?.color ??
                      Colors.white,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).textTheme.bodyLarge?.color ??
                        Colors.white,
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      height: 10,
                      width: 100,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      height: 10,
                      width: 200,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 24),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            const SizedBox(height: 4),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            const SizedBox(height: 4),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            const SizedBox(height: 4),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            const SizedBox(height: 4),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
            const SizedBox(height: 4),
            Container(
                height: 10,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white),
          ],
        ),
      ),
    );
    double carouselHeight = 0;
    if (Platform.isAndroid) {
      double screenHeight = MediaQuery.of(context).size.height;
      double screenWidth = MediaQuery.of(context).size.width;
      double safeAreaVertical = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom +
          kToolbarHeight;
      double aspectRatio = screenWidth / screenHeight;
      double maxCarouselHeight = 350;
      double targetHeightRatioPortrait = 0.35;
      double targetHeightRatioLandscape = 0.3;
      if (aspectRatio > 1.0) {
        carouselHeight =
            screenHeight * targetHeightRatioLandscape - safeAreaVertical;
      } else {
        carouselHeight =
            screenHeight * targetHeightRatioPortrait - safeAreaVertical;
      }
      carouselHeight = math.min(carouselHeight, maxCarouselHeight);
    } else if (Platform.isIOS) {
      double screenHeight = MediaQuery.of(context).size.height;
      double safeAreaVertical = MediaQuery.of(context).padding.top +
          MediaQuery.of(context).padding.bottom;
      double targetHeightRatio = 0.35;
      carouselHeight = (screenHeight - safeAreaVertical) * targetHeightRatio;
    }
    if (product != null) {
      ///Action
      action = [
        actionGalleries,
        const SizedBox(width: 8),
      ];
      banner = product.pdf == ''
          ? InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.imageZoom, arguments: {
                  'sourceId': product.sourceId,
                  'imageList': product.imageLists,
                  'pdf': null,
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CarouselSlider(
                          options: CarouselOptions(
                            aspectRatio:
                                1 / MediaQuery.of(context).devicePixelRatio,
                            height: carouselHeight,
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            enableInfiniteScroll:
                                product.imageLists!.length > 1,
                            onPageChanged: (index, reason) {
                              setState(() {
                                currentImageIndex = index;
                              });
                            },
                          ),
                          items: product.imageLists?.map((imageUrl) {
                            return Builder(
                              builder: (BuildContext context) {
                                String? imageUrlString = product.sourceId ==
                                            2 &&
                                        imageUrl.logo != null &&
                                        imageUrl.logo != 'admin/News.jpeg'
                                    ? imageUrl.logo
                                    : product.sourceId == 3 &&
                                            imageUrl.logo != null
                                        ? (imageUrl.logo!.startsWith('admin')
                                            ? "${Application.picturesURL}${imageUrl.logo}"
                                            : imageUrl.logo)
                                        : imageUrl.logo != null &&
                                                imageUrl.logo!
                                                    .startsWith('admin')
                                            ? "${Application.picturesURL}${imageUrl.logo}"
                                            : "${Application.picturesURL}${imageUrl.logo}";
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  decoration: const BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Image.network(
                                    imageUrlString!,
                                    fit: BoxFit.fitHeight,
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent? loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      } else {
                                        return AppPlaceholder(
                                          child: Container(
                                            width: 120,
                                            height: 140,
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(8),
                                                bottomLeft: Radius.circular(8),
                                              ),
                                            ),
                                            child: const Icon(Icons.error),
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        if (product.imageLists!.length > 1)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: product.imageLists!.map((url) {
                                int index = product.imageLists!.indexOf(url);
                                return Container(
                                  width: 10.0,
                                  height: 10.0,
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 2.0),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: currentImageIndex == index
                                        ? Colors.blueAccent
                                        : Colors.grey,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          : RawGestureDetector(
              gestures: {
                AllowMultipleGestureRecognizer:
                    GestureRecognizerFactoryWithHandlers<
                        AllowMultipleGestureRecognizer>(
                  () => AllowMultipleGestureRecognizer(), //constructor
                  (AllowMultipleGestureRecognizer instance) {
                    instance.onTap = () async {
                      if (!mounted) return;
                      Navigator.pushNamed(context, Routes.imageZoom,
                          arguments: {
                            'sourceId': product.sourceId,
                            'imageList': product.imageLists,
                            'pdf':
                                "${Application.picturesURL}${product.pdf}?cacheKey=$uniqueKey",
                          }
                          // arguments:
                          //     "${Application.picturesURL}${product.pdf}?cacheKey=$uniqueKey",
                          );
                    };
                  },
                )
              },
              child: const PDF().cachedFromUrl(
                "${Application.picturesURL}${product.pdf}?cacheKey=$uniqueKey",
                placeholder: (progress) => Center(child: Text('$progress %')),
                errorWidget: (error) => Center(child: Text(error.toString())),
              ),
            );

      if (product.address.isNotEmpty) {
        address = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).dividerColor,
                          ),
                          child: Icon(
                            Icons.location_on_outlined,
                            color:
                                Theme.of(context).textTheme.bodyLarge?.color ??
                                    Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                Translate.of(context).translate('address'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              Text(
                                product.address,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }

      if (product.phone.isNotEmpty) {
        phone = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _phoneAction(product.phone);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Icon(
                      Icons.phone_outlined,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('phone'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          product.phone,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }

      if (product.email.isNotEmpty) {
        email = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _mailAction(product.email);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Icon(
                      Icons.email_outlined,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('email'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          product.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }

      if (product.website.isNotEmpty) {
        website = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            InkWell(
              onTap: () {
                _makeAction(product.website);
              },
              child: Row(
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).dividerColor,
                    ),
                    child: Icon(
                      Icons.language_outlined,
                      color: Theme.of(context).textTheme.bodyLarge?.color ??
                          Colors.white,
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          Translate.of(context).translate('website'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        Text(
                          product.website,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      }

      if (product.startDate.isNotEmpty || product.endDate != "") {
        startDate = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Translate.of(context).translate(
                'start_date',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Text(
              product.startDate,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      }

      if (product.endDate.isNotEmpty) {
        endDate = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              Translate.of(context).translate(
                'end_date',
              ),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            Text(
              product.endDate,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      }

      ///Create Date
      if (product.createDate.isNotEmpty) {
        createdDate = Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              product.createDate,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            )
          ],
        );
      }

      if (product.description.isNotEmpty) {
        String modifiedDescription = product.description;
        String color = (isDarkMode) ? 'white' : 'black';
        String hexColor = (isDarkMode) ? '#ffffff' : '#000000';

        modifiedDescription = modifiedDescription.replaceAll(
            RegExp(r'color: [^;]+;'), "color: $color");

        description = HtmlWidget(modifiedDescription,
            textStyle: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.bodyLarge?.color ??
                    Colors.white,
                height: 1.6), customStylesBuilder: (element) {
          if (element.localName == 'img') {
            return {'max-width': '100%'};
          } else if (element.localName == '') {
            return {'color': hexColor};
          }
          var style = element.attributes['style'];
          if (style != null) {
            style =
                style.replaceAll(RegExp(r'color:[^;];?'), 'color: $hexColor;');
          } else {
            style = 'color: $hexColor;';
          }

          RegExp exp = RegExp(
            r'<a\s+[^>]*\bhref="([^"]+\.(?:jpg|png))"[^>]*>.*?<a>',
            caseSensitive: false,
          );

          modifiedDescription =
              modifiedDescription.replaceAllMapped(exp, (match) {
            String href = match.group(1) ?? "";
            return '<img src="$href">';
          });
          return {'style': style};
          // onTapUrl: (url) {
          //   if (Uri.parse(url).hasAbsolutePath) {
          //     _makeAction(url);
          //   }
          //   return false;
        });
      }
      if (product.isBookable) {
        bookAppointment = AppButton(
          Translate.of(context).translate('book'),
          onPressed: () {
            if (isLoggedIn) {
              Navigator.pushNamed(context, Routes.booking, arguments: {
                'cityId': product.cityId ?? 1,
                'listingId': product.id,
              });
            } else {
              ScaffoldMessenger.of(context).removeCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content:
                      Text(Translate.of(context).translate('login_required'))));
            }
          },
          mainAxisSize: MainAxisSize.max,
        );
      }

      info = Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                // price,
                // booking,
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.category != null
                          ? product.category as String
                          : '',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                  ],
                ),
                Visibility(
                  visible: isLoggedIn,
                  child: IconButton(
                    icon: Icon(
                      product.favorite ? Icons.favorite : Icons.favorite_border,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () async {
                      setState(() {
                        _productDetailCubit.setFavoriteIconValue();
                        product.favorite =
                            _productDetailCubit.getFavoriteIconValue();
                      });
                      if (_productDetailCubit.getFavoriteIconValue()) {
                        await _productDetailCubit.onAddFavorite(widget.item);
                      } else {
                        await _productDetailCubit.onDeleteFavorite(widget.item);
                      }
                    },
                  ),
                ),
              ],
            ),
            createdDate,
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                startDate,
                endDate
                // priceRange,
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [bookAppointment],
            ),
            description,
            address,
            phone,
            fax,
            email,
            website,
            openHours,
            attachments,
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).dividerColor.withOpacity(
                          .05,
                        ),
                    spreadRadius: 4,
                    blurRadius: 4,
                    offset: const Offset(
                      0,
                      2,
                    ), // changes position of shadow
                  ),
                ],
              ),
              child: AppUserInfo(
                user: userDetail,
                onPressed: () async {
                  final loggedInUserId = await context
                      .read<ProductDetailCubit>()
                      .getLoggedInUserId();
                  if (!mounted) return;
                  final productUserId = await context
                      .read<ProductDetailCubit>()
                      .getUserDetails(widget.item.userId, widget.item.cityId);
                  if (product.sourceId != 2 && product.sourceId != 3) {
                    if (productUserId?.id == loggedInUserId) {
                      if (!mounted) return;
                      Navigator.pushNamed(context, Routes.profile,
                              arguments: {'user': userDetail, 'editable': true})
                          .then((value) {
                        setState(() {});
                      });
                    } else {
                      if (!mounted) return;
                      Navigator.pushNamed(context, Routes.profile, arguments: {
                        'user': userDetail,
                        'editable': false
                      }).then((value) {
                        setState(() {});
                      });
                    }
                  }
                },
                type: UserViewType.information,
                showDirectionIcon:
                    product.sourceId != 2 && product.sourceId != 3,
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Theme.of(context).iconTheme.color,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          expandedHeight: MediaQuery.of(context).size.height * 0.27,
          pinned: true,
          actions: action,
          iconTheme: Theme.of(context).iconTheme.copyWith(color: _iconColor),
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.none,
            background: banner,
          ),
        ),
        SliverToBoxAdapter(
          child: SafeArea(
            top: false,
            child: Column(
              children: <Widget>[
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(),
                ),
                info,
                // latest,
                const SizedBox(height: 16),
                // related,
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => _productDetailCubit,
        child: BlocBuilder<ProductDetailCubit, ProductDetailState>(
          builder: (context, state) {
            ProductModel? product;
            List<FavoriteModel>? favoriteList;
            UserModel? userDetail;
            bool isDarkMode = true;
            bool isLoggedIn = false;
            if (state is ProductDetailLoaded) {
              product = state.product;
              favoriteList = state.favoritesList;
              isLoggedIn = state.isLoggedIn;
              userDetail = state.userDetail;
              isDarkMode = state.isDarkMode;
            }
            return _buildContent(
                product, favoriteList, userDetail, isLoggedIn, isDarkMode);
          },
        ),
      ),
    );
  }
}
