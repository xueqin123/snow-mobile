import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:snowclient/pages/chat/detail/chat_detail_page.dart';
import 'package:snowclient/pages/common/image_crop_page.dart';
import 'package:snowclient/pages/message/message_page.dart';
import 'package:snowclient/pages/splash/splash_page.dart';
import 'package:snowclient/uitls/const_router.dart';
import 'generated/l10n.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(SnowApp());
}

class SnowApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [S.delegate, GlobalMaterialLocalizations.delegate, GlobalWidgetsLocalizations.delegate, GlobalCupertinoLocalizations.delegate],
      theme: ThemeData(
        primaryColor: Colors.lightBlueAccent,
        accentColor: Colors.yellow,
      ),
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      routes: {
        ConstRouter.MESSAGE_PAGE: (BuildContext buildContext) => MessagePage(),
        ConstRouter.CHAT_DETAIL_PAGE: (BuildContext buildContext) => ChatDetailPage(),
        ConstRouter.IMAGE_CROP_PAGE: (BuildContext buildContext) => ImageCropPage(),
      },
      home: SplashPage(),
    );
  }
}
