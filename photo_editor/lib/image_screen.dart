import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_editor/save_image_screen.dart';
import 'package:photo_editor/widgets/build_image.dart';
import 'package:image_editor/image_editor.dart' hide ImageSource;

class ImageScreen extends StatefulWidget {
  ImageScreen({
    Key key,
    @required this.imageFile,
  }) : super(key: key);

  final Future<File> imageFile;

  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  var file;
  bool iscontrastVisible = false;

  double sat = 1;
  double bright = 0;
  double con = 1;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: new IconButton(
                icon: new Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.pop(context, true);
                }),
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.settings_backup_restore,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    sat = 1;
                    bright = 0;
                    con = 1;
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.check,
                  color: Colors.black,
                ),
                onPressed: () async {
                  await crop();
                },
              ),
            ]),
        body: Stack(
          children: [
            Positioned(
              top: -80,
              child: FutureBuilder<File>(
                future: widget.imageFile,
                builder: (_, snapshot) {
                  file = snapshot.data;
                  if (file == null) return Container();
                  return buildImage(file, context, sat, bright, con);
                },
              ),
            ),
            Positioned(
              bottom: 100,
              right: 20,
              left: 20,
              child: Visibility(
                visible: iscontrastVisible,
                child: SliderTheme(
                  data: const SliderThemeData(
                    showValueIndicator: ShowValueIndicator.never,
                    activeTrackColor: Colors.black,
                    inactiveTrackColor: Colors.black38,
                    thumbColor: Colors.blue,
                  ),
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Spacer(flex: 3),
                        _buildSat(),
                        Spacer(flex: 1),
                        _buildBrightness(),
                        Spacer(flex: 1),
                        _buildCon(),
                        Spacer(flex: 3),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -5,
              right: 20,
              left: 20,
              child: Container(
                height: 70,
                width: MediaQuery.of(context).size.width * 0.9,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.brightness_6_rounded),
                      onPressed: () {
                        setState(() {
                          iscontrastVisible = !iscontrastVisible;
                        });
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.flip_rounded),
                      onPressed: () => flip(),
                    ),
                    IconButton(
                      icon: Icon(Icons.rotate_left_rounded),
                      onPressed: () => rotate(false),
                    ),
                    IconButton(
                      icon: Icon(Icons.rotate_right_rounded),
                      onPressed: () => rotate(true),
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

  void flip() {
    editorKey.currentState.flip();
  }

  void rotate(bool right) {
    editorKey.currentState.rotate(right: right);
  }

  Widget _buildSat() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(Icons.brush, color: Colors.white),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'sat : ${sat.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                sat = value;
              });
            },
            divisions: 50,
            value: sat,
            min: 0,
            max: 2,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(
            sat.toStringAsFixed(2),
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildCon() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(Icons.color_lens, color: Colors.white),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: 'con : ${con.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                con = value;
              });
            },
            divisions: 50,
            value: con,
            min: 0,
            max: 4,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(
            con.toStringAsFixed(2),
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildBrightness() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.03,
        ),
        Column(
          children: <Widget>[
            Icon(
              Icons.brightness_4,
              color: Colors.white,
            ),
          ],
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Slider(
            label: '${bright.toStringAsFixed(2)}',
            onChanged: (double value) {
              setState(() {
                bright = value;
              });
            },
            divisions: 50,
            value: bright,
            min: -1,
            max: 1,
          ),
        ),
        Padding(
          padding:
              EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.08),
          child: Text(
            bright.toStringAsFixed(2),
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Future<void> crop([bool test = false]) async {
    final ExtendedImageEditorState state = editorKey.currentState;
    final Rect rect = state.getCropRect();
    final EditActionDetails action = state.editAction;
    final double radian = action.rotateAngle;

    final bool flipHorizontal = action.flipY;
    final bool flipVertical = action.flipX;
    final Uint8List img = state.rawImageData;

    final ImageEditorOption option = ImageEditorOption();

    option.addOption(ClipOption.fromRect(rect));
    option.addOption(
        FlipOption(horizontal: flipHorizontal, vertical: flipVertical));
    if (action.hasRotateAngle) {
      option.addOption(RotateOption(radian.toInt()));
    }

    option.addOption(ColorOption.saturation(sat));
    option.addOption(ColorOption.brightness(bright + 1));
    option.addOption(ColorOption.contrast(con));

    option.outputFormat = const OutputFormat.jpeg(100);

    print(const JsonEncoder.withIndent('  ').convert(option.toJson()));

    final DateTime start = DateTime.now();
    final Uint8List result = await ImageEditor.editImage(
      image: img,
      imageEditorOption: option,
    );

    print('result.length = ${result.length}');

    final Duration diff = DateTime.now().difference(start);
    file.writeAsBytesSync(result);
    print('image_editor time : $diff');
    Future.delayed(Duration(seconds: 0)).then(
      (value) => Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
            builder: (context) => SaveImageScreen(
                  arguments: [file],
                )),
      ),
    );
  }
}
