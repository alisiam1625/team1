import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';  //https://pub.dev/packages/nb_utils



class DemoMWBottomSheetScreen extends StatefulWidget {
  static String tag = '/DemoMWBottomSheetScreen';

  @override
  DemoMWBottomSheetScreenState createState() => DemoMWBottomSheetScreenState();
}

class DemoMWBottomSheetScreenState extends State<DemoMWBottomSheetScreen> {
  List<String> text1 = [
    'All transactions',
    'Day view',
    'Month view',
    'Custom view',
    'Reminders',
    'Budgets',
    'Category',
    'Payment modes',
  ];
  List<IconData> icons1 = [
    Icons.view_list_sharp,
    Icons.calendar_today_rounded,
    Icons.calendar_today_outlined,
    Icons.aspect_ratio_rounded,
    Icons.access_time,
    Icons.attach_money,
    Icons.playlist_add_rounded,
    Icons.payment_outlined,
  ];
  List<Color> color1 = [
    Colors.green,
    Colors.deepOrange,
    darkGreen,
    Colors.yellow,
    Colors.teal,
    navy,
    greenColor,
    Colors.brown,
  ];

  List<IconData> icons2 = [
    Icons.monetization_on,
    Icons.settings,
    Icons.recommend,
    Icons.star,
    Icons.message,
    Icons.new_releases,
  ];
  List<String> text2 = ['Buy Premium', 'Settings', 'Referrals', 'Rate app', 'Query Feedback', 'FAQ'];
  List<Color> color2 = [
    Colors.deepOrangeAccent,
    Colors.deepPurple,
    darkBlue,
    Colors.purple,
    Colors.redAccent,
    Colors.black,
  ];
  List<String> text = ['Top Rated Experiences', 'Trending Discussions', 'Popular Collections', 'Adventures Near You'];

  List<bool> isEnable = [true, false, false, false];

  RangeValues _currentRangeValues = const RangeValues(40, 80);

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  List<ListModel> example = [
    ListModel(name: 'Simple Bottom Sheet'),
    ListModel(name: 'Bottom Sheet with rounded corner'),
    ListModel(name: 'Bottom Sheet with scrollable content'),
    ListModel(name: 'Bottom Sheet with Form'),
    ListModel(name: 'Bottom Sheet 5', isNew: true),
    ListModel(name: 'Bottom Sheet 6', isNew: true),
    ListModel(name: 'Bottom Sheet 7', isNew: true),
  ];

