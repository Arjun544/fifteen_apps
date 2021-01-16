import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/screens/home_screen/components/wallpaper_tile.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'searchscreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  ScrollController _scrollController = new ScrollController();
  TextEditingController _searchController = TextEditingController();
  StreamController _streamController;
  Stream _stream;
  int noOfImageToLoad = 30;

  getSearchedWall() async {
    String searchQuery = _searchController.text;
    Response response = await get(
        'https://api.pexels.com/v1/search?query=$searchQuery&per_page=$noOfImageToLoad&page=1',
        headers: {"Authorization": Constants.apiKey});
    print(response.body);
    _streamController.add(json.decode(response.body));
  }

  @override
  void initState() {
    super.initState();
    _streamController = StreamController();
    _stream = _streamController.stream;

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        noOfImageToLoad = noOfImageToLoad + 30;
        getSearchedWall();
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
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: 20),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        height: screenHeight * 0.09,
                        width: screenWidth * 0.9,
                        decoration: BoxDecoration(
                          color: Constants.text_Color,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  if (_searchController.text != '') {
                                    getSearchedWall();
                                  }
                                },
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'seach wallpapers',
                                  hintStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Results :",
                      style:
                          TextStyle(color: Constants.text_Color, fontSize: 24),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                      stream: _stream,
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Center(
                            child: Text(
                              'Enter a word',
                              style: TextStyle(
                                fontSize: 18,
                                color: Constants.text_Color,
                              ),
                            ),
                          );
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return Container(
                          child: GridView.builder(
                            controller: _scrollController,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              // MediaQuery.of(context).orientation ==
                              //         Orientation.portrait
                              //     ? 200
                              //     : 250,
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
          ],
        ),
      ),
    );
  }
}
