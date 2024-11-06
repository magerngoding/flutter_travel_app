// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_travel/api/urls.dart';
import 'package:flutter_travel/features/destination/presentation/widgets/circle_loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class GalleryPhoto extends StatelessWidget {
  final List<String> images;

  const GalleryPhoto({
    Key? key,
    required this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return Stack(
      children: [
        PhotoViewGallery.builder(
          pageController: pageController,
          itemCount: images.length,
          scrollPhysics: BouncingScrollPhysics(),
          loadingBuilder: (context, event) {
            return CircleLoading();
          },
          builder: (context, index) {
            return PhotoViewGalleryPageOptions(
              imageProvider: ExtendedNetworkImageProvider(
                URLs.image(
                  images[index],
                ),
              ),
              initialScale: PhotoViewComputedScale.contained * 0.8,
              heroAttributes: PhotoViewHeroAttributes(
                tag: images[index],
              ),
            );
          },
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 30,
          child: Center(
            child: SmoothPageIndicator(
              controller: pageController,
              count: images.length,
              effect: WormEffect(
                dotColor: Colors.grey[300]!,
                activeDotColor: Theme.of(context).primaryColor,
                dotHeight: 10,
                dotWidth: 10,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: CloseButton(),
        ),
      ],
    );
  }
}