  _mBottomSheet6() {
    showModalBottomSheet(
      enableDrag: true,
      isDismissible: true,
      isScrollControlled: true,
      context: context,
      backgroundColor: Colors.transparent,
      builder: (builder) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.2,
          maxChildSize: 1,
          builder: (context, scrollController) {
            return Container(
              color: context.cardColor,
              padding: EdgeInsets.symmetric(vertical: 16),
              child: SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.account_circle,
                          color: appStore.iconColor,
                          size: 50,
                        ),
                        8.width,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Guest User',
                              style: primaryTextStyle(size: 20),
                            ),
                            Text(
                              'Sign in',
                              style: secondaryTextStyle(),
                            )
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.security)
                      ],
                    ).paddingSymmetric(horizontal: 16),
                    Divider(),
                    16.height,
                    ...List.generate(
                      text1.length,
                      (index) {
                        return SettingItemWidget(
                          title: text1[index],
                          leading: Icon(
                            icons1[index],
                            color: color1[index],
                            size: 20,
                          ),
                        );
                      },
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'More options',
                        style: secondaryTextStyle(),
                      ),
                    ).paddingSymmetric(horizontal: 16),
                    ...List.generate(
                      text2.length,
                      (index) {
                        return SettingItemWidget(
                          title: text2[index],
                          leading: Icon(
                            icons2[index],
                            color: color2[index],
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _mBottomSheet7() {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
      context: context,
      builder: (builder) {
        return StatefulBuilder(
          builder: (BuildContext context, void Function(void Function()) setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Filtered By :',
                  style: boldTextStyle(size: 20),
                ),
                24.height,
                Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: text.map(
                      (e) {
                        int index = text.indexOf(e);
                        return Container(
                          child: Text(
                            e,
                            style: secondaryTextStyle(
                              color: isEnable[index] ? Colors.white : textSecondaryColorGlobal,
                            ),
                          ),
                          padding: EdgeInsets.all(8),
                          decoration: boxDecorationDefault(
                            color: isEnable[index] ? navy : context.cardColor,
                          ),
                        ).onTap(
                          () {
                            setState(() {});
                            isEnable[index] = !isEnable[index];
                          },
                        );
                      },
                    ).toList()),
                Spacer(),
                Text(
                  'Range Distance',
                  style: boldTextStyle(size: 20),
                ),
                SliderTheme(
                  data: SliderThemeData(
                    trackHeight: 5,
                    inactiveTrackColor: context.dividerColor,
                    activeTrackColor: navy,
                    thumbColor: context.cardColor,
                    thumbShape: RoundSliderThumbShape(
                      enabledThumbRadius: 50.0,
                      disabledThumbRadius: 50,
                      elevation: 3,
                    ),
                    overlayColor: Colors.grey.withAlpha(32),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 25.0),
                    showValueIndicator: ShowValueIndicator.always,
                  ),
                  child: RangeSlider(
                    values: _currentRangeValues,
                    min: 0,
                    max: 100,
                    labels: RangeLabels(
                      _currentRangeValues.start.round().toString(),
                      _currentRangeValues.end.round().toString(),
                    ),
                    onChanged: (RangeValues values) {
                      setState(() {
                        _currentRangeValues = values;
                      });
                    },
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    AppButton(
                      onTap: () {},
                      color: context.cardColor,
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      text: 'Reset',
                      textStyle: primaryTextStyle(),
                    ).expand(),
                    16.width,
                    AppButton(
                      onTap: () {},
                      shapeBorder: RoundedRectangleBorder(borderRadius: radius()),
                      text: 'Apply',
                      textStyle: primaryTextStyle(
                        color: Colors.white,
                      ),
                      color: navy,
                    ).expand()
                  ],
                )
              ],
            ).paddingSymmetric(horizontal: 16, vertical: 32);
          },
        );
      },
    );
  }

  void mSimpleBottomSheet() {
    Widget mOption(var icon, var value) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 24,
              color: appStore.iconColor,
            ),
            16.width,
            Text(value, style: primaryTextStyle(size: 16, color: appStore.textPrimaryColor))
          ],
        ),
      );
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: context.scaffoldBackgroundColor,
        builder: (builder) {
          return Container(
            height: 160.0,
            color: Colors.transparent,
            child: Column(
              children: [
                mOption(Icons.share, "Share").onTap(() {
                  finish(context);
                  toasty(context, 'share');
                }),
                mOption(Icons.link, "Get Link").onTap(() {
                  finish(context);
                  toasty(context, 'Get Link');
                }),
                mOption(Icons.edit, "Edit Name").onTap(() {
                  finish(context);
                  toasty(context, 'Edit Name');
                }),
              ],
            ),
          );
        });
  }

  mCornerBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
        context: aContext,
        backgroundColor: aContext.scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        builder: (builder) {
          return Container(
            height: 250.0,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Information",
                  style: boldTextStyle(color: appStore.textPrimaryColor),
                ),
                16.height,
                Divider(height: 5, color: appStore.appDividerColor.withOpacity(0.5)),
                16.height,
                Text("Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content.", style: secondaryTextStyle(color: appStore.textSecondaryColor)),
                8.height,
              ],
            ),
          );
        });
  }

  mExpandedSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.45,
        minChildSize: 0.2,
        maxChildSize: 1,
        builder: (context, scrollController) {
          return Container(
            color: context.scaffoldBackgroundColor,
            child: GestureDetector(
              onTap: () {
                finish(context);
              },
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      'Item $index',
                      style: primaryTextStyle(color: appStore.textPrimaryColor),
                    ),
                  );
                },
                itemCount: 20,
              ),
            ),
          );
        },
      ),
    );
  }

  mFormBottomSheet(BuildContext aContext) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: aContext,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)), color: appStore.appBarColor),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Add Review",
                style: boldTextStyle(color: appStore.textPrimaryColor),
              ),
              Divider().paddingOnly(top: 16, bottom: 16),
              Text(
                "Email",
                style: primaryTextStyle(color: appStore.textPrimaryColor),
              ),
              8.height,
              editTextStyle("Enter Email"),
              16.height,
              Text(
                "Description",
                style: primaryTextStyle(color: appStore.textPrimaryColor),
              ),
              8.height,
              editTextStyle("Description"),
              16.height,
              RatingBar(
                initialRating: 5,
                minRating: 5,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  print(rating);
                },
              ).center(),
              30.height,
              GestureDetector(
                onTap: () {
                  finish(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: appStore.appColorPrimary, borderRadius: BorderRadius.circular(16),),
                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: primaryTextStyle(color: white),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Padding editTextStyle(var hintText) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextFormField(
        style: TextStyle(fontSize: 16, fontFamily: 'Regular'),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(24, 16, 24, 16),
          hintText: hintText,
          hintStyle: primaryTextStyle(color: grey),
          filled: true,
          fillColor: appStore.appBarColor,
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: appStore.iconSecondaryColor!, width: 1.0)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: appStore.iconSecondaryColor!, width: 1.0)),
        ),
      ),
    );
  }

  _mBottomSheet5(BuildContext context) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: 32, topRight: 32)),
      context: context,
      builder: (builder) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Payout',
              style: boldTextStyle(size: 30, weight: FontWeight.w400),
            ),
            4.height,
            Text(
              'Pay out your balance now',
              style: secondaryTextStyle(),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Container(
                      child: Icon(
                        Icons.self_improvement,
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationDefault(color: Colors.deepOrangeAccent, borderRadius: radius(100)),
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sparkasse',
                          style: primaryTextStyle(),
                        ),
                        Text(
                          'Credit',
                          style: secondaryTextStyle(),
                        )
                      ],
                    ),
                  ],
                ),
                Container(
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.black54,
                    size: 15,
                  ),
                  padding: EdgeInsets.all(8),
                  decoration: boxDecorationDefault(color: Colors.white, borderRadius: radius(100)),
                ),
                Row(
                  children: [
                    Container(
                      height: 40,
                      width: 40,
                      child: Text(
                        'S',
                        style: boldTextStyle(color: Colors.white),
                      ).center(),
                      padding: EdgeInsets.all(8),
                      decoration: boxDecorationDefault(color: Colors.black, borderRadius: radius(100)),
                    ),
                    8.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Account',
                          style: primaryTextStyle(),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              children: [
                Text(
                  '12,50',
                  style: boldTextStyle(size: 30, weight: FontWeight.w400),
                ),
                Icon(Icons.euro)
              ],
            ),
            4.height,
            Row(
              children: [
                Text(
                  'Will be paid to your account ',
                  style: secondaryTextStyle(),
                ),
                Row(
                  children: List.generate(
                    4,
                    (index) => Icon(
                      Icons.circle,
                      size: 8,
                    ).paddingRight(1),
                  ),
                ),
                Text(
                  ' 4355',
                  style: boldTextStyle(),
                )
              ],
            ),
            Spacer(),
            AppButton(
              text: 'Withdraw to Bank Account',
              textStyle: primaryTextStyle(
                size: 15,
                color: Colors.white,
              ),
              color: Colors.deepOrange,
              width: context.width(),
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(32)),
              onTap: () {
                Navigator.pop(context);
              },
            ).center(),
            8.height,
            AppButton(
              text: 'Never Mind',
              textStyle: primaryTextStyle(size: 15),
              width: context.width(),
              color: context.cardColor,
              shapeBorder: RoundedRectangleBorder(borderRadius: radius(32)),
              onTap: () {
                Navigator.pop(context);
              },
            ).center(),
          ],
        ).paddingAll(16);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.scaffoldBackgroundColor,
      body: ListView.builder(
        itemCount: example.length,
        itemBuilder: (BuildContext context, index) {
          return ExampleItemWidget(
            example[index],
            onTap: () {
              if (index == 0) {
                mSimpleBottomSheet();
              } else if (index == 1) {
                mCornerBottomSheet(context);
              } else if (index == 2) {
                mExpandedSheet(context);
              } else if (index == 3) {
                mFormBottomSheet(context);
              } else if (index == 4) {
                _mBottomSheet5(context);
              } else if (index == 5) {
                _mBottomSheet6();
              } else if (index == 6) {
                _mBottomSheet7();
              }
            },
          );
        },
      ),
    );
  }
}

