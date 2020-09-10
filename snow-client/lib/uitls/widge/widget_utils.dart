import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WidgetUtils {
  static Widget buildNetImage(String portraitUrl) {
    if (portraitUrl == null || portraitUrl.isEmpty) {
      return Image.asset("images/avatar_default.png");
    } else {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        fadeInDuration: Duration(),
        fadeOutDuration: Duration(),
        imageUrl: portraitUrl,
        placeholder: (context, url) => Image.asset("images/avatar_default.png"),
        errorWidget: (context, url, error) => Image.asset("images/avatar_default.png"),
      );
    }
  }
}
