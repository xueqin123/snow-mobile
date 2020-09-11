import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PortraitWidget extends StatelessWidget {
  final String _portraitUrl;
  final double _width;

  PortraitWidget(this._portraitUrl, this._width);


  Widget buildNetImage() {
    if (_portraitUrl == null || _portraitUrl.isEmpty) {
      return Container(
        width: _width,
        height: _width,
        child: Image.asset("images/avatar_default.png"),
      );
    } else {
      return CachedNetworkImage(
        fit: BoxFit.fill,
        fadeInDuration: Duration(),
        fadeOutDuration: Duration(),
        imageUrl: _portraitUrl,
        imageBuilder: (context, imageProvider) =>
            Container(
              width: _width,
              height: _width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: imageProvider, fit: BoxFit.cover),
              ),
            ),
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Image.asset("images/avatar_default.png"),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return buildNetImage();
  }
}