AppStore appStore = AppStore();
class AppStore{

  Color? textPrimaryColor;
  Color? iconColorPrimaryDark;
  Color? scaffoldBackground;
  Color? backgroundColor;
  Color? backgroundSecondaryColor;
  Color? appColorPrimaryLightColor;
  Color? textSecondaryColor;
  Color? appBarColor;
  Color? iconColor;
  Color? iconSecondaryColor;
  Color? cardColor;
  Color? appColorPrimary;
  Color appDividerColor = Color(0xFFDADADA);

  AppStore(){

    textPrimaryColor = Color(0xFF212121);
    iconColorPrimaryDark = Color(0xFF212121);
    scaffoldBackground = Color(0xFFEBF2F7);
    backgroundColor = Colors.black;
    backgroundSecondaryColor = Color(0xFF131d25);
    appColorPrimaryLightColor = Color(0xFFF9FAFF);
    textSecondaryColor = Color(0xFF5A5C5E);
    appBarColor = Colors.white;
    iconColor = Color(0xFF212121);
    iconSecondaryColor = Color(0xFFA8ABAD);
    cardColor = Color(0xFF191D36);
    appColorPrimary = Color(0xFF1157FA);

  }
}
class ListModel {
  String? name;
  bool? isNew;
  Widget? widget;

