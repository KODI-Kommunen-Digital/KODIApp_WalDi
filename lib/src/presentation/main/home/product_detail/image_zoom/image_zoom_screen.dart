import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:photo_view/photo_view.dart';

class ImageZoomScreen extends StatelessWidget {
  final String imageUrl;

  const ImageZoomScreen({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uniqueKey = UniqueKey().toString();
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                height: height * 0.8,
                child: imageUrl.contains('.pdf')
                    ? const PDF().cachedFromUrl(
                        '$imageUrl?cacheKey=$uniqueKey',
                        placeholder: (progress) =>
                            Center(child: Text('$progress %')),
                        errorWidget: (error) =>
                            Center(child: Text(error.toString())),
                      )
                    : PhotoView(
                        imageProvider: CachedNetworkImageProvider(
                            imageUrl.contains('admin/News.jpeg')
                                ? imageUrl
                                : '$imageUrl?cacheKey=$uniqueKey'),
                        minScale: PhotoViewComputedScale.contained * 0.8,
                        maxScale: PhotoViewComputedScale.covered * 2.0,
                        initialScale: PhotoViewComputedScale.contained,
                      ),
              ),
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
