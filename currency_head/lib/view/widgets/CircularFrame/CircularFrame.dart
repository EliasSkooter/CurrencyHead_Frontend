import 'dart:math'; // used to randomize the 2 outer circles

import 'package:currency_head/utils/themes.dart';
import 'package:flutter/material.dart';

// The circularFrame class is a special circular frame which has a base circle
// (which is the actual frame containing something), and 2 circles over it with slightly randomized
// position (around the base frame) and slightly less saturated colors.
//
// The base color provided should be the darkes and most saturated.
// The class can return a frame that holds:
// - Nothing
// - A picture from an online source
// - Text

class CircularFrame extends StatelessWidget {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double size;
  final String imageSrc;
  final String text;
  final TextStyle? textStyle;
  final String _type;
  final BoxFit? imageFit;
  final Widget? child;
  final bool showBadge;
  final Widget? badge;

  /// [backgroundColor] - background color of main cicle
  /// [borderColor] - border color - will be modified for 2 outer circles to be brighter
  /// [borderWidth] - the thickness of the circles
  /// [size] - width and height of the circles (uses 1 variable to make it a perfect cirlce, not oval)
  /// [imageSrc] - the image to be displayed inside frame
  /// [text] - the text to be displayed inside frame
  /// [textStyle] - style of text
  /// [_type] - variables that is set automatically to 'default', 'image-from-url', or 'text'. helps with if statements

  // default constructor
  // has no image or text ( and therefore no textStyle ) with _type 'default'
  CircularFrame(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.borderColor = PRIMARY_COLOR,
      this.borderWidth = 4,
      this.size = 250.0,
      this.child,
      this.showBadge = false,
      this.badge})
      : imageSrc = '',
        text = '',
        textStyle = TextStyle(),
        imageFit = null,
        _type = 'default',
        super(key: key);

  // image from url constructor
  // has imageSrc required from user, but no text nor textStyle with _type 'image-from-url'
  CircularFrame.imageFromUrl(
      {Key? key,
      this.backgroundColor = Colors.transparent,
      this.borderColor = PRIMARY_COLOR,
      this.borderWidth = 4,
      this.size = 250.0,
      this.imageFit,
      required this.imageSrc,
      this.showBadge = false,
      this.badge})
      : text = '',
        textStyle = TextStyle(),
        child = null,
        _type = 'image-from-url',
        super(key: key);

  // image from url constructor
  // has imageSrc required from user, but no text nor textStyle with _type 'image-from-url'
  CircularFrame.imageAsset(
      {Key? key,
      this.backgroundColor = Colors.transparent,
      this.borderColor = PRIMARY_COLOR,
      this.borderWidth = 4,
      this.size = 250.0,
      this.imageFit,
      required this.imageSrc,
      this.showBadge = false,
      this.badge})
      : text = '',
        textStyle = TextStyle(),
        child = null,
        _type = 'image-asset',
        super(key: key);

  // text constructor
  // has text and textStyle but no image with _type 'text'
  const CircularFrame.text(
      {Key? key,
      this.backgroundColor = Colors.white,
      this.borderColor = PRIMARY_COLOR,
      this.borderWidth = 4,
      this.size = 250.0,
      this.imageFit,
      this.textStyle = const TextStyle(
        color: Colors.amber,
        fontWeight: FontWeight.bold,
        fontSize: 32,
        fontFamily: 'Roboto',
      ),
      required this.text,
      this.showBadge = false,
      this.badge})
      : imageSrc = '',
        child = null,
        _type = 'text',
        super(key: key);

  // function that returns a generic circle container
  // should be provided with altered border saturation and lightness (brightness)
  // has tiny randomized translation (position)
  Center _genericContainer(double saturation, double lightness) {
    // translation is based on a multiple of borderWidth for consistency
    int x = Random().nextInt(borderWidth.toInt() * 4),
        y = Random().nextInt(borderWidth.toInt() * 4);

    // width and height of container are the same because prefect circles.
    // circles should be transparent on the inside to show the base frame
    /// [borderWidth] is used for the width of the border (duh...)
    /// white [borderColor] is used as a base color with replaced saturation and
    /// lightness values based on the ones provided in function call

    // -- details about border color --
    /// [borderColor] (Color) -> HSLColor via HSLColor.fromColor
    /// which is then modified
    /// and then cast back to (Color)

    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            width: borderWidth,
            color: HSLColor.fromColor(borderColor)
                .withSaturation(saturation)
                .withLightness(lightness)
                .toColor(),
          ),
        ),
        // changing position by translating by (x, y, z = 0)
        transform: Matrix4.translationValues(x.toDouble(), y.toDouble(), 0),
      ),
    );
  }

  // function that returns an array to be then used in build() as a Stack Widget to render circles in proper order
  List<Widget> _stack() {
    // first Container has the same decorations as _genericContainer() but with base color instead

    // if _type == 'default' or 'text', a boxShadow is applied
    // the INNER BOX SHADOW is created by having 2 layered elements
    // the first is a solid grey color
    /// the second is a [backgroundColor] with blur radius (factor of [size] for consistency)

    // BoxFit.cover ensures the image takes entire background space
    // ClipRRect() ensures image is clipped when larger than container
    // Center centers text vertically and horizontally relative to container
    // while TextAlign.center centers text typographically

    // lastly the border is applied over everything
    return <Widget>[
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.grey),
                BoxShadow(
                  color: backgroundColor,
                  blurRadius: size / 3.0,
                )
              ],
            ),
          ),
        ),
      ),
      Center(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(size / 2),
          child: Container(
            height: size,
            width: size,
            child: Container(
              alignment: Alignment.center,
              width: size,
              height: size,
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: _type == 'default'
                  ? child
                  : _type == 'image-from-url'
                      ? Image.network(
                          imageSrc,
                          width: size,
                          height: size,
                          fit: imageFit ?? BoxFit.cover,
                        )
                      : _type == 'image-asset'
                          ? Image.asset(
                              imageSrc,
                              width: size,
                              height: size,
                              fit: imageFit ?? BoxFit.cover,
                            )
                          : _type == 'text'
                              ? Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    text,
                                    textAlign: TextAlign.center,
                                    style: textStyle,
                                  ),
                                )
                              : Container(
                                  height: size,
                                  width: size,
                                  alignment: Alignment.center,
                                  child: FittedBox(
                                    fit: BoxFit.fitWidth,
                                    child: Text(
                                      'Provide image or text or use default constructor.',
                                      textAlign: TextAlign.center,
                                      style: textStyle,
                                    ),
                                  ),
                                ),
            ),
          ),
        ),
      ),
      Center(
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              width: borderWidth,
              color: borderColor,
            ),
          ),
        ),
      ),

      // first and second cirlces are added,
      // respectively with less saturated and brighter, and least saturated and brightest borders.
      _genericContainer(0.5, 0.6),
      _genericContainer(0.3, 0.7),
      Visibility(
        visible: showBadge,
        child: Positioned(
          top: 0,
          // bottom: 0,
          // left: 0,
          right: 0,
          child: badge ?? SizedBox.shrink(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: _stack()); // renders stack
  }
}