  ListModel({this.name, this.widget,this.isNew});
}
class ExampleItemWidget extends StatelessWidget {
  final ListModel tabBarType;
  final Function onTap;
  final bool showTrailing;

  ExampleItemWidget(this.tabBarType, {required this.onTap, this.showTrailing = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: appStore.appBarColor,
      margin: EdgeInsets.fromLTRB(12, 12, 12, 0),
      elevation: 2.0,
      shadowColor: Colors.black,
      child: ListTile(
        onTap: () => onTap(),
        title: Text(tabBarType.name!, style: boldTextStyle()),
        trailing: showTrailing
            ? Icon(Icons.arrow_forward_ios, size: 15, color: appStore.textPrimaryColor)
            : tabBarType.isNew.validate()
            ? Text('New', style: secondaryTextStyle(color: Colors.red))
            : null,
      ),
    );
  }
}



/// Defines widgets which are to used as rating bar items.
class RatingWidget {
  /// Defines widget to be used as rating bar item when the item is completely rated.
  final Widget full;

  /// Defines widget to be used as rating bar item when only the half portion of item is rated.
  final Widget half;

  /// Defines widget to be used as rating bar item when the item is unrated.
  final Widget empty;

  RatingWidget({
    required this.full,
    required this.half,
    required this.empty,
  });
}

class _HalfRatingWidget extends StatelessWidget {
  final Widget child;
  final double size;
  final bool enableMask;
  final bool rtlMode;
  final Color? unratedColor;

  _HalfRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.rtlMode,
    required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: enableMask
          ? Stack(
              fit: StackFit.expand,
              children: [
                FittedBox(
                  fit: BoxFit.contain,
                  child: _NoRatingWidget(
                    child: child,
                    size: size,
                    unratedColor: unratedColor,
                    enableMask: enableMask,
                  ),
                ),
                FittedBox(
                  fit: BoxFit.contain,
                  child: ClipRect(
                    clipper: _HalfClipper(
                      rtlMode: rtlMode,
                    ),
                    child: child,
                  ),
                ),
              ],
            )
          : FittedBox(
              child: child,
              fit: BoxFit.contain,
            ),
    );
  }
}

class _HalfClipper extends CustomClipper<Rect> {
  final bool rtlMode;

