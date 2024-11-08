// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_travel/api/urls.dart';
import 'package:flutter_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:flutter_travel/features/destination/presentation/bloc/search_destinaton/search_destination_bloc.dart';
import 'package:flutter_travel/features/destination/presentation/widgets/circle_loading.dart';
import 'package:flutter_travel/features/destination/presentation/widgets/text_failure.dart';

class SearchDestinationPage extends StatefulWidget {
  const SearchDestinationPage({super.key});

  @override
  State<SearchDestinationPage> createState() => _SearchDestinationPageState();
}

class _SearchDestinationPageState extends State<SearchDestinationPage> {
  final edtSearch = TextEditingController();

  // Fungsi search
  search() {
    if (edtSearch.text == '') return;
    context
        .read<SearchDestinationBloc>()
        .add(OnSearchDestination(edtSearch.text));
    FocusManager.instance.primaryFocus
        ?.unfocus(); // Setelah klik btn search keyboard akan hilang
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.only(top: 60, bottom: 80),
        color: Theme.of(context).primaryColor,
        child: buildSearch(),
      ),
      bottomSheet: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28.0),
          topRight: Radius.circular(28.0),
        ),
        child: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height - 140,
          child: BlocBuilder<SearchDestinationBloc, SearchDestinationState>(
            builder: (context, state) {
              if (state is SearchDestinationLoading) {
                return CircleLoading();
              }
              if (state is SearchDestinationFailure) {
                return TextFailure(message: state.message);
              }
              if (state is SearchDestinationLoaded) {
                List<DestinationEntity> list = state.data;
                return ListView.builder(
                  itemCount: list.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    DestinationEntity destination = list[index];
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: index == list.length - 1 ? 0 : 20,
                      ),
                      child: itemSearch(destination),
                    );
                  },
                );
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }

  AspectRatio itemSearch(DestinationEntity destination) {
    return AspectRatio(
      aspectRatio: 2,
      child: Stack(
        fit: StackFit.expand,
        children: [
          ExtendedImage.network(
            URLs.image(destination.cover),
            fit: BoxFit.cover,
            width: double.infinity,
            handleLoadingProgress: true,
            loadStateChanged: (state) {
              if (state.extendedImageLoadState == LoadState.failed) {
                return Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  color: Colors.grey[300],
                  child: const Icon(
                    Icons.broken_image,
                    color: Colors.black,
                  ),
                );
              }
              if (state.extendedImageLoadState == LoadState.loading) {
                return Material(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16.0),
                  ),
                  color: Colors.grey[300],
                  child: CircleLoading(),
                );
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AspectRatio(
              aspectRatio: 4,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black87,
                      Colors.transparent,
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            destination.name,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            destination.location,
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    RatingBar.builder(
                      initialRating: destination.rate,
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
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1.0,
          color: Colors.grey[300]!,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(30.0),
        ),
      ),
      child: Row(
        children: [
          IconButton.filledTonal(
            // fileledTonal untuk background iconnya
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_outlined,
              size: 24.0,
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: TextField(
              // isDense dan contentPadding harus akrif guys
              controller: edtSearch,
              decoration: InputDecoration(
                isDense: true,
                border: InputBorder.none,
                hintText: 'Search destination here...',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: EdgeInsets.all(0),
              ),
              cursorColor: Colors.white,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(
            width: 10.0,
          ),
          IconButton.filledTonal(
            // fileledTonal untuk background iconnya
            onPressed: () => search(),
            icon: const Icon(
              Icons.search,
              size: 24.0,
            ),
          ),
        ],
      ),
    );
  }
}
