// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_const_constructors, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable
import 'package:d_method/d_method.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/presentation/widgets/gallery_photo.dart';
import 'package:intl/intl.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../../../api/urls.dart';
import '../widgets/circle_loading.dart';

class DetailDestinationPage extends StatefulWidget {
  final DestinationEntity destination;
  const DetailDestinationPage({
    Key? key,
    required this.destination,
  }) : super(key: key);

  @override
  State<DetailDestinationPage> createState() => _DetailDestinationPageState();
}

class _DetailDestinationPageState extends State<DetailDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        children: [
          SizedBox(
            height: 10,
          ),
          gallery(),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    location(),
                    const SizedBox(
                      height: 4.0,
                    ),
                    category(),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  rate(),
                  const SizedBox(
                    height: 4.0,
                  ),
                  rateCount(),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24.0),
          facilities(),
          const SizedBox(height: 24.0),
          details(),
          const SizedBox(height: 24.0),
          review(),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }

  Widget review() {
    List list = [
      [
        'Jhon Dipsy',
        'assets/images/p1.jpg',
        4.9,
        'Best place',
        '2023-01-02',
      ],
      [
        'Mikael Lunch',
        'assets/images/p2.jpg',
        4.3,
        'Unforgettable',
        '2023-03-21',
      ],
      [
        'Dinner Sopi',
        'assets/images/p3.jpg',
        5,
        'Nice one',
        '2023-09-02',
      ],
      [
        'Loro Sepuh',
        'assets/images/p4.jpg',
        4.5,
        'You should go with your family',
        '2023-09-24',
      ],
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Reviews",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...list.map(
          (e) {
            return Padding(
              padding: EdgeInsets.only(top: 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: AssetImage(
                      e[1],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              e[0],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              width: 4.0,
                            ),
                            RatingBar.builder(
                              initialRating: e[2].toDouble(),
                              allowHalfRating: true,
                              unratedColor: Colors.grey,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (value) {},
                              itemSize: 15,
                              ignoreGestures: true, // Jika diklik tidak berubah
                            ),
                            Spacer(),
                            Text(
                              DateFormat('d MMM').format(
                                DateTime.parse(
                                  e[4],
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4.0,
                        ),
                        Text(
                          e[3],
                          style: TextStyle(
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
      ],
    );
  }

  Widget details() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Details",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          widget.destination.description,
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget facilities() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Facilities",
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        ...widget.destination.facilities.map(
          (falitity) {
            return Padding(
              padding: EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.radio_button_checked,
                    size: 15.0,
                    color: Theme.of(context).primaryColor,
                  ),
                  const SizedBox(
                    width: 4.0,
                  ),
                  Text(
                    falitity,
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  Widget location() {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.centerLeft,
          child: Icon(
            Icons.location_on,
            size: 20.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          widget.destination.location,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget category() {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          alignment: Alignment.center,
          child: Icon(
            Icons.fiber_manual_record,
            size: 1.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
        const SizedBox(
          width: 4.0,
        ),
        Text(
          widget.destination.category,
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget rate() {
    return RatingBar.builder(
      initialRating: widget.destination.rate,
      allowHalfRating: true,
      unratedColor: Colors.grey,
      itemBuilder: (context, index) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (value) {},
      itemSize: 15,
      ignoreGestures: true, // Jika diklik tidak berubah
    );
  }

  Widget rateCount() {
    String rate = DMethod.numberAutoDigit(widget.destination.rate);
    String rateCount =
        NumberFormat.compact().format(widget.destination.rateCount);

    return Text(
      '$rate / $rateCount reviews',
      style: TextStyle(
        fontSize: 14.0,
        color: Colors.grey[500],
      ),
    );
  }

  Widget gallery() {
    List patternGallery = [
      StaggeredTile.count(3, 3),
      StaggeredTile.count(2, 1.5),
      StaggeredTile.count(2, 1.5),
    ];

    return StaggeredGridView.countBuilder(
      crossAxisSpacing: 12,
      mainAxisSpacing: 16,
      crossAxisCount: 5,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      staggeredTileBuilder: (index) {
        return patternGallery[index % patternGallery.length];
      },
      itemBuilder: (context, index) {
        if (index == 2) {
          return GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => GalleryPhoto(
                  images: widget.destination.images,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  itemGalleryImage(index),
                  Container(
                    color: Colors.black.withOpacity(0.3),
                    alignment: Alignment.center,
                    child: Text(
                      '+ More',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
          child: itemGalleryImage(index),
        );
      },
    );
  }

  Widget itemGalleryImage(int index) {
    return ExtendedImage.network(
      URLs.image(widget.destination.images[index]),
      fit: BoxFit.cover,
      handleLoadingProgress: true,
      loadStateChanged: (state) {
        if (state.extendedImageLoadState == LoadState.failed) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: Colors.grey[300],
              child: const Icon(
                Icons.broken_image,
                color: Colors.black,
              ),
            ),
          );
        }
        if (state.extendedImageLoadState == LoadState.loading) {
          return AspectRatio(
            aspectRatio: 16 / 9,
            child: Material(
              borderRadius: BorderRadius.all(
                Radius.circular(16.0),
              ),
              color: Colors.grey[300],
              child: CircleLoading(),
            ),
          );
        }
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      title: Text(
        widget.destination.name,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        alignment: Alignment.centerLeft,
        margin: EdgeInsets.only(
          left: 20,
          top: MediaQuery.of(context).padding.top,
        ),
        child: Row(
          children: [
            BackButton(),
          ],
        ),
      ),
    );
  }
}