  _HalfClipper({
    required this.rtlMode,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width / 2,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width / 2,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

class _NoRatingWidget extends StatelessWidget {
  final double size;
  final Widget child;
  final bool enableMask;
  final Color? unratedColor;

  _NoRatingWidget({
    required this.size,
    required this.child,
    required this.enableMask,
    required this.unratedColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: FittedBox(
        fit: BoxFit.contain,
        child: enableMask
            ? _ColorFilter(
                color: unratedColor,
                child: child,
              )
            : child,
      ),
    );
  }
}

class _ColorFilter extends StatelessWidget {
  final Widget child;
  final Color? color;

  _ColorFilter({
    required this.child,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ColorFiltered(
      colorFilter: ColorFilter.mode(
        color!,
        BlendMode.srcATop,
      ),
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(
          Colors.white,
          BlendMode.srcATop,
        ),
        child: child,
      ),
    );
  }
}

class _IndicatorClipper extends CustomClipper<Rect> {
  final double? ratingFraction;
  final bool rtlMode;

  _IndicatorClipper({
    this.ratingFraction,
    this.rtlMode = false,
  });

  @override
  Rect getClip(Size size) => rtlMode
      ? Rect.fromLTRB(
          size.width - size.width * ratingFraction!,
          0.0,
          size.width,
          size.height,
        )
      : Rect.fromLTRB(
          0.0,
          0.0,
          size.width * ratingFraction!,
          size.height,
        );

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) => true;
}

/// A widget to display rating as assigned using [rating] property.
///
/// It's a read only version of [RatingBar].
/// Use [RatingBar], if interative version is required. i.e. if user input is required.
class RatingBarIndicator extends StatefulWidget {
  /// Defines the rating value for indicator.
  ///
  /// Default = 0.0
  final double rating;

  /// {@macro flutterRatingBar.itemCount}
  final int itemCount;

  /// {@macro flutterRatingBar.itemSize}
  final double itemSize;

  /// {@macro flutterRatingBar.itemPadding}
  final EdgeInsets itemPadding;

  /// Controls the scrolling behaviour of rating bar.
  ///
  /// Default is [NeverScrollableScrollPhysics].
  final ScrollPhysics physics;

  /// {@macro flutterRatingBar.textDirection}
  final TextDirection? textDirection;

  /// {@macro flutterRatingBar.itemBuilder}
  final IndexedWidgetBuilder itemBuilder;

  /// {@macro flutterRatingBar.direction}
  final Axis direction;

  /// {@macro flutterRatingBar.unratedColor}
  final Color? unratedColor;

  RatingBarIndicator({
    required this.itemBuilder,
    this.rating = 0.0,
    this.itemCount = 5,
    this.itemSize = 40.0,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.physics = const NeverScrollableScrollPhysics(),
    this.textDirection,
    this.direction = Axis.horizontal,
    this.unratedColor,
  });

  @override
  _RatingBarIndicatorState createState() => _RatingBarIndicatorState();
}

class _RatingBarIndicatorState extends State<RatingBarIndicator> {
  double _ratingFraction = 0.0;
  int _ratingNumber = 0;
  bool _isRTL = false;

  @override
  void initState() {
    super.initState();
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    _ratingNumber = widget.rating.truncate() + 1;
    _ratingFraction = widget.rating - _ratingNumber + 1;
    return SingleChildScrollView(
      scrollDirection: widget.direction,
      physics: widget.physics,
      child: widget.direction == Axis.horizontal
          ? Row(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
              children: _children(),
            ),
    );
  }

  List<Widget> _children() {
    return List.generate(
      widget.itemCount,
      (index) {
        if (widget.textDirection != null) {
          if (widget.textDirection == TextDirection.rtl && Directionality.of(context) != TextDirection.rtl) {
            return Transform(
              transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
              alignment: Alignment.center,
              transformHitTests: false,
              child: _buildItems(index),
            );
          }
        }
        return _buildItems(index);
      },
    );
  }

  Widget _buildItems(int index) => Padding(
        padding: widget.itemPadding,
        child: SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: index + 1 < _ratingNumber
                    ? widget.itemBuilder(context, index)
                    : _ColorFilter(
                        color: widget.unratedColor ?? Colors.grey[200],
                        child: widget.itemBuilder(context, index),
                      ),
              ),
              if (index + 1 == _ratingNumber)
                _isRTL
                    ? FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                            rtlMode: _isRTL,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      )
                    : FittedBox(
                        fit: BoxFit.contain,
                        child: ClipRect(
                          clipper: _IndicatorClipper(
                            ratingFraction: _ratingFraction,
                          ),
                          child: widget.itemBuilder(context, index),
                        ),
                      ),
            ],
          ),
        ),
      );
}

/// A widget to receive rating input from users.
///
/// [RatingBar] can also be used to display rating
///
/// Prefer using [RatingBarIndicator] instead, if read only version is required.
/// As RatingBarIndicator supports any fractional rating value.
class RatingBar extends StatefulWidget {
  /// {@template flutterRatingBar.itemCount}
  /// Defines total number of rating bar items.
  ///
  /// Default = 5
  /// {@endtemplate}
  final int itemCount;

  /// Defines the initial rating to be set to the rating bar.
  final double? initialRating;

