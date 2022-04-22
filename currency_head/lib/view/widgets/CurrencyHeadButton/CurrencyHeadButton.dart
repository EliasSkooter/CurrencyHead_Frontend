// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:currency_head/utils/themes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'CurrencyHeadLogo.dart';

class CurrencyHeadButton extends StatefulWidget {
  final Color color;
  final double opacity;
  final Color strokeColor;
  final Color strokeHoverColor;
  final double strokeWidth;
  final Size size;
  final String text;
  final Color textHoverColor;
  final TextStyle textStyle;
  final bool isHoveredOver;
  final VoidCallback function;

  // same exact variables and constructor for CurrencyHeadButtonPaint
  /// [function] is the callback function to be called onclick

  // everything in the button constructor matches the button painter constructor
  // !!!NOTE!!! about strokeHoverColor:
  // it is set to the default color so that, in case the button has to stay in the hovered style...
  // ...- for convenience's sake -...
  // ...therefore each time the button is called as a normal button strokeHoverColor has to be...
  // ...set to Colors.white
  const CurrencyHeadButton(
      {this.size = const Size(400, 50),
      this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = PRIMARY_COLOR,
      this.strokeHoverColor = Colors.white,
      this.strokeWidth = 2.0,
      this.text = 'Add your text here.',
      this.textHoverColor = Colors.white,
      this.textStyle = const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Roboto',
      ),
      this.isHoveredOver = false,
      required this.function,
      Key? key})
      : super(key: key);

  // creating state
  @override
  State<CurrencyHeadButton> createState() => _CurrencyHeadButtonState();
}

class _CurrencyHeadButtonState extends State<CurrencyHeadButton> {
  // keeping track of when the mouse is hovering over the button
  bool _hover = false;

  // changes state of hover
  void _buttonChange() {
    setState(() {
      _hover = !_hover;
    });
  }

  // building the component
  // the GestureDetector() catches onclick events and calls funtion()
  // MouseRegion() detects mouse enter and mouse leave events...
  // ...and calls _buttonChange() to change the hover state and therefore correct styling
  // CustomPaint, provided with the size, returns the painted CurrencyHeadButtonPainter
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => {widget.function()},
        child: MouseRegion(
            cursor: SystemMouseCursors.click,
            onEnter: (PointerEnterEvent event) => _buttonChange(),
            onExit: (PointerExitEvent event) => _buttonChange(),
            child: CustomPaint(
                willChange: true,
                size: widget.size,
                painter: CurrencyHeadButtonPainter(
                    size: widget.size,
                    opacity: widget.opacity,
                    color: widget.color,
                    strokeColor: widget.strokeColor,
                    strokeHoverColor: widget.strokeHoverColor,
                    strokeWidth: widget.strokeWidth,
                    text: widget.text,
                    textStyle: widget.textStyle,
                    textHoverColor: widget.textHoverColor,
                    isHoveredOver: _hover))));
  }
}

class CurrencyHeadButtonPainter extends CustomPainter {
  final Color color;
  final double opacity;
  final Color strokeColor;
  final Color strokeHoverColor;
  final double strokeWidth;
  final Size size;
  final String text;
  final Color textHoverColor;
  final TextStyle textStyle;
  final bool isHoveredOver;

  /// if you cant figure out what [color], [opacity], [strokeColor], and [strokeWidth] are
  /// then search for the closest opening in the room you're and and jump right out. don't look back.
  /// [size] dictates the width and height of the button

