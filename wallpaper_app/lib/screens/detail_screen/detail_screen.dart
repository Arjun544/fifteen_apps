import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:wallpaper_app/constants.dart';

class DetailScreen extends StatefulWidget {
  final String image;
  final String imagePath;
  final int index;
  final AsyncSnapshot snapshot;

  const DetailScreen({
    @required this.image,
    @required this.imagePath,
    @required this.index,
    @required this.snapshot,
  });

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool savedImage = false;

  Future saveWallpaper() async {
    await ImageDownloader.downloadImage(widget.image);
    setState(() {
      savedImage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Constants.home_color,
      body: Stack(
        children: [
          Hero(
            tag: widget.index.toString(),
            child: Image.network(
              widget.image,
              height: screenHeight,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: Colors.teal,
                size: 40,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: 65,
            right: 20,
            child: Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(8),
              height: 40,
              width: screenWidth * 0.25,
              decoration: BoxDecoration(
                  color: Constants.text_Color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(40)),
              child: Text(
                widget.snapshot.data["photos"][widget.index]["photographer"],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 15,
            child: Container(
              height: 50,
              width: 90,
              decoration: BoxDecoration(
                color: Constants.text_Color.withOpacity(0.7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton(
                onPressed: () {
                  saveWallpaper();
                },
                child: Text(
                  savedImage ? ("Saved") : ("Save"),
                  style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
