import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:wallpaper_app/constants.dart';

class Menu extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> menuScaleAnimation;

  const Menu(
      {@required this.slideAnimation, @required this.menuScaleAnimation});
  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slideAnimation,
      child: ScaleTransition(
        scale: menuScaleAnimation,
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'W',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      TextSpan(
                        text: "all ",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      TextSpan(
                        text: 'U',
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      ),
                      TextSpan(
                        text: "p",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 80,
                      width: 80,
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/profile.jpg'),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Alex Zack',
                          style: TextStyle(
                              color: Constants.text_Color, fontSize: 22),
                        ),
                        Text(
                          'Karachi, Pakistan',
                          style: TextStyle(
                              color: Constants.text_Color.withOpacity(0.5),
                              fontSize: 16),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                MenuTile(
                  tileTitle: 'How to Set',
                  tileIcon: MdiIcons.contentCopy,
                ),
                MenuTile(
                  tileTitle: 'Send Feedback',
                  tileIcon: MdiIcons.thumbUp,
                ),
                MenuTile(
                  tileTitle: 'Share',
                  tileIcon: MdiIcons.share,
                ),
                MenuTile(
                  tileTitle: 'Terms of Use',
                  tileIcon: MdiIcons.note,
                ),
                MenuTile(
                  tileTitle: 'Privacy Policy',
                  tileIcon: MdiIcons.lock,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MenuTile extends StatelessWidget {
  final String tileTitle;
  final IconData tileIcon;

  const MenuTile({@required this.tileTitle, @required this.tileIcon});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              icon: Icon(
                tileIcon,
                color: Constants.text_Color,
                size: 32,
              ),
              onPressed: () {}),
          SizedBox(
            width: 20,
          ),
          Text(
            tileTitle,
            style: TextStyle(color: Constants.text_Color, fontSize: 19),
          ),
        ],
      ),
    );
  }
}
