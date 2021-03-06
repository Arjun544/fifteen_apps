import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/screens/home_screen/components/categories_section.dart';
import 'package:wallpaper_app/screens/home_screen/components/top_header.dart';
import 'package:wallpaper_app/screens/home_screen/components/wallpaper_tile.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'homescreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  StreamController _streamController;
  Stream _stream;
  int noOfImageToLoad = 30;

  getData() async {
    Response response = await http.get(
        'https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1',
        headers: {"Authorization": Constants.apiKey});
    if (response.statusCode != 403) {
      print(response.body);
      _streamController.add(json.decode(response.body));
    } else {
      print('Unable to fetch data from api');
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getData();
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: TopHeader(),
              ),
              SizedBox(height: 20),
              CategoriesSection(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Popular Shots",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 12),
              StreamBuilder(
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
                            MediaQuery.of(context).orientation ==
                                    Orientation.portrait
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
            ],
          ),
        ),
      ),
    );
  }
}
