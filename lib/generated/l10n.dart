// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Select Your Healthcare Service`
  String get onBoarding_first_page_title {
    return Intl.message(
      'Select Your Healthcare Service',
      name: 'onBoarding_first_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Discover a range of medical solutions – clinics, pharmacies, and telehealth consultations all in one app!`
  String get onBoarding_first_page_subtitle {
    return Intl.message(
      'Discover a range of medical solutions – clinics, pharmacies, and telehealth consultations all in one app!',
      name: 'onBoarding_first_page_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Book & Pay Securely`
  String get onBoarding_second_page_title {
    return Intl.message(
      'Book & Pay Securely',
      name: 'onBoarding_second_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Easily schedule appointments and manage payments with our secure, hassle-free system.`
  String get onBoarding_second_page_subtitle {
    return Intl.message(
      'Easily schedule appointments and manage payments with our secure, hassle-free system.',
      name: 'onBoarding_second_page_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Receive Care at Your Convenience`
  String get onBoarding_third_page_title {
    return Intl.message(
      'Receive Care at Your Convenience',
      name: 'onBoarding_third_page_title',
      desc: '',
      args: [],
    );
  }

  /// `Whether in-person or online, experience swift and professional care tailored to your needs.`
  String get onBoarding_third_page_subtitle {
    return Intl.message(
      'Whether in-person or online, experience swift and professional care tailored to your needs.',
      name: 'onBoarding_third_page_subtitle',
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
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