  // the constructor has the same values as CurrencyHeadLogo() except for strokeWidth
  // !!!NOTE!!! about strokeHoverColor:
  // it is set to the default color so that, in case the button has to stay in the hovered style...
  // ...- for convenience's sake -...
  // ...therefore each time the button is called as a normal button strokeHoverColor has to be...
  // ...set to Colors.white
  CurrencyHeadButtonPainter(
      {this.size = const Size(45, 100),
      this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = PRIMARY_COLOR,
      this.strokeHoverColor = Colors.white,
      this.strokeWidth = 2.0,
      this.text = 'Add your text here.',
      this.textHoverColor = Colors.white,
      this.textStyle = const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 14,
        fontFamily: 'Roboto',
      ),
      this.isHoveredOver = false,
      Key? key})
      : super();

  // overriding paint function to paint the button
  @override
  void paint(Canvas canvas, Size size) {
    double strokeOffset = strokeWidth / 2;

    /// [strokeOffset] is the stroke offset value to avoid it going outside the bounding box of the button

    // declaring a CurrencyHeadLogo and getting its parameters
    CurrencyHeadLogo logo = CurrencyHeadLogo.widthHeight(
        size: size.height,
        opacity: opacity,
        color: color,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth);

    Path logoPath = logo.getPath();
    Paint logoPaint = logo.getPaint();
    Paint logoPaintStroke = logo.getPaintStroke();
    Size logoSize = logo.getSize();

    /// [logoPath] will be used to add the logo's path to the button's path
    /// [logoPaint] and [logoPaintStroke] will define the paint styles for the logo and the stroke
    /// [logoSize] is the size of the logo (duh...)

    // creating path
    /// 1 - start a new path at (x, y), x being the logo's head...
    /// ...using path.moveTo(x, y), y is offset by [strokeOffset] to account for [strokeWidth]
    /// 2 - create a line using towards (x, y) path.lineTo(x, y), y is also offset here the same way
    /// 3 - create an arc using addArc within a bounding box Rect (centered vertically and at size.height horizontally)...
    /// ...with a width offset by [strokeWidth] (2xstrokeOffset since there are 2 strokes to take care of)...
    /// ...and a height offset by [strokeOffset] * pi because that worked for some mathematical reason i...
    /// ...dont care enough to figure out.
    /// 4 - create another line back to the logo's foot
    /// the rest is part of the CurrencyHead logo reconverted from SVG and altered a bit
    Path path = Path();
    path.moveTo(logoSize.width * 0.7119342, strokeOffset);
    path.lineTo(size.width - logoSize.height, strokeOffset);
    path.addArc(
        Rect.fromCenter(
            center: Offset(
                size.width - logoSize.height, (size.height - strokeOffset) / 2),
            width: size.height - strokeWidth,
            height: size.height - strokeOffset * math.pi),
        -math.pi / 2,
        math.pi);
    path.lineTo(logoSize.width * 0.33, size.height - strokeOffset);
    // from here on out its altered CurrencyHeadLogo
    path.cubicTo(
        logoSize.width * 0.4156379,
        logoSize.height * 0.9644444,
        logoSize.width * 0.3292181,
        size.height * 1.008889,
        logoSize.width * 0.4156379,
        logoSize.height * 0.9644444);
    path.cubicTo(
        logoSize.width * 0.5020576,
        logoSize.height * 0.9200000,
        logoSize.width * 0.8024691,
        logoSize.height * 0.7622222,
        logoSize.width * 0.9012346,
        logoSize.height * 0.7066667);
    path.cubicTo(
        logoSize.width * 1.008230,
        logoSize.height * 0.6422222,
        logoSize.width * 1.078189,
        logoSize.height * 0.5466667,
        logoSize.width * 0.8189300,
        logoSize.height * 0.4244444);
    path.cubicTo(
        logoSize.width * 0.6543210,
        logoSize.height * 0.3333333,
        logoSize.width * 0.4485597,
        logoSize.height * 0.2288889,
        logoSize.width * 0.4485597,
        logoSize.height * 0.2288889);
    path.cubicTo(
        logoSize.width * 0.4485597,
        logoSize.height * 0.2288889,
        logoSize.width * 0.6419753,
        logoSize.height * 0.1155556,
        logoSize.width * 0.6954733,
        logoSize.height * 0.07777778);
    path.cubicTo(
        logoSize.width * 0.7530864,
        logoSize.height * 0.04222222,
        logoSize.width * 0.7325103,
        logoSize.height * 0.02000000,
        logoSize.width * 0.6619342,
        strokeOffset);
    path.close();
    // closed path

    // drawing button path first
    if (isHoveredOver) {
      Paint strokeHoverPaint = logoPaintStroke;
      strokeHoverPaint.color = strokeHoverColor;
      canvas.drawPath(path, logoPaint);
      canvas.drawPath(path, strokeHoverPaint);
    } else {
      canvas.drawPath(path, logoPaintStroke);
    }

    // adding the logoPath to the path AFTER drawing the first path
    // then drawing the logoPath with logoPaint
    // and stroking it if its hovered over
    path.addPath(logoPath, Offset(0, 0));
    canvas.drawPath(logoPath, logoPaint);

    // creating a hoverStyle text to change its color onhover
    // then created a TextPainter() with the textSpan and textStyle
    // calling textPainter.layout() because it seems important...
    // then painting it on the canvas with some centered offset math
    TextStyle hoverStyle = TextStyle().copyWith(color: textHoverColor);
    TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: isHoveredOver ? hoverStyle : textStyle,
        ),
        textDirection: TextDirection.ltr);
    textPainter.layout();

    textPainter.paint(
        canvas,
        Offset((size.width - textPainter.width) / 2,
            (size.height - textPainter.height) / 2));
  }

  // doesn't seem to work but just in case,
  // this is supposed to tell the program when it should repaint itself
  @override
  bool shouldRepaint(CurrencyHeadButtonPainter oldDelegate) =>
      isHoveredOver != oldDelegate.isHoveredOver;
}

