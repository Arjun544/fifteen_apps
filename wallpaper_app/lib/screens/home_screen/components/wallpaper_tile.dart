import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/constants.dart';
import 'package:wallpaper_app/screens/detail_screen/detail_screen.dart';

class WallpaperTile extends StatelessWidget {
  final double screenWidth;
  final int index;
  final AsyncSnapshot snapshot;

  WallpaperTile(
      {@required this.screenWidth,
      @required this.index,
      @required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return DetailScreen(
                image: snapshot.data["photos"][index]["src"]["portrait"],
                imagePath: snapshot.data['photos'][index]['url'],
                index: index,
                snapshot: snapshot,
              );
            },
          ),
        );
      },
      child: Container(
        width: screenWidth,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
              child: Hero(
                tag: index.toString(),
                child: Image.network(
                  snapshot.data["photos"][index]["src"]["portrait"],
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(8),
              height: 50,
              width: screenWidth * 0.35,
              decoration: BoxDecoration(
                color: Constants.text_Color.withOpacity(0.5),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Text(
                snapshot.data["photos"][index]["photographer"],
                textAlign: TextAlign.center,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
            Positioned(
              right: 10,
              bottom: 10,
              child: Icon(
                Icons.favorite_border,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
