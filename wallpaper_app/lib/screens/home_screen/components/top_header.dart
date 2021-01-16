import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TopHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        InkWell(
          child: Icon(
            MdiIcons.widgets,
            color: Colors.white,
            size: 32,
          ),
          onTap: () {},
        ),
        Icon(
          Icons.exit_to_app,
          color: Colors.white,
          size: 32,
        ),
      ],
    );
  }
}