/// ****************************************************************************
///
/// CurrencyHeadRoundButton is a cute lil button that turns when pressed and has an onPressed action
/// it may be provided with an animation duration and
class CurrencyHeadRoundButton extends StatefulWidget {
  final int duration;
  final double size;
  final VoidCallback onPressed;

  /// [duration] is the animation duration in milliseconds
  /// [size] is the size of the button (both width and height)
  /// [onPressed] is the function to be executed when the button is pressed

  const CurrencyHeadRoundButton({
    Key? key,
    this.duration = 200,
    this.size = 200,
    required this.onPressed,
  }) : super();

  @override
  State<StatefulWidget> createState() => _CurrencyHeadRoundButtonState();
}

class _CurrencyHeadRoundButtonState extends State<CurrencyHeadRoundButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late final AnimationController _controller;
  late final Animation<double> _animation;

  /// [isPressed] keeps track of when the button is "on" or "off", activated or not
  /// [_controller] and [_animation] control... the animation of the button.

  final Tween<double> _tweenRotate = Tween(begin: 0.0, end: 0.25);

  /// [_tweenRotate] controls the length to which the button will rotate.
  /// its set to 25% (pi/4 or 90 degrees) by default

  /// overriding initState() and assigning [_controller] to an animationController with
  /// a set widget.duration, and assigning [_animation] to animate on [_tweenRotate]
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration),
    );

    _animation = _tweenRotate.animate(_controller);
    super.initState();
  }

  /// the dispose() function ensures no leaks happen once the [_controller] is not needed anymore
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// _handleTap() is the state and animation handler
  /// 1 - first it toggles the state of the button
  /// 2 - then it plays the corresponding animation based on the state
  /// (by setting the controller to forward() or reverse())
  /// 3 - then executes the [onPress] function
  void _handleTap() {
    setState(() {
      isPressed = !isPressed;
    });

    if (isPressed) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    widget.onPressed();
  }

  /// the following mishmash of widgets is essentially:
  /// an enclosing compainer with a set width and height (widget.size) and child alignment.center
  /// a MouseRegion to turn the mouse cursor to pointer onHover
  /// a GestureDetector that handles the onTap event (and calls _handlTap())
  /// the RotationTransition for the animation and it takes in [_animation]
  /// the Container containing the actual logo, styled as a circle with a border and a white background
  /// the logo painter (CustomPaint) taking in
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.size,
      width: widget.size,
      alignment: Alignment.center,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _handleTap(),
          child: RotationTransition(
            turns: _animation,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  width: 2.0,
                  color: PRIMARY_COLOR,
                ),
              ),
              child: CustomPaint(
                size: Size.square(50),
                // painter: CurrencyHeadLogoPainter(
                //   color: PRIMARY_COLOR,
                //   strokeWidth: 0.0,
                // ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
