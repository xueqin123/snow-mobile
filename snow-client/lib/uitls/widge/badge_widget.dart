import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatefulWidget {
  final Widget anchor;
  final int _count;

  BadgeWidget(this._count, {@required this.anchor, Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => BadgeWidgetState();
}

class BadgeWidgetState extends State<BadgeWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        widget.anchor,
        Visibility(
          visible: widget._count != 0,
          child: Positioned(
            right: -8,
            top: -8,
            child: Material(
              type: MaterialType.circle,
              color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  widget._count.toString(),
                  style: TextStyle(fontSize: 10),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
