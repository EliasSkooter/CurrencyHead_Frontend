import 'package:currency_head/utils/themes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CurrencyHeadLogo {
  final double size;
  final double opacity;
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final double _width;
  final double _height;
  final Color offset1;
  final Color offset2;

  /// [size] is the width OR height of the svg (based on the constructor)
  ///
  /// the height is automatically calculated based on a ratio
  ///
  /// [opacity] is the opacity of the svg
  ///
  /// [color] is the background color of the svg
  ///
  /// [strokeColor] common is this really necessary?
  ///
  /// [strokeWidth] sigh...
  ///
  /// [offset1] it only gets worse buddy
  ///
  /// [offset2] oh yeah...

  // constructor(s)
  // default constructor should be provided with width
  // withHeight should be provided with height
  CurrencyHeadLogo(
      {this.size = 24.3,
      this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = STROKE_COLOR,
      this.strokeWidth = 1.0,
      this.offset1 = const Color(0xFFBA68C8),
      this.offset2 = const Color(0xFF4A148C)})
      : _width = size,
        _height = size * 1.8518518518518519;

  CurrencyHeadLogo.widthHeight(
      {this.size = 45,
      this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = STROKE_COLOR,
      this.strokeWidth = 1.0,
      this.offset1 = const Color(0xFFBA68C8),
      this.offset2 = const Color(0xFF4A148C)})
      : _width = size / 1.8518518518518519,
        _height = size;

  /// [getSize] returns the Size() with width and height
  /// [getPaint] returns the paint to be used in canvas (the styling of the path)
  /// [getPaintStroke] returns the stroke of the path to be used in canvas...
  /// ...use: canvas(path, getPaintStroke()); canvas(path, getPaint())
  /// [getPath] returns just the logo Path...
  /// ...it uses [getSize] to map the proper sizes onto the path

  Size getSize() => Size(_width, _height);
  double getHeightFromWidthMultiplier() => 1.8518518518518519;
  double getWidthFromHeightMultiplier() => 1 / 1.8518518518518519;

  Paint getPaint() {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..shader = ui.Gradient.linear(Offset(getSize().width / 2, 0),
          Offset(getSize().width / 2, getSize().height), [
        color.withAlpha(900),
        color,
      ]);
    paint.color = color.withOpacity(opacity);

    return paint;
  }

  Paint getPaintStroke() {
    Paint paintStroke = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    paintStroke.color = strokeColor.withOpacity(opacity);
    return paintStroke;
  }

  Path getPath() {
    Size size = getSize();
    Path path = Path();
    path.moveTo(size.width, size.height * 0.5000000);
    path.cubicTo(
        size.width,
        size.height * 0.6757063,
        size.width * 0.8983039,
        size.height * 0.8276954,
        size.width * 0.7508977,
        size.height * 0.9013512);
    path.cubicTo(
        size.width * 0.8634366,
        size.height * 0.8111122,
        size.width * 0.9370216,
        size.height * 0.6650288,
        size.width * 0.9370216,
        size.height * 0.5000000);
    path.cubicTo(
        size.width * 0.9370216,
        size.height * 0.3349476,
        size.width * 0.8634366,
        size.height * 0.1888878,
        size.width * 0.7508977,
        size.height * 0.09864878);
    path.cubicTo(size.width * 0.8983039, size.height * 0.1723046, size.width,
        size.height * 0.3243173, size.width, size.height * 0.5000000);
    path.close();
    path.moveTo(size.width * 0.8976661, size.height * 0.5000000);
    path.cubicTo(
        size.width * 0.8976661,
        size.height * 0.2525040,
        size.width * 0.6963763,
        size.height * 0.05116697,
        size.width * 0.4488330,
        size.height * 0.05116697);
    path.cubicTo(size.width * 0.2013370, size.height * 0.05116697, 0,
        size.height * 0.2525040, 0, size.height * 0.5000000);
    path.cubicTo(
        0,
        size.height * 0.7474960,
        size.width * 0.2013370,
        size.height * 0.9488330,
        size.width * 0.4488330,
        size.height * 0.9488330);
    path.cubicTo(
        size.width * 0.6963763,
        size.height * 0.9488330,
        size.width * 0.8976661,
        size.height * 0.7474960,
        size.width * 0.8976661,
        size.height * 0.5000000);
    path.close();
    path.moveTo(size.width * 0.7795521, size.height * 0.5000000);
    path.cubicTo(
        size.width * 0.7795521,
        size.height * 0.6823916,
        size.width * 0.6312246,
        size.height * 0.8307191,
        size.width * 0.4488330,
        size.height * 0.8307191);
    path.cubicTo(
        size.width * 0.2664415,
        size.height * 0.8307191,
        size.width * 0.1181140,
        size.height * 0.6823916,
        size.width * 0.1181140,
        size.height * 0.5000000);
    path.cubicTo(
        size.width * 0.1181140,
        size.height * 0.3176321,
        size.width * 0.2664415,
        size.height * 0.1692809,
        size.width * 0.4488330,
        size.height * 0.1692809);
    path.cubicTo(
        size.width * 0.6311774,
        size.height * 0.1692809,
        size.width * 0.7795521,
        size.height * 0.3176321,
        size.width * 0.7795521,
        size.height * 0.5000000);
    path.close();
    path.moveTo(size.width * 0.4839365, size.height * 0.3566805);
    path.cubicTo(
        size.width * 0.5234811,
        size.height * 0.3566805,
        size.width * 0.5432297,
        size.height * 0.3725078,
        size.width * 0.5432297,
        size.height * 0.4041151);
    path.lineTo(size.width * 0.5435132, size.height * 0.4118397);
    path.lineTo(size.width * 0.6131768, size.height * 0.4118397);
    path.lineTo(size.width * 0.6131768, size.height * 0.4020599);
    path.cubicTo(
        size.width * 0.6131768,
        size.height * 0.3601531,
        size.width * 0.6032552,
        size.height * 0.3315223,
        size.width * 0.5833648,
        size.height * 0.3160966);
    path.cubicTo(
        size.width * 0.5635217,
        size.height * 0.3006945,
        size.width * 0.5266229,
        size.height * 0.2929699,
        size.width * 0.4726212,
        size.height * 0.2929699);
    path.lineTo(size.width * 0.4726212, size.height * 0.2514882);
    path.lineTo(size.width * 0.4240291, size.height * 0.2514882);
    path.lineTo(size.width * 0.4240291, size.height * 0.2929699);
    path.cubicTo(
        size.width * 0.3675234,
        size.height * 0.2929699,
        size.width * 0.3288529,
        size.height * 0.3010489,
        size.width * 0.3079940,
        size.height * 0.3171123);
    path.cubicTo(
        size.width * 0.2871823,
        size.height * 0.3332467,
        size.width * 0.2767174,
        size.height * 0.3631059,
        size.width * 0.2767174,
        size.height * 0.4067608);
    path.cubicTo(
        size.width * 0.2767174,
        size.height * 0.4518095,
        size.width * 0.2870642,
        size.height * 0.4825428,
        size.width * 0.3078522,
        size.height * 0.4989370);
    path.cubicTo(
        size.width * 0.3286166,
        size.height * 0.5153076,
        size.width * 0.3673344,
        size.height * 0.5235283,
        size.width * 0.4240291,
        size.height * 0.5235283);
    path.lineTo(size.width * 0.4240291, size.height * 0.6391146);
    path.lineTo(size.width * 0.4133752, size.height * 0.6388311);
    path.cubicTo(
        size.width * 0.3843192,
        size.height * 0.6388311,
        size.width * 0.3656336,
        size.height * 0.6350279,
        size.width * 0.3571766,
        size.height * 0.6274450);
    path.cubicTo(
        size.width * 0.3487905,
        size.height * 0.6198620,
        size.width * 0.3446329,
        size.height * 0.6028536,
        size.width * 0.3446329,
        size.height * 0.5766323);
    path.lineTo(size.width * 0.3446329, size.height * 0.5692384);
    path.lineTo(size.width * 0.2726070, size.height * 0.5692384);
    path.lineTo(size.width * 0.2722999, size.height * 0.5837664);
    path.cubicTo(
        size.width * 0.2722999,
        size.height * 0.6268544,
        size.width * 0.2826231,
        size.height * 0.6570916,
        size.width * 0.3032458,
        size.height * 0.6744543);
    path.cubicTo(
        size.width * 0.3239157,
        size.height * 0.6918407,
        size.width * 0.3596334,
        size.height * 0.7005339,
        size.width * 0.4104224,
        size.height * 0.7005339);
    path.lineTo(size.width * 0.4240291, size.height * 0.7008173);
    path.lineTo(size.width * 0.4240291, size.height * 0.7485354);
    path.lineTo(size.width * 0.4726212, size.height * 0.7485354);
    path.lineTo(size.width * 0.4726212, size.height * 0.7008173);
    path.lineTo(size.width * 0.4875035, size.height * 0.7004866);
    path.cubicTo(
        size.width * 0.5384579,
        size.height * 0.7004866,
        size.width * 0.5741756,
        size.height * 0.6913919,
        size.width * 0.5946565,
        size.height * 0.6732496);
    path.cubicTo(
        size.width * 0.6150430,
        size.height * 0.6550364,
        size.width * 0.6253189,
        size.height * 0.6235000,
        size.width * 0.6253189,
        size.height * 0.5784040);
    path.cubicTo(
        size.width * 0.6253189,
        size.height * 0.5365445,
        size.width * 0.6159407,
        size.height * 0.5077010,
        size.width * 0.5971842,
        size.height * 0.4920155);
    path.cubicTo(
        size.width * 0.5784040,
        size.height * 0.4762827,
        size.width * 0.5422848,
        size.height * 0.4669517,
        size.width * 0.4887319,
        size.height * 0.4639989);
    path.lineTo(size.width * 0.4726448, size.height * 0.4634083);
    path.lineTo(size.width * 0.4726448, size.height * 0.3566805);
    path.lineTo(size.width * 0.4839365, size.height * 0.3566805);
    path.lineTo(size.width * 0.4839365, size.height * 0.3566805);
    path.close();
    path.moveTo(size.width * 0.4240527, size.height * 0.4610224);
    path.cubicTo(
        size.width * 0.4173675,
        size.height * 0.4606444,
        size.width * 0.4138004,
        size.height * 0.4604554,
        size.width * 0.4133988,
        size.height * 0.4604554);
    path.cubicTo(
        size.width * 0.3709014,
        size.height * 0.4604554,
        size.width * 0.3497118,
        size.height * 0.4427856,
        size.width * 0.3497118,
        size.height * 0.4073987);
    path.cubicTo(
        size.width * 0.3497118,
        size.height * 0.3735944,
        size.width * 0.3710432,
        size.height * 0.3567041,
        size.width * 0.4137059,
        size.height * 0.3567041);
    path.lineTo(size.width * 0.4240527, size.height * 0.3563971);
    path.lineTo(size.width * 0.4240527, size.height * 0.4610224);
    path.lineTo(size.width * 0.4240527, size.height * 0.4610224);
    path.close();
    path.moveTo(size.width * 0.4726448, size.height * 0.5262449);
    path.cubicTo(
        size.width * 0.5053151,
        size.height * 0.5262449,
        size.width * 0.5267174,
        size.height * 0.5296938,
        size.width * 0.5370169,
        size.height * 0.5365917);
    path.cubicTo(
        size.width * 0.5473401,
        size.height * 0.5435132,
        size.width * 0.5524190,
        size.height * 0.5578286,
        size.width * 0.5524190,
        size.height * 0.5795852);
    path.cubicTo(
        size.width * 0.5524190,
        size.height * 0.6192951,
        size.width * 0.5292686,
        size.height * 0.6391382,
        size.width * 0.4830152,
        size.height * 0.6391382);
    path.lineTo(size.width * 0.4726684, size.height * 0.6391382);
    path.lineTo(size.width * 0.4726448, size.height * 0.5262449);
    path.lineTo(size.width * 0.4726448, size.height * 0.5262449);
    path.close();
    return path;
  }
}

