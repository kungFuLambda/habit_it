import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  double height;

  Header(this.height);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      elevation: 8,
      pinned: true,
      floating: true,
      expandedHeight: height,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        collapseMode: CollapseMode.parallax,
        background: Image.asset('assets/fadedBack.png', fit: BoxFit.cover),
        title: Text("Habit It",
            style: TextStyle(fontSize: 40, fontFamily: 'Dancing')),
        titlePadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      ),
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10))),
    );
  }
}