  /// Return current rating whenever rating is updated.
  final ValueChanged<double> onRatingUpdate;

  /// {@template flutterRatingBar.itemSize}
  /// Defines width and height of each rating item in the bar.
  ///
  /// Default = 40.0
  /// {@endtemplate}
  final double itemSize;

  /// Default [allowHalfRating] = false. Setting true enables half rating support.
  final bool allowHalfRating;

  /// {@template flutterRatingBar.itemPadding}
  /// The amount of space by which to inset each rating item.
  /// {@endtemplate}
  final EdgeInsets itemPadding;

  /// if set to true, will disable any gestures over the rating bar.
  ///
  /// Default = false
  final bool ignoreGestures;

  /// if set to true will disable drag to rate feature. Note: Enabling this mode will disable half rating capability.
  ///
  /// Default = false
  final bool tapOnlyMode;

  /// {@template flutterRatingBar.textDirection}
  /// The text flows from right to left if [textDirection] = TextDirection.rtl
  /// {@endtemplate}
  final TextDirection? textDirection;

  /// {@template flutterRatingBar.itemBuilder}
  /// Widget for each rating bar item.
  /// {@endtemplate}
  final IndexedWidgetBuilder? itemBuilder;

  /// Customizes the Rating Bar item with [RatingWidget].
  final RatingWidget? ratingWidget;

  /// if set to true, Rating Bar item will glow when being touched.
  ///
  /// Default = true
  final bool glow;

  /// Defines the radius of glow.
  ///
  /// Default = 2
  final double glowRadius;

  /// Defines color for glow.
  ///
  /// Default = theme's accent color
  final Color? glowColor;

  /// {@template flutterRatingBar.direction}
  /// Direction of rating bar.
  ///
  /// Default = Axis.horizontal
  /// {@endtemplate}
  final Axis direction;

  /// {@template flutterRatingBar.unratedColor}
  /// Defines color for the unrated portion.
  ///
  /// Default = Colors.grey[200]
  /// {@endtemplate}
  final Color? unratedColor;

  /// Sets minimum rating
  ///
  /// Default = 0
  final double minRating;

  /// Sets maximum rating
  ///
  /// Default = [itemCount]
  final double? maxRating;

  RatingBar({
    this.itemCount = 5,
    this.initialRating = 0.0,
    required this.onRatingUpdate,
    this.itemSize = 40.0,
    this.allowHalfRating = false,
    this.itemBuilder,
    this.itemPadding = const EdgeInsets.all(0.0),
    this.ignoreGestures = false,
    this.tapOnlyMode = false,
    this.textDirection,
    this.ratingWidget,
    this.glow = true,
    this.glowRadius = 2,
    this.direction = Axis.horizontal,
    this.glowColor,
    this.unratedColor,
    this.minRating = 0,
    this.maxRating,
  }) : assert(
          (itemBuilder == null && ratingWidget != null) || (itemBuilder != null && ratingWidget == null),
          'itemBuilder and ratingWidget can\'t be initialized at the same time.'
          'Either remove ratingWidget or itembuilder.',
        );

  @override
  _RatingBarState createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  double? _rating = 0.0;

