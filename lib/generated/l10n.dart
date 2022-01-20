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
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
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
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Europharm`
  String get title {
    return Intl.message(
      'Europharm',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Got a message whilst in the foreground!`
  String get push_foreground {
    return Intl.message(
      'Got a message whilst in the foreground!',
      name: 'push_foreground',
      desc: '',
      args: [],
    );
  }

  /// `Message data`
  String get message_data {
    return Intl.message(
      'Message data',
      name: 'message_data',
      desc: '',
      args: [],
    );
  }

  /// `Message also contained a notification`
  String get message_contained_notification {
    return Intl.message(
      'Message also contained a notification',
      name: 'message_contained_notification',
      desc: '',
      args: [],
    );
  }

  /// `Firebase messaging token`
  String get firebase_messaging_token {
    return Intl.message(
      'Firebase messaging token',
      name: 'firebase_messaging_token',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Server is not reachable. Please verify your internet connection and try again`
  String get server_is_not_reachable {
    return Intl.message(
      'Server is not reachable. Please verify your internet connection and try again',
      name: 'server_is_not_reachable',
      desc: '',
      args: [],
    );
  }

  /// `Problem connecting to the server. Please try again`
  String get problem_connecting_to_the_server {
    return Intl.message(
      'Problem connecting to the server. Please try again',
      name: 'problem_connecting_to_the_server',
      desc: '',
      args: [],
    );
  }

  /// `С вашей помощью мы\nделаем логистику лучше.`
  String get with_your_help_were_doing_logistics_better {
    return Intl.message(
      'С вашей помощью мы\nделаем логистику лучше.',
      name: 'with_your_help_were_doing_logistics_better',
      desc: '',
      args: [],
    );
  }

  /// `Регистрация`
  String get registration {
    return Intl.message(
      'Регистрация',
      name: 'registration',
      desc: '',
      args: [],
    );
  }

  /// `Вход`
  String get enter {
    return Intl.message(
      'Вход',
      name: 'enter',
      desc: '',
      args: [],
    );
  }

  /// `Используя это приложение вы соглашаетесь с `
  String get policy_title {
    return Intl.message(
      'Используя это приложение вы соглашаетесь с ',
      name: 'policy_title',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms of Use`
  String get terms_of_use {
    return Intl.message(
      'Terms of Use',
      name: 'terms_of_use',
      desc: '',
      args: [],
    );
  }

  /// `Войдите в `
  String get enter_to {
    return Intl.message(
      'Войдите в ',
      name: 'enter_to',
      desc: '',
      args: [],
    );
  }

  /// `Satti`
  String get satti {
    return Intl.message(
      'Satti',
      name: 'satti',
      desc: '',
      args: [],
    );
  }

  /// `Введите SMS код подтверждения`
  String get enter_sms_code {
    return Intl.message(
      'Введите SMS код подтверждения',
      name: 'enter_sms_code',
      desc: '',
      args: [],
    );
  }

  /// `Сообщение отправлено на номер {phoneNumber}`
  String code_send_to(Object phoneNumber) {
    return Intl.message(
      'Сообщение отправлено на номер $phoneNumber',
      name: 'code_send_to',
      desc: '',
      args: [phoneNumber],
    );
  }

  /// `Сообщение можно переотправить через {timer}`
  String code_can_be_resend(Object timer) {
    return Intl.message(
      'Сообщение можно переотправить через $timer',
      name: 'code_can_be_resend',
      desc: '',
      args: [timer],
    );
  }

  /// `Номер телефона`
  String get phone_number {
    return Intl.message(
      'Номер телефона',
      name: 'phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Не менее 8 символов`
  String get less_than_8_symbols {
    return Intl.message(
      'Не менее 8 символов',
      name: 'less_than_8_symbols',
      desc: '',
      args: [],
    );
  }

  /// `Повторите пароль`
  String get repeat_password {
    return Intl.message(
      'Повторите пароль',
      name: 'repeat_password',
      desc: '',
      args: [],
    );
  }

  /// `Придумайте пароль`
  String get create_password {
    return Intl.message(
      'Придумайте пароль',
      name: 'create_password',
      desc: '',
      args: [],
    );
  }

  /// `Введите свой номер телефона`
  String get enter_phone_number {
    return Intl.message(
      'Введите свой номер телефона',
      name: 'enter_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Введите номер телефона корректно`
  String get enter_phone_correctly {
    return Intl.message(
      'Введите номер телефона корректно',
      name: 'enter_phone_correctly',
      desc: '',
      args: [],
    );
  }

  /// `Пароль`
  String get password {
    return Intl.message(
      'Пароль',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Окей`
  String get okay {
    return Intl.message(
      'Окей',
      name: 'okay',
      desc: '',
      args: [],
    );
  }

  /// `Далее`
  String get next {
    return Intl.message(
      'Далее',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Проверьте ввод`
  String get inputErrorGeneral {
    return Intl.message(
      'Проверьте ввод',
      name: 'inputErrorGeneral',
      desc: '',
      args: [],
    );
  }

  /// `Пароли не совпадают`
  String get passwordNotMatching {
    return Intl.message(
      'Пароли не совпадают',
      name: 'passwordNotMatching',
      desc: '',
      args: [],
    );
  }

  /// `Реферальный код`
  String get referalCode {
    return Intl.message(
      'Реферальный код',
      name: 'referalCode',
      desc: '',
      args: [],
    );
  }

  /// `Например: AQN43653876`
  String get referalCodeExample {
    return Intl.message(
      'Например: AQN43653876',
      name: 'referalCodeExample',
      desc: '',
      args: [],
    );
  }

  /// `Зарегистрироваться`
  String get signUp {
    return Intl.message(
      'Зарегистрироваться',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `У меня нет реферального кода`
  String get iDontHaveReferalCode {
    return Intl.message(
      'У меня нет реферального кода',
      name: 'iDontHaveReferalCode',
      desc: '',
      args: [],
    );
  }

  /// `Ураа! Последний пункт`
  String get last_part {
    return Intl.message(
      'Ураа! Последний пункт',
      name: 'last_part',
      desc: '',
      args: [],
    );
  }

  /// ` - это личный код приглашения от вашего менеджера.`
  String get referal_code_dialog {
    return Intl.message(
      ' - это личный код приглашения от вашего менеджера.',
      name: 'referal_code_dialog',
      desc: '',
      args: [],
    );
  }

  /// `Понятно`
  String get understandably {
    return Intl.message(
      'Понятно',
      name: 'understandably',
      desc: '',
      args: [],
    );
  }

  /// `Поле не должно быть пустым!`
  String get fill_field {
    return Intl.message(
      'Поле не должно быть пустым!',
      name: 'fill_field',
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
