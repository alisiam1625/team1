import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:collection' show Queue;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:team1/DbImages.dart';
import 'package:team1/DbStrings.dart';
import 'package:team1/model/Db1Model.dart';
import 'package:team1/model/Db2Model.dart';
import 'package:team1/model/Db3Model.dart';
import 'package:team1/model/Db5Model.dart';
import 'package:team1/model/Db7Model.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

import 'model/Db4Model.dart';
import 'model/Db8Model.dart';





class DemoDashboard6 extends StatefulWidget {
  static String tag = '/DemoDashboard6';

  @override
  DemoDashboard6State createState() => DemoDashboard6State();
}

const fontMedium = 'Medium';
const fontBold = 'Bold';

class DemoDashboard6State extends State<DemoDashboard6> {
  late List<DB6Service> mList1;
  late List<DB6Laundry> mList2;
  late List<DB6Offer> mList3;
  var _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    mList1 = getTopLaundryService();
    mList2 = getLaundry();
    mList3 = getOffer();
  }

  Widget db6Label(var text) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(text, style: TextStyle(fontSize: 18, color: db6_black, fontFamily: fontMedium)),
          Text(db6_lbl_view_all, style: TextStyle(fontSize: 14, color: db6_textColorSecondary)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double expandHeight = 260;
    double w = MediaQuery.of(context).size.width;

    changeStatusColor(db6_colorPrimary);

    return Scaffold(

      body: NestedScrollView(
        //Header
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: expandHeight,
              floating: true,
              forceElevated: innerBoxIsScrolled,
              pinned: true,
              titleSpacing: 0,
              backgroundColor: innerBoxIsScrolled ? db6_colorPrimary : db6_colorPrimary,
              actionsIconTheme: IconThemeData(opacity: 0.0),
              leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: white),
                  onPressed: () {
                    finish(context);
                  }),
              title: Container(
                height: 60,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16, 16, 8, 0),
                  child: Text(db6_username, style: boldTextStyle(color: db6_white, size: 24, fontFamily: fontBold)),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 200,
                  margin: EdgeInsets.only(top: 70),
                  color: db6_colorPrimary,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
                        child: Text(db6_your_location, style: primaryTextStyle(color: db6_white)),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(16, 2, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(right: 4),
                                      child: Icon(Icons.location_on, color: db6_white, size: 16),
                                    ),
                                  ),
                                  TextSpan(text: db6_san_francisco, style: primaryTextStyle(size: 18, color: db6_white)),
                                ],
                              ),
                            ),
                            Text(db6_change, style: primaryTextStyle(color: db6_white, size: 18)),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(16)), color: white),
                          child: TextField(
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                fillColor: db6_white,
                                hintText: db6_hint_search,
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.search),
                                contentPadding: EdgeInsets.only(left: 26.0, bottom: 8.0, top: 8.0, right: 50.0),
                              )),
                          alignment: Alignment.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ];
        },
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //Top Services
                SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 16, 0, 16),
                  child: Text(
                    db6_lbl_top_services,
                    style: primaryTextStyle(size: 20, fontFamily: fontBold),
                  ),
                ),
                SizedBox(
                  height: w * 0.3,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mList1.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return D6TopService(mList1[index], index);
                      }),
                ),

                //Nearby Laundry
                db6Label(db6_lbl_nearby_laundry),
                SizedBox(
                  height: w * 0.5,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mList2.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return D6Popular(mList2[index], index);
                      }),
                ),

                //Offers
                db6Label(db6_lbl_pkg_offers),
                SizedBox(
                  height: w * 0.4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: mList3.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return D6Special(mList3[index], index);
                      }),
                ),
                SizedBox(height: 16)
              ],
            ),
          ),
        ),
      ),

      //Footer
      bottomNavigationBar: Container(
        decoration: BoxDecoration(boxShadow: [BoxShadow(color: dbShadowColor, offset: Offset.fromDirection(3, 1), spreadRadius: 1, blurRadius: 5)]),
        child: Db6BottomNavigationBar(
          items: <Db6BottomNavigationBarItem>[
            Db6BottomNavigationBarItem(icon: db6_ic_home, title: Text(db6_lbl_home, style: TextStyle(color: db6_textColorSecondary))),
            Db6BottomNavigationBarItem(icon: db6_ic_pin, title: Text(db6_lbl_nearby, style: TextStyle(color: db6_textColorSecondary))),
            Db6BottomNavigationBarItem(icon: db6_ic_basket, title: Text(db6_lbl_booking, style: TextStyle(color: db6_textColorSecondary))),
            Db6BottomNavigationBarItem(icon: db6_ic_sale, title: Text(db6_lbl_Offers, style: TextStyle(color: db6_textColorSecondary))),
            Db6BottomNavigationBarItem(icon: db6_ic_user, title: Text(db6_lbl_profile, style: TextStyle(color: db6_textColorSecondary))),
          ],
          currentIndex: _selectedIndex,
          unselectedIconTheme: IconThemeData(color: db6_textColorSecondary, size: 24),
          selectedIconTheme: IconThemeData(color: db6_colorPrimary, size: 24),
          selectedLabelStyle: TextStyle(color: db6_colorPrimary),
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: Db6BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void changeStatusColor(Color color) async {
    setStatusBarColor(color);
  }

}

// ignore: must_be_immutable
class D6TopService extends StatelessWidget {
  late DB6Service model;

  D6TopService(DB6Service model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color: db6_white, boxShadow: [BoxShadow(color: dbShadowColor, blurRadius: 10, spreadRadius: 2)]),
            width: width * 0.2,
            height: width * 0.2,
            padding: EdgeInsets.all(width * 0.05),
            child: Image.asset(
              model.img,
            ),
          ),
          SizedBox(height: 6),
          Text(model.name, style: primaryTextStyle(color: db1_textColorSecondary))
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class D6Popular extends StatelessWidget {
  late DB6Laundry model;

  D6Popular(DB6Laundry model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
        width: MediaQuery.of(context).size.width * 0.7,
        margin: EdgeInsets.only(left: 16, top: 8, bottom: 8),
        decoration: BoxDecoration(
          color: db6_white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: defaultBoxShadow(),
        ),
        child: ListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(child: Image.asset(model.img, fit: BoxFit.fill, height: width * 0.2, width: width * 0.2)),
                  SizedBox(height: 10),
                  Divider(height: 0.5, color: db6_viewColor, thickness: 0.5),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(model.name, style: primaryTextStyle(size: 14)),
                      RichText(
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyLarge,
                          children: [
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4.0),
                                child: Icon(Icons.star_border, color: db6_yellow, size: 16),
                              ),
                            ),
                            TextSpan(text: model.rating, style: primaryTextStyle(size: 16, color: db6_textColorSecondary)),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(model.location, style: primaryTextStyle(color: db6_textColorSecondary)),
                ],
              ),
            ),
          ],
        ));
  }
}

// ignore: must_be_immutable
class D6Special extends StatelessWidget {

  late DB6Offer model;

