import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 100,
        color: Colors.red,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              color: Colors.blue,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  width: 10,
                  color: Colors.yellow,
                  height: 10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
