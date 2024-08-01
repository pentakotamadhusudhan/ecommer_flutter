import 'dart:ui' as ui;

import 'package:flutter/material.dart';

/// `DefaultColors` incase `color` paramter is null in `ContentType`
class DefaultColors {
  /// help
  static const Color helpBlue = Color(0xff3282B8);

  /// failure
  static const Color failureRed = ui.Color.fromARGB(255, 211, 78, 95);

  /// success
  static const Color successGreen = ui.Color.fromARGB(255, 118, 198, 162);

  /// warning
  static const Color warningYellow = Color(0xffFCA652);
}

/// to handle failure, success, help and warning `ContentType` class is being used
class ContentType {
  /// message is `required` parameter
  final String message;

  /// color is optional, if provided null then `DefaultColors` will be used
  final Color? color;

  const ContentType(this.message, [this.color]);

  static const ContentType help = ContentType('help', DefaultColors.helpBlue);
  static const ContentType failure =
  ContentType('failure', DefaultColors.failureRed);
  static const ContentType success =
  ContentType('success', DefaultColors.successGreen);
  static const ContentType warning =
  ContentType('warning', DefaultColors.warningYellow);
}

class AwesomeSnackbarContent extends StatelessWidget {

  final String title;

  final String? message;
  final Color? color;
  final ContentType contentType;
  final bool inMaterialBanner;
  final double? titleFontSize;
  final double? messageFontSize;
  const AwesomeSnackbarContent({
    super.key,
    this.color,
    this.titleFontSize,
    this.messageFontSize,
    required this.title,
    this.message,
    required this.contentType,
    this.inMaterialBanner = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isRTL = Directionality.of(context) == TextDirection.rtl;

    final size = MediaQuery.of(context).size;
    bool isMobile = size.width <= 768;
    bool isTablet = size.width > 768 && size.width <= 992;
    final hsl = HSLColor.fromColor(color ?? contentType.color!);
    final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));
    double horizontalPadding = 0.0;
    double leftSpace = size.width * 0.12;
    double rightSpace = size.width * 0.12;
    if (isMobile) {
      horizontalPadding = 2;
    } else if (isTablet) {
      leftSpace = size.width * 0.02;
      horizontalPadding = size.width * 0.2;
    } else {
      leftSpace = size.width * 0.02;
      horizontalPadding = size.width * 0.3;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
      ),
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          /// background container
          Container(
            width: size.width,
            decoration: BoxDecoration(
              color: color ?? contentType.color,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Positioned.fill(
            left: isRTL ? size.width * 0.03 : leftSpace,
            right: isRTL ? rightSpace : size.width * 0.03,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                message != null
                    ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          maxLines: 3,
                          textAlign: TextAlign.start,
                          "$message",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                    : Container(
                  margin: const EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          )
        ],
      ),
    );
  }


  static ColorFilter? _getColorFilter(
      ui.Color? color, ui.BlendMode colorBlendMode) =>
      color == null ? null : ui.ColorFilter.mode(color, colorBlendMode);
}
