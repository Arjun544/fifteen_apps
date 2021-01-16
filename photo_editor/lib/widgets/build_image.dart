import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

final GlobalKey<ExtendedImageEditorState> editorKey =
    GlobalKey<ExtendedImageEditorState>();

final defaultColorMatrix = const <double>[
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0,
  0,
  0,
  0,
  0,
  1,
  0
];

List<double> calculateSaturationMatrix(double saturation) {
  final m = List<double>.from(defaultColorMatrix);
  final invSat = 1 - saturation;
  final R = 0.213 * invSat;
  final G = 0.715 * invSat;
  final B = 0.072 * invSat;

  m[0] = R + saturation;
  m[1] = G;
  m[2] = B;
  m[5] = R;
  m[6] = G + saturation;
  m[7] = B;
  m[10] = R;
  m[11] = G;
  m[12] = B + saturation;

  return m;
}

List<double> calculateContrastMatrix(double contrast) {
  final m = List<double>.from(defaultColorMatrix);
  m[0] = contrast;
  m[6] = contrast;
  m[12] = contrast;
  return m;
}

Widget buildImage(
    File file, BuildContext context, double sat, double bright, double con) {
  return ColorFiltered(
    colorFilter: ColorFilter.matrix(calculateContrastMatrix(con)),
    child: ColorFiltered(
      colorFilter: ColorFilter.matrix(calculateSaturationMatrix(sat)),
      child: ExtendedImage(
        color: bright > 0
            ? Colors.white.withOpacity(bright)
            : Colors.black.withOpacity(-bright),
        colorBlendMode: bright > 0 ? BlendMode.lighten : BlendMode.darken,
        image: ExtendedFileImageProvider(file),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        extendedImageEditorKey: editorKey,
        mode: ExtendedImageMode.editor,
        fit: BoxFit.contain,
        initEditorConfigHandler: (ExtendedImageState state) {
          return EditorConfig(
            maxScale: 4,
            cropRectPadding: const EdgeInsets.symmetric(vertical: 100),
            hitTestSize: 40.0,
          );
        },
      ),
    ),
  );
}
