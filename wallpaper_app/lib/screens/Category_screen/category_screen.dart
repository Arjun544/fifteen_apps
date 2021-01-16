import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallpaper_app/screens/home_screen/components/wallpaper_tile.dart';

import '../../constants.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({@required this.category});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  ScrollController _scrollController = new ScrollController();
  StreamController _streamController;
  Stream _stream;
  int noOfImageToLoad = 30;

  getCategoryWall() async {
    Response response = await get(
        'https://api.pexels.com/v1/search?query=${widget.category}&per_page=$noOfImageToLoad&page=1',
        headers: {"Authorization": Constants.apiKey});
    print(response.body);
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    getCategoryWall();
    super.initState();

    _streamController = StreamController();
    _stream = _streamController.stream;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getCategoryWall();
      }
    });
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.home_color,
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return Container(
              padding: EdgeInsets.only(right: 10, left: 10),
              height: screenHeight,
              child: GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? 300
                          : 250,
                  childAspectRatio: 0.6625,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data["photos"].length,
                itemBuilder: (context, index) {
                  return WallpaperTile(
                    screenWidth: screenWidth,
                    index: index,
                    snapshot: snapshot,
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
