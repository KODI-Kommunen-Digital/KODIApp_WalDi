import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:heidi/src/data/model/model_product.dart';
import 'package:heidi/src/presentation/widget/app_placeholder.dart';
import 'package:heidi/src/utils/configs/application.dart';

class ImageZoomScreen extends StatefulWidget {
  final List<ImageListModel>? imageList;
  final String pdf;

  const ImageZoomScreen({
    Key? key,
    required this.imageList,
    required this.pdf,
  }) : super(key: key);

  @override
  State<ImageZoomScreen> createState() => _ImageZoomScreenState();
}

class _ImageZoomScreenState extends State<ImageZoomScreen> {
  int currentImageIndex = 0;
  final memoryCacheManager = DefaultCacheManager();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.8,
                child: widget.pdf != ''
                    ? const PDF().cachedFromUrl(
                        widget.pdf,
                        placeholder: (progress) =>
                            Center(child: Text('$progress %')),
                        errorWidget: (error) => Center(
                          child: Text(
                            error.toString(),
                          ),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(
                              color: Colors
                                  .black, // Change the background color to black
                            ),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                height: 550.0,
                                viewportFraction: 1.0,
                                enlargeCenterPage: false,
                                enableInfiniteScroll:
                                    widget.imageList!.length > 1,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    currentImageIndex = index;
                                  });
                                },
                              ),
                              items: widget.imageList?.map((imageUrl) {
                                return Builder(
                                  builder: (BuildContext context) {
                                    return Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      decoration: const BoxDecoration(
                                        color: Colors.black,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        decoration: const BoxDecoration(
                                          color: Colors
                                              .black, // Change the background color to black
                                        ),
                                        child: Image.network(
                                          '${Application.picturesURL}${imageUrl.logo!}',
                                          fit: BoxFit.fitHeight,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child; // Return the actual image if loading is complete.
                                            } else {
                                              return AppPlaceholder(
                                                child: Container(
                                                  width: 120,
                                                  height: 140,
                                                  decoration:
                                                      const BoxDecoration(
                                                    color: Colors.black,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  child:
                                                      const Icon(Icons.error),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      // child: Image.network(
                                      //   '${Application.picturesURL}${imageUrl.logo!}',
                                      //   fit: BoxFit.fitHeight,
                                      // ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: widget.imageList!.map((url) {
                              int index = widget.imageList!.indexOf(url);
                              return Container(
                                width: 10.0,
                                height: 10.0,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 2.0),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: currentImageIndex == index
                                      ? Colors.blueAccent
                                      : Colors.grey,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                // PhotoView(
                //         imageProvider: CachedNetworkImageProvider(
                //             imageUrl.contains('admin/News.jpeg')
                //                 ? imageUrl
                //                 : imageUrl.contains('instagram')
                //                     ? imageUrl
                //                     : '$imageUrl?cacheKey=$uniqueKey'),
                //         minScale: PhotoViewComputedScale.contained * 0.8,
                //         maxScale: PhotoViewComputedScale.covered * 2.0,
                //         initialScale: PhotoViewComputedScale.contained,
                //       ),
              ),

              // Image.network(
              //   imageUrl,
              //   width: double.infinity, // Set the image width to maximum
              // ),
            ),
            Positioned(
              top: 10, // Adjust the top position of the back button
              left: 10, // Adjust the left position of the back button
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(
                      context); // Navigate back when the button is pressed
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