  //double _ratingHistory = 0.0;
  double iconRating = 0.0;
  double? _minRating, _maxrating;
  bool _isRTL = false;
  ValueNotifier<bool> _glow = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
    _rating = widget.initialRating;
  }

  @override
  void didUpdateWidget(RatingBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      _rating = widget.initialRating;
    }
    _minRating = widget.minRating;
    _maxrating = widget.maxRating ?? widget.itemCount.toDouble();
  }

  @override
  void dispose() {
    _glow.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _isRTL = (widget.textDirection ?? Directionality.of(context)) == TextDirection.rtl;
    iconRating = 0.0;
    return Material(
      color: Colors.transparent,
      child: Wrap(
        alignment: WrapAlignment.start,
        textDirection: _isRTL ? TextDirection.rtl : TextDirection.ltr,
        direction: widget.direction,
        children: List.generate(
          widget.itemCount,
          (index) => _buildRating(context, index),
        ),
      ),
    );
  }

  Widget _buildRating(BuildContext context, int index) {
    Widget ratingWidget;
    if (index >= _rating!) {
      ratingWidget = _NoRatingWidget(
        size: widget.itemSize,
        child: widget.ratingWidget?.empty ?? widget.itemBuilder!(context, index),
        enableMask: widget.ratingWidget == null,
        unratedColor: widget.unratedColor ?? Colors.grey[200],
      );
    } else if (index >= _rating! - (widget.allowHalfRating ? 0.5 : 1.0) && index < _rating! && widget.allowHalfRating) {
      if (widget.ratingWidget?.half == null) {
        ratingWidget = _HalfRatingWidget(
          size: widget.itemSize,
          child: widget.itemBuilder!(context, index),
          enableMask: widget.ratingWidget == null,
          rtlMode: _isRTL,
          unratedColor: widget.unratedColor ?? Colors.grey[200],
        );
      } else {
        ratingWidget = SizedBox(
          width: widget.itemSize,
          height: widget.itemSize,
          child: FittedBox(
            fit: BoxFit.contain,
            child: _isRTL
                ? Transform(
                    transform: Matrix4.identity()..scale(-1.0, 1.0, 1.0),
                    alignment: Alignment.center,
                    transformHitTests: false,
                    child: widget.ratingWidget!.half,
                  )
                : widget.ratingWidget!.half,
          ),
        );
      }
      iconRating += 0.5;
    } else {
      ratingWidget = SizedBox(
        width: widget.itemSize,
        height: widget.itemSize,
        child: FittedBox(
          fit: BoxFit.contain,
          child: widget.ratingWidget?.full ?? widget.itemBuilder!(context, index),
        ),
      );
      iconRating += 1.0;
    }

    return IgnorePointer(
      ignoring: widget.ignoreGestures,
      child: GestureDetector(
        onTap: () {
          widget.onRatingUpdate(index + 1.0);
          setState(() {
            _rating = index + 1.0;
          });
        },
        onHorizontalDragStart: _isHorizontal ? (_) => _glow.value = true : null,
        onHorizontalDragEnd: _isHorizontal
            ? (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              }
            : null,
        onHorizontalDragUpdate: _isHorizontal ? (dragUpdates) => _dragOperation(dragUpdates, widget.direction) : null,
        onVerticalDragStart: _isHorizontal ? null : (_) => _glow.value = true,
        onVerticalDragEnd: _isHorizontal
            ? null
            : (_) {
                _glow.value = false;
                widget.onRatingUpdate(iconRating);
                iconRating = 0.0;
              },
        onVerticalDragUpdate: _isHorizontal ? null : (dragUpdates) => _dragOperation(dragUpdates, widget.direction),
        child: Padding(
          padding: widget.itemPadding,
          child: ValueListenableBuilder(
            valueListenable: _glow,
            builder: (context, dynamic glow, _) {
              if (glow && widget.glow) {
                Color glowColor = widget.glowColor ?? Theme.of(context).canvasColor;
                return DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: glowColor.withAlpha(30),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                      BoxShadow(
                        color: glowColor.withAlpha(20),
                        blurRadius: 10,
                        spreadRadius: widget.glowRadius,
                      ),
                    ],
                  ),
                  child: ratingWidget,
                );
              } else {
                return ratingWidget;
              }
            },
          ),
        ),
      ),
    );
  }

  bool get _isHorizontal => widget.direction == Axis.horizontal;

  void _dragOperation(DragUpdateDetails dragDetails, Axis direction) {
    if (!widget.tapOnlyMode) {
      RenderBox box = context.findRenderObject() as RenderBox;
      var _pos = box.globalToLocal(dragDetails.globalPosition);
      double i;
      if (direction == Axis.horizontal) {
        i = _pos.dx / (widget.itemSize + widget.itemPadding.horizontal);
      } else {
        i = _pos.dy / (widget.itemSize + widget.itemPadding.vertical);
      }
      var currentRating = widget.allowHalfRating ? i : i.round().toDouble();
      if (currentRating > widget.itemCount) {
        currentRating = widget.itemCount.toDouble();
      }
      if (currentRating < 0) {
        currentRating = 0.0;
      }
      if (_isRTL && widget.direction == Axis.horizontal) {
        currentRating = widget.itemCount - currentRating;
      }
      if (currentRating < _minRating!) {
        _rating = _minRating;
      } else if (currentRating > _maxrating!) {
        _rating = _maxrating;
      } else {
        _rating = currentRating;
      }
      setState(() {});
    }
  }
}
