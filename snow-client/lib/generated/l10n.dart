// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class S {
  S();
  
  static S current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();
      
      return S.current;
    });
  } 

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `en`
  String get _locale {
    return Intl.message(
      'en',
      name: '_locale',
      desc: '',
      args: [],
    );
  }

  /// `SnowMsg`
  String get appName {
    return Intl.message(
      'SnowMsg',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `success`
  String get success {
    return Intl.message(
      'success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `failed`
  String get failed {
    return Intl.message(
      'failed',
      name: 'failed',
      desc: '',
      args: [],
    );
  }

  /// `Message`
  String get pageHomeTabMessage {
    return Intl.message(
      'Message',
      name: 'pageHomeTabMessage',
      desc: '',
      args: [],
    );
  }

  /// `Contacts`
  String get pageHomeTabContact {
    return Intl.message(
      'Contacts',
      name: 'pageHomeTabContact',
      desc: '',
      args: [],
    );
  }

  /// `Discover`
  String get pageHomeTabDiscover {
    return Intl.message(
      'Discover',
      name: 'pageHomeTabDiscover',
      desc: '',
      args: [],
    );
  }

  /// `Mine`
  String get pageHomeTabMine {
    return Intl.message(
      'Mine',
      name: 'pageHomeTabMine',
      desc: '',
      args: [],
    );
  }

  /// `start group chat`
  String get pageMessagePopStartChat {
    return Intl.message(
      'start group chat',
      name: 'pageMessagePopStartChat',
      desc: '',
      args: [],
    );
  }

  /// `add friend`
  String get pageMessagePopAddFriend {
    return Intl.message(
      'add friend',
      name: 'pageMessagePopAddFriend',
      desc: '',
      args: [],
    );
  }

  /// `phone number`
  String get loginPhoneNumber {
    return Intl.message(
      'phone number',
      name: 'loginPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get loginPassword {
    return Intl.message(
      'password',
      name: 'loginPassword',
      desc: '',
      args: [],
    );
  }

  /// `login`
  String get loginButton {
    return Intl.message(
      'login',
      name: 'loginButton',
      desc: '',
      args: [],
    );
  }

  /// `Phone/password input error`
  String get loginError {
    return Intl.message(
      'Phone/password input error',
      name: 'loginError',
      desc: '',
      args: [],
    );
  }

  /// `login network failed`
  String get loginHttpError {
    return Intl.message(
      'login network failed',
      name: 'loginHttpError',
      desc: '',
      args: [],
    );
  }

  /// `login success`
  String get loginSuccess {
    return Intl.message(
      'login success',
      name: 'loginSuccess',
      desc: '',
      args: [],
    );
  }

  /// `contact profile`
  String get contactProfile {
    return Intl.message(
      'contact profile',
      name: 'contactProfile',
      desc: '',
      args: [],
    );
  }

  /// `send message`
  String get contactProfileSendMessage {
    return Intl.message(
      'send message',
      name: 'contactProfileSendMessage',
      desc: '',
      args: [],
    );
  }

  /// `send`
  String get messageSend {
    return Intl.message(
      'send',
      name: 'messageSend',
      desc: '',
      args: [],
    );
  }

  /// `select contact`
  String get contactSelect {
    return Intl.message(
      'select contact',
      name: 'contactSelect',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `createGroupSuccess`
  String get createGroupSuccess {
    return Intl.message(
      'createGroupSuccess',
      name: 'createGroupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `createGroupFailed`
  String get createGroupFailed {
    return Intl.message(
      'createGroupFailed',
      name: 'createGroupFailed',
      desc: '',
      args: [],
    );
  }

  /// `dismissGroup`
  String get dissmissGroup {
    return Intl.message(
      'dismissGroup',
      name: 'dissmissGroup',
      desc: '',
      args: [],
    );
  }

  /// `dissmissGroupSuccess`
  String get dissmissGroupSuccess {
    return Intl.message(
      'dissmissGroupSuccess',
      name: 'dissmissGroupSuccess',
      desc: '',
      args: [],
    );
  }

  /// `dissmissGroupFailed`
  String get dissmissGroupFailed {
    return Intl.message(
      'dissmissGroupFailed',
      name: 'dissmissGroupFailed',
      desc: '',
      args: [],
    );
  }

  /// `picture`
  String get pluginImage {
    return Intl.message(
      'picture',
      name: 'pluginImage',
      desc: '',
      args: [],
    );
  }

  /// `camera`
  String get pluginCamera {
    return Intl.message(
      'camera',
      name: 'pluginCamera',
      desc: '',
      args: [],
    );
  }

  /// `portrait crop`
  String get cropPortrait {
    return Intl.message(
      'portrait crop',
      name: 'cropPortrait',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}