  D6Special(DB6Offer model, int pos) {
    this.model = model;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      margin: EdgeInsets.only(left: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(color: db6_white, borderRadius: BorderRadius.all(Radius.circular(10)), boxShadow: defaultBoxShadow()),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Image.asset(model.img, height: width * 0.17, width: width * 0.2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(model.title, style: primaryTextStyle()),
                Text(model.subTitle, style: primaryTextStyle(color: db6_colorPrimary, size: 20, fontFamily: 'Medium')),
                SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  child: Container(
                      padding: EdgeInsets.fromLTRB(16, 6, 16, 6),
                      child: Text(db6_lbl_view_offers.toUpperCase(), style: primaryTextStyle(color: db6_white, fontFamily: 'Medium')),
                      decoration: BoxDecoration(color: db6_colorPrimary, borderRadius: BorderRadius.all(Radius.circular(6)))),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DB6Laundry {
  var name = "";
  var img = "";
  var location = "";
  var rating = "";
}

class DB6Offer {
  var title = "";
  var img = "";
  var subTitle = "";
}

class DB6Service {
  var name = "";
  var img = "";
}











enum Db6BottomNavigationBarType {
  /// The [Db6BottomNavigationBar]'s [Db6BottomNavigationBarItem]s have fixed width.
  fixed,
  shifting,
}

class Db6BottomNavigationBar extends StatefulWidget {
  Db6BottomNavigationBar({
    Key? key,
    required this.items,
    this.onTap,
    this.currentIndex = 0,
    this.elevation = 8.0,
    Db6BottomNavigationBarType? type,
    Color? fixedColor,
    this.backgroundColor,
    this.iconSize = 24.0,
    Color? selectedItemColor,
    this.unselectedItemColor,
    this.selectedIconTheme = const IconThemeData(),
    this.unselectedIconTheme = const IconThemeData(),
    this.selectedFontSize = 14.0,
    this.unselectedFontSize = 12.0,
    this.selectedLabelStyle,
    this.unselectedLabelStyle,
    this.showSelectedLabels = true,
    bool? showUnselectedLabels,
  })  : assert(items.length >= 2),
        assert(0 <= currentIndex && currentIndex < items.length),
        assert(elevation >= 0.0),
        assert(iconSize >= 0.0),
        assert(selectedItemColor == null || fixedColor == null, 'Either selectedItemColor or fixedColor can be specified, but not both'),
        assert(selectedFontSize >= 0.0),
        assert(unselectedFontSize >= 0.0),
        type = _type(type, items),
        selectedItemColor = selectedItemColor ?? fixedColor,
        showUnselectedLabels = showUnselectedLabels ?? _defaultShowUnselected(_type(type, items)),
        super(key: key);

  /// Defines the appearance of the button items that are arrayed within the
  /// bottom navigation bar.
  final List<Db6BottomNavigationBarItem> items;

  /// Called when one of the [items] is tapped.
  ///
  /// The stateful widget that creates the bottom navigation bar needs to keep
  /// track of the index of the selected [Db6BottomNavigationBarItem] and call
  /// `setState` to rebuild the bottom navigation bar with the new [currentIndex].
  final ValueChanged<int>? onTap;

  /// The index into [items] for the current active [Db6BottomNavigationBarItem].
  final int currentIndex;

  /// The z-coordinate of this [Db6BottomNavigationBar].
  ///
  /// If null, defaults to `8.0`.
  ///
  /// {@macro flutter.material.material.elevation}
  final double elevation;

  /// Defines the layout and behavior of a [Db6BottomNavigationBar].
  ///
  /// See documentation for [Db6BottomNavigationBarType] for information on the
  /// meaning of different types.
  final Db6BottomNavigationBarType type;

  /// The value of [selectedItemColor].
  ///
  /// This getter only exists for backwards compatibility, the
  /// [selectedItemColor] property is preferred.
  Color? get fixedColor => selectedItemColor;

  /// The color of the [Db6BottomNavigationBar] itself.
  ///
  /// If [type] is [Db6BottomNavigationBarType.shifting] and the
  /// [items]s, have [Db6BottomNavigationBarItem.backgroundColor] set, the [item]'s
  /// backgroundColor will splash and overwrite this color.
  final Color? backgroundColor;

  /// The size of all of the [Db6BottomNavigationBarItem] icons.
  ///
  /// See [Db6BottomNavigationBarItem.icon] for more information.
  final double iconSize;

  /// The color of the selected [Db6BottomNavigationBarItem.icon] and
  /// [Db6BottomNavigationBarItem.label].
  ///
  /// If null then the [ThemeData.primaryColor] is used.
  final Color? selectedItemColor;

  /// The color of the unselected [Db6BottomNavigationBarItem.icon] and
  /// [Db6BottomNavigationBarItem.label]s.
  ///
  /// If null then the [TextTheme.caption]'s color is used.
  final Color? unselectedItemColor;

  /// The size, opacity, and color of the icon in the currently selected
  /// [Db6BottomNavigationBarItem.icon].
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [selectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties. Also, if this field is supplied,
  /// [unselectedIconTheme] must be provided.
  final IconThemeData selectedIconTheme;

  /// The size, opacity, and color of the icon in the currently unselected
  /// [Db6BottomNavigationBarItem.icon]s
  ///
  /// If this is not provided, the size will default to [iconSize], the color
  /// will default to [unselectedItemColor].
  ///
  /// It this field is provided, it must contain non-null [IconThemeData.size]
  /// and [IconThemeData.color] properties. Also, if this field is supplied,
  /// [unselectedIconTheme] must be provided.
  final IconThemeData unselectedIconTheme;

  /// The [TextStyle] of the [Db6BottomNavigationBarItem] labels when they are
  /// selected.
  final TextStyle? selectedLabelStyle;

  /// The [TextStyle] of the [Db6BottomNavigationBarItem] labels when they are not
  /// selected.
  final TextStyle? unselectedLabelStyle;

  /// The font size of the [Db6BottomNavigationBarItem] labels when they are selected.
  ///
  /// If [selectedLabelStyle.fontSize] is non-null, it will be used instead of this.
  ///
  /// Defaults to `14.0`.
  final double selectedFontSize;

  /// The font size of the [Db6BottomNavigationBarItem] labels when they are not
  /// selected.
  ///
  /// If [unselectedLabelStyle.fontSize] is non-null, it will be used instead of this.
  ///
  /// Defaults to `12.0`.
  final double unselectedFontSize;

  /// Whether the labels are shown for the selected [Db6BottomNavigationBarItem].
  final bool showUnselectedLabels;

  /// Whether the labels are shown for the unselected [Db6BottomNavigationBarItem]s.
  final bool showSelectedLabels;

  static Db6BottomNavigationBarType _type(
    Db6BottomNavigationBarType? type,
    List<Db6BottomNavigationBarItem> items,
  ) {
    if (type != null) {
      return type;
    }
    return items.length <= 3 ? Db6BottomNavigationBarType.fixed : Db6BottomNavigationBarType.shifting;
  }

  static bool _defaultShowUnselected(Db6BottomNavigationBarType type) {
    switch (type) {
      case Db6BottomNavigationBarType.shifting:
        return false;
      case Db6BottomNavigationBarType.fixed:
        return true;
    }
  }

  @override
  _Db6BottomNavigationBarState createState() => _Db6BottomNavigationBarState();
}

// This represents a single tile in the bottom navigation bar. It is intended
// to go into a flex container.
class _BottomNavigationTile extends StatelessWidget {
  const _BottomNavigationTile(
    this.type,
    this.item,
    this.animation,
    this.iconSize, {
    this.onTap,
    this.colorTween,
    this.flex,
    this.selected = false,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
    this.showSelectedLabels,
    this.showUnselectedLabels,
    this.indexLabel,
  });

  final Db6BottomNavigationBarType type;
  final Db6BottomNavigationBarItem item;
  final Animation<double> animation;
  final double iconSize;
  final VoidCallback? onTap;
  final ColorTween? colorTween;
  final double? flex;
  final bool selected;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final String? indexLabel;
  final bool? showSelectedLabels;
  final bool? showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    // In order to use the flex container to grow the tile during animation, we
    // need to divide the changes in flex allotment into smaller pieces to
    // produce smooth animation. We do this by multiplying the flex value
    // (which is an integer) by a large number.
    late int size;

    final double? selectedFontSize = selectedLabelStyle.fontSize;

    final double selectedIconSize = selectedIconTheme.size ?? iconSize;
    final double unselectedIconSize = unselectedIconTheme.size ?? iconSize;
    // The amount that the selected icon is bigger than the unselected icons,
    // (or zero if the selected icon is not bigger than the unselected icons).
    final double selectedIconDiff = math.max(selectedIconSize - unselectedIconSize, 0);
    // The amount that the unselected icons are bigger than the selected icon,
    // (or zero if the unselected icons are not any bigger than the selected icon).
    final double unselectedIconDiff = math.max(unselectedIconSize - selectedIconSize, 0);

    // Defines the padding for the animating icons + labels.
    //
    // The animations go from "Unselected":
    // =======
    // |      <-- Padding equal to the text height + 1/2 selectedIconDiff.
    // |  ☆
    // | text <-- Invisible text + padding equal to 1/2 selectedIconDiff.
    // =======
    //
    // To "Selected":
    //
    // =======
    // |      <-- Padding equal to 1/2 text height + 1/2 unselectedIconDiff.
    // |  ☆
    // | text
    // |      <-- Padding equal to 1/2 text height + 1/2 unselectedIconDiff.
    // =======
    double bottomPadding;
    double topPadding;
    if (showSelectedLabels! && !showUnselectedLabels!) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: selectedFontSize! / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 - unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else if (!showSelectedLabels! && !showUnselectedLabels!) {
      bottomPadding = Tween<double>(
        begin: selectedIconDiff / 2.0,
        end: unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize! + selectedIconDiff / 2.0,
        end: selectedFontSize + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    } else {
      bottomPadding = Tween<double>(
        begin: selectedFontSize! / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
      topPadding = Tween<double>(
        begin: selectedFontSize / 2.0 + selectedIconDiff / 2.0,
        end: selectedFontSize / 2.0 + unselectedIconDiff / 2.0,
      ).evaluate(animation);
    }

    switch (type) {
      case Db6BottomNavigationBarType.fixed:
        size = 1;
        break;
      case Db6BottomNavigationBarType.shifting:
        size = (flex! * 1000.0).round();
        break;
    }

    return Expanded(
      flex: size,
      child: Semantics(
        container: true,
        selected: selected,
        child: Stack(
          children: <Widget>[
            InkResponse(
              onTap: onTap,
              child: Padding(
                padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    _TileIcon(
                      colorTween: colorTween,
                      animation: animation,
                      iconSize: iconSize,
                      selected: selected,
                      item: item,
                      selectedIconTheme: selectedIconTheme,
                      unselectedIconTheme: unselectedIconTheme,
                    ),
                    item.title.toString().isNotEmpty
                        ? _Label(
                            colorTween: colorTween!,
                            animation: animation,
                            item: item,
                            selectedLabelStyle: selectedLabelStyle,
                            unselectedLabelStyle: unselectedLabelStyle,
                            showSelectedLabels: showSelectedLabels!,
                            showUnselectedLabels: showUnselectedLabels!,
                          )
                        : Container(),
                  ],
                ),
              ),
            ),
            Semantics(
              label: indexLabel,
            ),
          ],
        ),
      ),
    );
  }
}

class _TileIcon extends StatelessWidget {
  const _TileIcon({
    Key? key,
    required this.colorTween,
    required this.animation,
    required this.iconSize,
    required this.selected,
    required this.item,
    required this.selectedIconTheme,
    required this.unselectedIconTheme,
  }) : super(key: key);

  final ColorTween? colorTween;
  final Animation<double> animation;
  final double iconSize;
  final bool selected;
  final Db6BottomNavigationBarItem item;
  final IconThemeData selectedIconTheme;
  final IconThemeData unselectedIconTheme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      heightFactor: 1.0,
      child: Container(
        child: SvgPicture.asset(item.icon, width: selectedIconTheme.size, height: selectedIconTheme.size, color: selected ? selectedIconTheme.color : unselectedIconTheme.color),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label({
    Key? key,
    required this.colorTween,
    required this.animation,
    required this.item,
    required this.selectedLabelStyle,
    required this.unselectedLabelStyle,
    required this.showSelectedLabels,
    required this.showUnselectedLabels,
  }) : super(key: key);

  final ColorTween colorTween;
  final Animation<double> animation;
  final Db6BottomNavigationBarItem item;
  final TextStyle selectedLabelStyle;
  final TextStyle unselectedLabelStyle;
  final bool showSelectedLabels;
  final bool showUnselectedLabels;

  @override
  Widget build(BuildContext context) {
    final double selectedFontSize = selectedLabelStyle.fontSize!;
    final double unselectedFontSize = unselectedLabelStyle.fontSize!;

    final TextStyle customStyle = TextStyle.lerp(
      unselectedLabelStyle,
      selectedLabelStyle,
      animation.value,
    )!;
    Widget text = DefaultTextStyle.merge(
      style: customStyle.copyWith(
        fontSize: selectedFontSize,
        color: colorTween.evaluate(animation),
      ),
      // The font size should grow here when active, but because of the way
      // font rendering works, it doesn't grow smoothly if we just animate
      // the font size, so we use a transform instead.
      child: Transform(
        transform: Matrix4.diagonal3(
          Vector3.all(
            Tween<double>(
              begin: unselectedFontSize / selectedFontSize,
              end: 1.0,
            ).evaluate(animation),
          ),
        ),
        alignment: Alignment.bottomCenter,
        child: item.title,
      ),
    );

    if (!showUnselectedLabels && !showSelectedLabels) {
      // Never show any labels.
      text = Opacity(
        alwaysIncludeSemantics: true,
        opacity: 0.0,
        child: text,
      );
    } else if (!showUnselectedLabels) {
      // Fade selected labels in.
      text = FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: animation,
        child: text,
      );
    } else if (!showSelectedLabels) {
      // Fade selected labels out.
      text = FadeTransition(
        alwaysIncludeSemantics: true,
        opacity: Tween<double>(begin: 1.0, end: 0.0).animate(animation),
        child: text,
      );
    }

    return Align(
      alignment: Alignment.bottomCenter,
      heightFactor: 1.0,
      child: Container(child: text),
    );
  }
}

class _Db6BottomNavigationBarState extends State<Db6BottomNavigationBar> with TickerProviderStateMixin {
  List<AnimationController> _controllers = <AnimationController>[];
  late List<CurvedAnimation> _animations;

  // A queue of color splashes currently being animated.
  final Queue<_Circle> _circles = Queue<_Circle>();

  // Last splash circle's color, and the final color of the control after
  // animation is complete.
  Color? _backgroundColor;

  static final Animatable<double> _flexTween = Tween<double>(begin: 1.0, end: 1.5);

  void _resetState() {
    for (AnimationController controller in _controllers) controller.dispose();
    for (_Circle circle in _circles) circle.dispose();
    _circles.clear();

    _controllers = List<AnimationController>.generate(widget.items.length, (int index) {
      return AnimationController(
        duration: kThemeAnimationDuration,
        vsync: this,
      )..addListener(_rebuild);
    });
    _animations = List<CurvedAnimation>.generate(widget.items.length, (int index) {
      return CurvedAnimation(
        parent: _controllers[index],
        curve: Curves.fastOutSlowIn,
        reverseCurve: Curves.fastOutSlowIn.flipped,
      );
    });
    _controllers[widget.currentIndex].value = 1.0;
    _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
  }

  @override
  void initState() {
    super.initState();
    _resetState();
  }

  void _rebuild() {
    setState(() {
      // Rebuilding when any of the controllers tick, i.e. when the items are
      // animated.
    });
  }

  @override
  void dispose() {
    for (AnimationController controller in _controllers) controller.dispose();
    for (_Circle circle in _circles) circle.dispose();
    super.dispose();
  }

  double _evaluateFlex(Animation<double> animation) => _flexTween.evaluate(animation);

  void _pushCircle(int index) {
    if (widget.items[index].backgroundColor != null) {
      _circles.add(
        _Circle(
          state: this,
          index: index,
          color: widget.items[index].backgroundColor!,
          vsync: this,
        )..controller.addStatusListener(
            (AnimationStatus status) {
              switch (status) {
                case AnimationStatus.completed:
                  setState(() {
                    final _Circle circle = _circles.removeFirst();
                    _backgroundColor = circle.color;
                    circle.dispose();
                  });
                  break;
                case AnimationStatus.dismissed:
                case AnimationStatus.forward:
                case AnimationStatus.reverse:
                  break;
              }
            },
          ),
      );
    }
  }

  @override
  void didUpdateWidget(Db6BottomNavigationBar oldWidget) {
    super.didUpdateWidget(oldWidget);

    // No animated segue if the length of the items list changes.
    if (widget.items.length != oldWidget.items.length) {
      _resetState();
      return;
    }

    if (widget.currentIndex != oldWidget.currentIndex) {
      switch (widget.type) {
        case Db6BottomNavigationBarType.fixed:
          break;
        case Db6BottomNavigationBarType.shifting:
          _pushCircle(widget.currentIndex);
          break;
      }
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    } else {
      if (_backgroundColor != widget.items[widget.currentIndex].backgroundColor) _backgroundColor = widget.items[widget.currentIndex].backgroundColor;
    }
  }

  // If the given [TextStyle] has a non-null `fontSize`, it should be used.
  // Otherwise, the [selectedFontSize] parameter should be used.
  static TextStyle? _effectiveTextStyle(TextStyle? textStyle, double fontSize) {
    textStyle ??= const TextStyle();
    // Prefer the font size on textStyle if present.
    return textStyle.fontSize == null ? textStyle.copyWith(fontSize: fontSize) : textStyle;
  }

  List<Widget> _createTiles() {
    final MaterialLocalizations localizations = MaterialLocalizations.of(context);

    final ThemeData themeData = Theme.of(context);

    final TextStyle? effectiveSelectedLabelStyle = _effectiveTextStyle(widget.selectedLabelStyle, widget.selectedFontSize);
    final TextStyle? effectiveUnselectedLabelStyle = _effectiveTextStyle(widget.unselectedLabelStyle, widget.unselectedFontSize);

    Color? themeColor;
    switch (themeData.brightness) {
      case Brightness.light:
        themeColor = themeData.primaryColor;
        break;
      case Brightness.dark:
        themeColor = themeData.focusColor;
        break;
    }

    ColorTween? colorTween;
    switch (widget.type) {
      case Db6BottomNavigationBarType.fixed:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ?? themeData.textTheme.bodyLarge!.color,
          end: widget.selectedItemColor ?? widget.fixedColor ?? themeColor,
        );
        break;
      case Db6BottomNavigationBarType.shifting:
        colorTween = ColorTween(
          begin: widget.unselectedItemColor ?? Colors.white,
          end: widget.selectedItemColor ?? Colors.white,
        );
        break;
    }

    final List<Widget> tiles = <Widget>[];
    for (int i = 0; i < widget.items.length; i++) {
      tiles.add(_BottomNavigationTile(
        widget.type,
        widget.items[i],
        _animations[i],
        widget.iconSize,
        selectedIconTheme: widget.selectedIconTheme,
        unselectedIconTheme: widget.unselectedIconTheme,
        selectedLabelStyle: effectiveSelectedLabelStyle!,
        unselectedLabelStyle: effectiveUnselectedLabelStyle!,
        onTap: () {
          if (widget.onTap != null) widget.onTap!(i);
        },
        colorTween: colorTween,
        flex: _evaluateFlex(_animations[i]),
        selected: i == widget.currentIndex,
        showSelectedLabels: widget.showSelectedLabels,
        showUnselectedLabels: widget.showUnselectedLabels,
        indexLabel: localizations.tabLabel(tabIndex: i + 1, tabCount: widget.items.length),
      ));
    }
    return tiles;
  }

  Widget _createContainer(List<Widget> tiles) {
    return DefaultTextStyle.merge(
      overflow: TextOverflow.ellipsis,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: tiles,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    assert(debugCheckHasDirectionality(context));
    assert(debugCheckHasMaterialLocalizations(context));
    assert(debugCheckHasMediaQuery(context));

    // Labels apply up to _bottomMargin padding. Remainder is media padding.
    final double additionalBottomPadding = math.max(MediaQuery.of(context).padding.bottom - widget.selectedFontSize / 2.0, 0.0);
    Color? backgroundColor;
    switch (widget.type) {
      case Db6BottomNavigationBarType.fixed:
        backgroundColor = widget.backgroundColor;
        break;
      case Db6BottomNavigationBarType.shifting:
        backgroundColor = _backgroundColor;
        break;
    }
    return Semantics(
      explicitChildNodes: true,
      child: Material(
        elevation: widget.elevation,
        color: backgroundColor,
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: 50 + additionalBottomPadding),
          child: CustomPaint(
            painter: _RadialPainter(
              circles: _circles.toList(),
              textDirection: Directionality.of(context),
            ),
            child: Material(
              // Splashes.
              type: MaterialType.transparency,
              child: Padding(
                padding: EdgeInsets.only(bottom: additionalBottomPadding),
                child: MediaQuery.removePadding(
                  context: context,
                  removeBottom: true,
                  child: _createContainer(_createTiles()),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

const Duration kThemeAnimationDuration = Duration(milliseconds: 200);

// Describes an animating color splash circle.
class _Circle {
  _Circle({
    required this.state,
    required this.index,
    required this.color,
    required TickerProvider vsync,
  }) {
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.fastOutSlowIn,
    );
    controller.forward();
  }

  final _Db6BottomNavigationBarState state;
  final int index;
  final Color color;
  late AnimationController controller;
  late CurvedAnimation animation;

  double get horizontalLeadingOffset {
    double weightSum(Iterable<Animation<double>> animations) {
      // We're adding flex values instead of animation values to produce correct
      // ratios.
      return animations.map<double>(state._evaluateFlex).fold<double>(0.0, (double sum, double value) => sum + value);
    }

    final double allWeights = weightSum(state._animations);
    // These weights sum to the start edge of the indexed item.
    final double leadingWeights = weightSum(state._animations.sublist(0, index));

    // Add half of its flex value in order to get to the center.
    return (leadingWeights + state._evaluateFlex(state._animations[index]) / 2.0) / allWeights;
  }

  void dispose() {
    controller.dispose();
  }
}

// Paints the animating color splash circles.
class _RadialPainter extends CustomPainter {
  _RadialPainter({
    required this.circles,
    required this.textDirection,
  });

  final List<_Circle> circles;
  final TextDirection textDirection;

  // Computes the maximum radius attainable such that at least one of the
  // bounding rectangle's corners touches the edge of the circle. Drawing a
  // circle larger than this radius is not needed, since there is no perceivable
  // difference within the cropped rectangle.
  static double _maxRadius(Offset center, Size size) {
    final double maxX = math.max(center.dx, size.width - center.dx);
    final double maxY = math.max(center.dy, size.height - center.dy);
    return math.sqrt(maxX * maxX + maxY * maxY);
  }

  @override
  bool shouldRepaint(_RadialPainter oldPainter) {
    if (textDirection != oldPainter.textDirection) return true;
    if (circles == oldPainter.circles) return false;
    if (circles.length != oldPainter.circles.length) return true;
    for (int i = 0; i < circles.length; i += 1) if (circles[i] != oldPainter.circles[i]) return true;
    return false;
  }

  @override
  void paint(Canvas canvas, Size size) {
    for (_Circle circle in circles) {
      final Paint paint = Paint()..color = circle.color;
      final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);
      canvas.clipRect(rect);
      late double leftFraction;
      switch (textDirection) {
        case TextDirection.rtl:
          leftFraction = 1.0 - circle.horizontalLeadingOffset;
          break;
        case TextDirection.ltr:
          leftFraction = circle.horizontalLeadingOffset;
          break;
      }
      final Offset center = Offset(leftFraction * size.width, size.height / 2.0);
      final Tween<double> radiusTween = Tween<double>(
        begin: 0.0,
        end: _maxRadius(center, size),
      );
      canvas.drawCircle(
        center,
        radiusTween.transform(circle.animation.value),
        paint,
      );
    }
  }
}

class Db6BottomNavigationBarItem {
  /// Creates an item that is used with [Db6BottomNavigationBar.items].
  ///
  /// The argument [icon] should not be null and the argument [title] should not be null when used in a Material Design's [Db6BottomNavigationBar].
  const Db6BottomNavigationBarItem({
    required this.icon,
    required this.title,
    Widget? activeIcon,
    this.backgroundColor,
  }) : activeIcon = activeIcon as String? ?? icon;

  /// The icon of the item.
  ///
  /// Typically the icon is an [Icon] or an [ImageIcon] widget. If another type
  /// of widget is provided then it should configure itself to match the current
  /// [IconTheme] size and color.
  ///
  /// If [activeIcon] is provided, this will only be displayed when the item is
  /// not selected.
  ///
  /// To make the bottom navigation bar more accessible, consider choosing an
  /// icon with a stroked and filled version, such as [Icons.cloud] and
  /// [Icons.cloud_queue]. [icon] should be set to the stroked version and
  /// [activeIcon] to the filled version.
  ///
  /// If a particular icon doesn't have a stroked or filled version, then don't
  /// pair unrelated icons. Instead, make sure to use a
  /// [Db6BottomNavigationBarType.shifting].
  final String icon;

  /// An alternative icon displayed when this bottom navigation item is
  /// selected.
  ///
  /// If this icon is not provided, the bottom navigation bar will display
  /// [icon] in either state.
  ///
  /// See also:
  ///
  ///  * [Db6BottomNavigationBarItem.icon], for a description of how to pair icons.
  final String activeIcon;

  /// The title of the item. If the title is not provided only the icon will be shown when not used in a Material Design [Db6BottomNavigationBar].
  final Widget title;

  /// The color of the background radial animation for material [Db6BottomNavigationBar].
  ///
  /// If the navigation bar's type is [Db6BottomNavigationBarType.shifting], then
  /// the entire bar is flooded with the [backgroundColor] when this item is
  /// tapped. This will override [Db6BottomNavigationBar.backgroundColor].
  ///
  /// Not used for [CupertinoTabBar]. Control the invariant bar color directly
  /// via [CupertinoTabBar.backgroundColor].
  ///
  /// See also:
  ///
  ///  * [Icon.color] and [ImageIcon.color] to control the foreground color of
  ///     the icons themselves.
  final Color? backgroundColor;
}





//<!--Dashboard 1-->
const db1_colorPrimary = Color(0xFFeb4b51);
const db1_white = Color(0xFFffffff);
const db1_textColorPrimary = Color(0xFF212121);
const db1_textColorSecondary = Color(0xFF757575);
const db1_grey = Color(0xFFB9B9B9);
const db1_yellow = Color(0xFFFBC02D);
const db1_purple = Color(0xFFB88DDD);
const db1_green = Color(0xFFC2DB77);
const db1_orange = Color(0xFFF5D270);
const db1_dark_blue = Color(0xFF5FACC9);
//<integer-array name="db2_category_colors">
//<item>@color/db2_purple</item>
//<item>@color/db2_green</item>
//<item>@color/db2_orange</item>
//<item>@color/db2_darkblue</item>
//<item>@color/db2_darkpurple</item>
//<item>@color/db2_darkgreen</item>
//</integer-array>

const db2_purple = Color(0xFFB88DDD);
const db2_green = Color(0xFFC2DB77);
const db2_orange = Color(0xFFF5D270);
const db2_dark_blue = Color(0xFF5FACC9);
const db2_dark_purple = Color(0xFFB285CC);
const db2_dark_green = Color(0xFFB6DD6E);

//<!--Dashboard 2-->
const db2_colorPrimary = Color(0xFFFF7C6E);
const db2_colorSecondary = Color(0xFFF5317F);
const db2_textColorPrimary = Color(0xFF212121);
const db2_textColorSecondary = Color(0xFF757575);
const db2_white = Color(0xFFffffff);
const db2_black = Color(0xFF000000);

//<!--Dashboard 3-->
const db3_colorPrimary = Color(0xFFFF7C6E);
const db3_colorSecondary = Color(0xFFF5317F);
const db3_textColorPrimary = Color(0xFF212121);
const db3_textColorSecondary = Color(0xFF757575);
const db3_white = Color(0xFFffffff);
const db3_black = Color(0xFF000000);
const db3_grey = Color(0xFFB9B9B9);
const db3_white_trans = Color(0xFFF1F1F1);

//<!--Dashboard 4-->
const db4_colorPrimary = Color(0xFF130925);
const db4_colorSecondary = Color(0xFF130925);
const db4_textColorPrimary = Color(0xFF130925);
const db4_textColorSecondary = Color(0xFF757575);
const db4_white = Color(0xFFffffff);
const db4_black = Color(0xFF000000);
const db4_grey = Color(0xFFB9B9B9);
const db4_white_trans = Color(0xFFF1F1F1);
const db4_LayoutBackgroundWhite = Color(0xFFF6F7FA);
const db4_cat_1 = Color(0xFF45c7db);
const db4_cat_2 = Color(0xFF510AD7);
const db4_cat_3 = Color(0xFFe43649);
const db4_cat_4 = Color(0xFFf4b428);
const db4_cat_5 = Color(0xFF22ce9a);
const db4_cat_6 = Color(0xFF203afb);
const db4_ColorPrimaryLight = Color(0x505104D7);

//<!--Dashboard 5-->
const db5_colorPrimary = Color(0xFF2F95A1);
const db5_colorSecondary = Color(0xFF2F95A1);
const db5_textColorPrimary = Color(0xFF2F95A1);
const db5_textColorSecondary = Color(0xFF757575);
const db5_white = Color(0xFFffffff);
const db5_black = Color(0xFF000000);
const db5_grey = Color(0xFFB9B9B9);
const db5_viewColor = Color(0xFFEEEEF1);
const db5_yellow = Color(0xFFf4b428);
const db5_white_trans = Color(0xFFF1F1F1);
const db5_hotel = Color(0xFFF0F5F7);
const db5_flight = Color(0xFFFFF4F4);
const db5_food = Color(0xFFFFF6F1);
const db5_event = Color(0xFFF3F1FA);
const db5_icon_color = Color(0xFF747474);
const db5_black_trans = Color(0xFF56303030);
const db5_light_blue = Color(0xFFD6DBF0);

//Dashboard 6
const db6_colorPrimary = Color(0xFF0060D5);
const db6_colorPrimaryDark = Color(0xFF0060D5);
const db6_colorSecondary = Color(0xFF0c82DD);
const db6_textColorPrimary = Color(0xFF0060D5);
const db6_textColorSecondary = Color(0xFF757575);
const db6_white = Color(0xFFffffff);
const db6_black = Color(0xFF000000);
const db6_grey = Color(0xFFB9B9B9);
const db6_yellow = Color(0xFFf4b428);
const db6_viewColor = Color(0xFFEEEEF1);
const db6_layout_background = Color(0xFFF6F7FA);
const db6_white_trans = Color(0xFFF1F1F1);

// Dashboard 7
const db7_colorPrimary = Color(0xFF19D077);
const db7_colorPrimaryDark = Color(0xFF19D077);
const db7_colorSecondary = Color(0xFF0c82DD);
const db7_textColorPrimary = Color(0xFF130925);
const db7_textColorSecondary = Color(0xFF757575);
const db7_white = Color(0xFFFFFFFF);
const db7_viewColor = Color(0xFFDADADA);
const db7_layout_background = Color(0xFFF6F7FA);
const db7_light_green = Color(0xFFE2F5E9);
const db7_light_blue = Color(0xFFE9EAFF);
const db7_dark_blue = Color(0xFF5B8CFF);
const db7_dark_yellow = Color(0xFFFFAB35);
const db7_dark_red = Color(0xFFFF7670);
const db7_light_yellow = Color(0xFFFEF2E5);
const db7_light_red = Color(0xFFFEE9EA);

// Dashboard 8
const db8_colorPrimary = Color(0xFFAF9177);
const db8_colorPrimaryDark = Color(0xFFB79A7F);
const db8_colorSecondary = Color(0xFF0c82DD);
const db8_textColorPrimary = Color(0xFF444444);
const db8_textColorSecondary = Color(0xFF757575);
const db8_white = Color(0xFFffffff);
const db8_black = Color(0xFF000000);
const db8_grey = Color(0xFFF2F2F2);
const db8_viewColor = Color(0xFFEEEEF1);
const db8_layout_background = Color(0xFFF6F7FA);

const dbShadowColor = Color(0x95E9EBF0);


List<Db1CategoryModel> getFilterFavourites() {
  List<Db1CategoryModel> categoryModelArrayList = [];

  Db1CategoryModel item1 = Db1CategoryModel();
  item1.img = db1_ic_burger;
  item1.name = "Burger";
  item1.color = db1_dark_blue;

  Db1CategoryModel item2 = Db1CategoryModel();
  item2.img = db1_ic_pizza;
  item2.name = "Pizza";
  item2.color = db1_purple;

  Db1CategoryModel item3 = Db1CategoryModel();
  item3.img = db1_ic_coffee;
  item3.name = "Coffee";
  item3.color = db1_green;

  Db1CategoryModel item4 = Db1CategoryModel();
  item4.img = db1_ic_chicken;
  item4.name = "Chicken";
  item4.color = db1_orange;

  Db1CategoryModel item5 = Db1CategoryModel();
  item5.img = db1_ic_cake;
  item5.name = "Cake";
  item5.color = db1_dark_blue;

  Db1CategoryModel item6 = Db1CategoryModel();
  item6.img = db1_ic_cake;
  item6.name = "Cake";
  item6.color = db1_purple;

  categoryModelArrayList.add(item1);
  categoryModelArrayList.add(item2);
  categoryModelArrayList.add(item3);
  categoryModelArrayList.add(item4);
  categoryModelArrayList.add(item5);
  categoryModelArrayList.add(item6);
  return categoryModelArrayList;
}

List<Db1CategoryModel> getCategories() {
  List<Db1CategoryModel> categoryModelArrayList = [];
  Db1CategoryModel item1 = Db1CategoryModel();
  item1.img = db_restau_1;
  item1.name = "Morimoto";

  Db1CategoryModel item2 = Db1CategoryModel();
  item2.img = db_restau_2;
  item2.name = "Tashan";

  Db1CategoryModel item4 = Db1CategoryModel();
  item4.img = db_restau_3;
  item4.name = "Beetroot";

  Db1CategoryModel item5 = Db1CategoryModel();
  item5.img = db_restau_4;
  item5.name = "Tomato’s";

  Db1CategoryModel item6 = Db1CategoryModel();
  item6.img = db1_ic_paneer;
  item6.name = "Fast food";

  Db1CategoryModel item3 = Db1CategoryModel();
  item3.img = db1_ic_paneer;
  item3.name = "Nutmeg";
  categoryModelArrayList.add(item1);
  categoryModelArrayList.add(item2);
  categoryModelArrayList.add(item4);
  categoryModelArrayList.add(item5);
  categoryModelArrayList.add(item6);
  categoryModelArrayList.add(item3);
  return categoryModelArrayList;
}

List<DB1FoodModel> getFoodItems() {
  List<DB1FoodModel> foodModelArrayList = [];
  DB1FoodModel item1 = DB1FoodModel();
  item1.img = db1_ic_waffles;
  item1.name = "Paneer Tikka Dry";
  item1.info = "Indian Food";
  item1.duration = "20 min";

  DB1FoodModel item2 = DB1FoodModel();
  item2.img = db1_ic_biryani;
  item2.name = "Biryani";
  item2.info = "Indian, Fast food";
  item2.duration = "10 min";

  DB1FoodModel item3 = DB1FoodModel();
  item3.img = db1_ic_waffles;
  item3.name = "Burger";
  item3.info = "Indian, Fast food";
  item3.duration = "20 min";

  DB1FoodModel item4 = DB1FoodModel();
  item4.img = db1_ic_biryani;
  item4.name = "Waffles";
  item4.info = "Indian, Fast food";
  item4.duration = "20 min";

  foodModelArrayList.add(item1);
  foodModelArrayList.add(item2);
  foodModelArrayList.add(item3);
  foodModelArrayList.add(item4);
  return foodModelArrayList;
}

List<DB1FoodModel> getPopular() {
  List<DB1FoodModel> foodModelArrayList = [];
  DB1FoodModel item1 = DB1FoodModel();
  item1.img = db1_ic_waffles;
  item1.name = "Hungry Birds";
  item1.info = "North Indian, Chinese, Birayani";
  item1.duration = "20 min";

  DB1FoodModel item2 = DB1FoodModel();
  item2.img = db1_ic_paneer;
  item2.name = "US Pizza";
  item2.info = "Pizza, Garlic Bread";
  item2.duration = "10 min";

  DB1FoodModel item3 = DB1FoodModel();
  item3.img = db1_ic_biryani;
  item3.name = "Bhuvneshwari Khichadi Center";
  item3.info = "Gujarati, North Indian";
  item3.duration = "20 min";

  DB1FoodModel item4 = DB1FoodModel();
  item4.img = db1_ic_waffles;
  item4.name = "Waffles";
  item4.info = "Indian, Fast food";
  item4.duration = "20 min";

  foodModelArrayList.add(item1);
  foodModelArrayList.add(item2);
  foodModelArrayList.add(item3);
  foodModelArrayList.add(item4);
  return foodModelArrayList;
}

List<Db2ShopModel> db2getCategory() {
  List<Db2ShopModel> popularArrayList = [];
  Db2ShopModel item1 = Db2ShopModel();
  item1.img = db2_mens;
  item1.name = "Mens";

  Db2ShopModel item2 = Db2ShopModel();
  item2.img = db2_women;
  item2.name = "Womens";

  Db2ShopModel item3 = Db2ShopModel();
  item3.img = db2_kids;
  item3.name = "Kids";

  Db2ShopModel item4 = Db2ShopModel();
  item4.img = db2_decor;
  item4.name = "Decor-items";

  Db2ShopModel item5 = Db2ShopModel();
  item5.img = db2_decor1;
  item5.name = "others";

  popularArrayList.add(item1);
  popularArrayList.add(item2);
  popularArrayList.add(item3);
  popularArrayList.add(item4);
  popularArrayList.add(item5);
  return popularArrayList;
}

List<Db2ShopModel> db2getProduct() {
  List<Db2ShopModel> popularArrayList = [];
  Db2ShopModel item1 = Db2ShopModel();
  item1.img = db2_item2;
  item1.name = "Sunglasses";

  Db2ShopModel item2 = Db2ShopModel();
  item2.img = db2_item4;
  item2.name = "Sweater";

  Db2ShopModel item3 = Db2ShopModel();
  item3.img = db2_mens;
  item3.name = "Shirt";

  Db2ShopModel item4 = Db2ShopModel();
  item4.img = db2_decor;
  item4.name = "Box";

  popularArrayList.add(item1);
  popularArrayList.add(item2);
  popularArrayList.add(item3);
  popularArrayList.add(item4);
  return popularArrayList;
}

List<Db2ShopModel> db2getFeatured() {
  List<Db2ShopModel> popularArrayList = [];
  Db2ShopModel item1 = Db2ShopModel();
  item1.img = db2_women;
  item1.name = "Black Jacket";

  Db2ShopModel item2 = Db2ShopModel();
  item2.img = db2_item1;
  item2.name = "Denim Jacket";

  Db2ShopModel item3 = Db2ShopModel();
  item3.img = db2_item3;
  item3.name = "Blazer";

  Db2ShopModel item4 = Db2ShopModel();
  item4.img = db2_item5;
  item4.name = "T-shirt";

  popularArrayList.add(item1);
  popularArrayList.add(item2);
  popularArrayList.add(item3);
  popularArrayList.add(item4);
  return popularArrayList;
}

List<Db3FurnitureModel> db3FurnitureItems() {
  List<Db3FurnitureModel> furnitureModelArrayList = [];
  Db3FurnitureModel item1 = Db3FurnitureModel();
  item1.img = ic_chair3;
  item1.name = "Chair";
  item1.price = "\$29.0";

  Db3FurnitureModel item2 = Db3FurnitureModel();
  item2.img = ic_chair2;
  item2.name = "Nancy Chair";
  item2.price = "\$35.0";

  Db3FurnitureModel item3 = Db3FurnitureModel();
  item3.img = ic_chair3;
  item3.name = "Chair";
  item3.price = "\$20.0";

  Db3FurnitureModel item4 = Db3FurnitureModel();
  item4.img = ic_chair2;
  item4.name = "Chair";
  item4.price = "\$29.0";

  furnitureModelArrayList.add(item1);
  furnitureModelArrayList.add(item2);
  furnitureModelArrayList.add(item3);
  furnitureModelArrayList.add(item4);

  return furnitureModelArrayList;
}

List<Db3FurnitureModel> db3SellerItems() {
  List<Db3FurnitureModel> furnitureModelArrayList = [];
  Db3FurnitureModel item1 = Db3FurnitureModel();
  item1.img = ic_chair3;
  item1.name = "Houndstooth Side Zipper";
  item1.price = "\$29.0";

  Db3FurnitureModel item2 = Db3FurnitureModel();
  item2.img = ic_chair2;
  item2.name = "Table Wood Pine";
  item2.price = "\$35.0";

  Db3FurnitureModel item3 = Db3FurnitureModel();
  item3.img = ic_chair3;
  item3.name = "Houndstooth Side Zipper";
  item3.price = "\$20.0";

  Db3FurnitureModel item4 = Db3FurnitureModel();
  item4.img = ic_chair2;
  item4.name = "Table Wood Pine";
  item4.price = "\$29.0";

  furnitureModelArrayList.add(item1);
  furnitureModelArrayList.add(item2);
  furnitureModelArrayList.add(item3);
  furnitureModelArrayList.add(item4);

  return furnitureModelArrayList;
}

List<Db4Category> db5GetCategoryItems() {
  List<Db4Category> list = [];

  var category1 = Db4Category();
  category1.name = "Transfer";
  category1.color = db4_cat_1;
  category1.icon = db4_paperplane;
  list.add(category1);
  var category2 = Db4Category();
  category2.name = "Wallet";
  category2.color = db4_cat_2;
  category2.icon = db4_wallet;
  list.add(category2);
  var category3 = Db4Category();
  category3.name = "Voucher";
  category3.color = db4_cat_3;
  category3.icon = db4_coupon;
  list.add(category3);
  var category4 = Db4Category();
  category4.name = "Pay Bill";
  category4.color = db4_cat_4;
  category4.icon = db4_invoice;
  list.add(category4);

  var category5 = Db4Category();
  category5.name = "Exchange";
  category5.color = db4_cat_5;
  category5.icon = db4_dollar_exchange;
  list.add(category5);

  var category = Db4Category();
  category.name = "More";
  category.color = db4_cat_6;
  category.icon = db4_circle;
  list.add(category);
  return list;
}

List<Db4Slider> db4GetSliders() {
  List<Db4Slider> list = [];
  Db4Slider model1 = Db4Slider();
  model1.balance = "\$150000";
  model1.accountNo = "145 250 230 120 150";
  model1.image = db4_bg_card_2;
  Db4Slider model2 = Db4Slider();
  model2.balance = "\$150000";
  model2.accountNo = "145 250 230 120 150";
  model2.image = db4_bg_card_1;
  Db4Slider model3 = Db4Slider();
  model3.balance = "\$150000";
  model3.accountNo = "145 250 230 120 150";
  model3.image = db4_bg_card_3;

  list.add(model1);
  list.add(model2);
  list.add(model3);
  return list;
}

List<Db5CategoryData> generateCategories() {
  List<Db5CategoryData> categories = [];

  Db5CategoryData model = Db5CategoryData();
  model.name = "Hotels";
  model.image = d5_ic_bed;

  Db5CategoryData model1 = Db5CategoryData();
  model1.name = "Flights";
  model1.image = d5_ic_flight;

  Db5CategoryData model2 = Db5CategoryData();
  model2.name = "Foods";
  model2.image = d5_ic_food;

  Db5CategoryData model3 = Db5CategoryData();
  model3.name = "Events";
  model3.image = d5_ic_event;

  categories.add(model);
  categories.add(model1);
  categories.add(model2);
  categories.add(model3);
  return categories;
}

List<Db6BestDestinationData> generateBestDestination() {
  List<Db6BestDestinationData> bestDestinationData = [];

  Db6BestDestinationData model = Db6BestDestinationData();
  model.name = "Malawi";
  model.rating = "4";
  model.image = db5_item1;

  Db6BestDestinationData model2 = Db6BestDestinationData();
  model2.name = "Japan";
  model2.rating = "2";
  model2.image = db5_item2;

  Db6BestDestinationData model3 = Db6BestDestinationData();
  model3.name = "London";
  model3.rating = "1";
  model3.image = db5_item3;

  Db6BestDestinationData model4 = Db6BestDestinationData();
  model4.name = "San Fransisco";
  model4.rating = "5";
  model4.image = db5_item4;

  bestDestinationData.add(model);
  bestDestinationData.add(model2);
  bestDestinationData.add(model3);
  bestDestinationData.add(model4);
  bestDestinationData.add(model);
  bestDestinationData.add(model);
  return bestDestinationData;
}

List<DB6Service> getTopLaundryService() {
  List<DB6Service> categories = [];

  DB6Service model = DB6Service();
  model.name = "Wash & Fold";
  model.img = db6_towels;

  DB6Service model1 = DB6Service();
  model1.name = "Wash & Iron";
  model1.img = db6_shirt;

  DB6Service model2 = DB6Service();
  model2.name = "Dry Clean";
  model2.img = db6_suit;

  DB6Service model3 = DB6Service();
  model3.name = "Premium Wash";
  model3.img = db6_washing_machine;

  categories.add(model);
  categories.add(model1);
  categories.add(model2);
  categories.add(model3);
  return categories;
}

List<DB6Laundry> getLaundry() {
  List<DB6Laundry> categories = [];

  DB6Laundry model = DB6Laundry();
  model.name = "My Laundry";
  model.img = db6_water_supply;
  model.rating = "5";
  model.location = "1810,Camino Real ,Newyork";

  DB6Laundry model1 = DB6Laundry();
  model1.name = "Dhobi Laundry";
  model1.img = db6_van;
  model1.rating = "2";
  model1.location = "1810,Camino Real ,Newyork";

  DB6Laundry model2 = DB6Laundry();
  model2.name = "Quick Laundry";
  model2.img = db6_water_supply;
  model2.rating = "4.5";
  model2.location = "1810,Camino Real ,Newyork";

  DB6Laundry model3 = DB6Laundry();
  model3.name = "Your Laundry";
  model3.img = db6_water_supply;
  model3.rating = "5.0";
  model3.location = "1810,Camino Real ,Newyork";
  categories.add(model);
  categories.add(model1);
  categories.add(model2);
  categories.add(model3);
  return categories;
}

List<DB6Offer> getOffer() {
  List<DB6Offer> categories = [];
  DB6Offer model = DB6Offer();
  model.img = db6_washing_clothes;
  model.subTitle = "Get 50% off";
  model.title = "For a limited time";

  DB6Offer model1 = DB6Offer();
  model1.img = db6_wash_service;
  model1.subTitle = "Get 50% off";
  model1.title = "For a limited time";

  DB6Offer model2 = DB6Offer();
  model2.img = db6_shirt;
  model2.subTitle = "Get 50% off";
  model2.title = "For a limited time";

  DB6Offer model3 = DB6Offer();
  model3.img = db6_shirt;
  model3.subTitle = "Get 50% off";
  model3.title = "For a limited time";
  categories.add(model);
  categories.add(model1);
  categories.add(model2);
  categories.add(model3);
  return categories;
}

List<DB7Topic> getDB7TodayData() {
  List<DB7Topic> data = [];
  data.add(DB7Topic("Participation in Extracurricular Activities", db7_item4, "Civil Hospital", 200, 20));
  data.add(DB7Topic("Depression", db7_item5, "Orange Hospital", 200, 20));
  data.add(DB7Topic("illnesses", db7_item3, "Fudan University Hospital", 200, 20));
  data.add(DB7Topic("Participation in Extracurricular Activities", db7_item2, "Parsi Hospital", 200, 20));
  return data;
}

List<DB8Scene> getScene() {
  List<DB8Scene> categories = [];
  categories.add(DB8Scene(db8_ic_home, "Home"));
  categories.add(DB8Scene(db8_ic_door, "Away"));
  categories.add(DB8Scene(db8_ic_sleep, "Sleep"));
  categories.add(DB8Scene(db8_ic_alarm, "Get up"));

  return categories;
}

List<DB8Rooms> getRooms() {
  List<DB8Rooms> categories = [];
  categories.add(DB8Rooms("Living Room", db8_ic_item6, "6 device"));
  categories.add(DB8Rooms("Bed Rooms", db8_ic_item5, "1 device"));
  categories.add(DB8Rooms("Rest Room", db8_ic_item7, "3 device"));

  return categories;
}