/// CurrencyHeadLogoPainter is the CustomPainter (to be used along with CustomPaint)
/// that makes use of the CurrencyHeadLogo class to create a painter that can be used
/// anywhere
class CurrencyHeadLogoPainter extends CustomPainter {
  final Color color;
  final Color strokeColor;
  final double strokeWidth;
  final double opacity;
  final bool withHeight;
  final Color offset1;
  final Color offset2;

  CurrencyHeadLogoPainter(
      {this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = STROKE_COLOR,
      this.strokeWidth = 1.0,
      this.offset1 = const Color(0xFFBA68C8),
      this.offset2 = const Color(0xFF4A148C)})
      : this.withHeight = false,
        super();

  CurrencyHeadLogoPainter.withHeight(
      {this.opacity = 1.0,
      this.color = PRIMARY_COLOR,
      this.strokeColor = STROKE_COLOR,
      this.strokeWidth = 1.0,
      this.offset1 = const Color(0xFFBA68C8),
      this.offset2 = const Color(0xFF4A148C)})
      : this.withHeight = true,
        super();

  @override
  void paint(Canvas canvas, Size size) {
    CurrencyHeadLogo logo = this.withHeight
        ? CurrencyHeadLogo.widthHeight(
            size: size.height,
            color: color,
            strokeColor: strokeColor,
            strokeWidth: strokeWidth,
            opacity: opacity,
            offset1: offset1,
            offset2: offset2)
        : CurrencyHeadLogo(
            size: size.width,
            color: color,
            strokeColor: strokeColor,
            strokeWidth: strokeWidth,
            opacity: opacity,
            offset1: offset1,
            offset2: offset2);
    Path path = logo.getPath();
    Paint paint = logo.getPaint();
    canvas.drawPath(path, logo.getPaintStroke());
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

/// CurrencyHeadTitle is a fixed CurrencyHeadLogo with the words "CurrencyHead" next to it
class CurrencyHeadTitle extends StatelessWidget {
  final double height;
  final Color color;
  final bool showText;
  final Color offset1;
  final Color offset2;

  CurrencyHeadTitle(
      {Key? key,
      this.height = 20,
      this.color = PRIMARY_COLOR,
      this.showText = true,
      this.offset1 = const Color(0xFFBA68C8),
      this.offset2 = const Color(0xFF4A148C)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: height,
          child: CustomPaint(
            size: Size(
                height * CurrencyHeadLogo().getWidthFromHeightMultiplier() + 5,
                height),
            painter: CurrencyHeadLogoPainter.withHeight(
                color: color,
                strokeWidth: 0,
                strokeColor: PRIMARY_COLOR,
                offset1: offset1,
                offset2: offset2),
          ),
        ),
        if (showText)
          Container(
            alignment: Alignment.center,
            child: Text(
              "CurrencyHead",
              style: TextStyle(
                  fontSize: height / 2,
                  fontWeight: FontWeight.bold,
                  color: color),
            ),
          ),
      ],
    );
  }
}
