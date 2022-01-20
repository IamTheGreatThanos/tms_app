// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(timer) => "Сообщение можно переотправить через ${timer}";

  static String m1(phoneNumber) =>
      "Сообщение отправлено на номер ${phoneNumber}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "code_can_be_resend": m0,
        "code_send_to": m1,
        "create_password":
            MessageLookupByLibrary.simpleMessage("Придумайте пароль"),
        "enter": MessageLookupByLibrary.simpleMessage("Вход"),
        "enter_phone_correctly": MessageLookupByLibrary.simpleMessage(
            "Введите номер телефона корректно"),
        "enter_phone_number":
            MessageLookupByLibrary.simpleMessage("Введите свой номер телефона"),
        "enter_sms_code": MessageLookupByLibrary.simpleMessage(
            "Введите SMS код подтверждения"),
        "enter_to": MessageLookupByLibrary.simpleMessage("Войдите в "),
        "fill_field":
            MessageLookupByLibrary.simpleMessage("Поле не должно быть пустым!"),
        "firebase_messaging_token":
            MessageLookupByLibrary.simpleMessage("Firebase messaging token"),
        "iDontHaveReferalCode": MessageLookupByLibrary.simpleMessage(
            "У меня нет реферального кода"),
        "inputErrorGeneral":
            MessageLookupByLibrary.simpleMessage("Проверьте ввод"),
        "last_part":
            MessageLookupByLibrary.simpleMessage("Ураа! Последний пункт"),
        "less_than_8_symbols":
            MessageLookupByLibrary.simpleMessage("Не менее 8 символов"),
        "message_contained_notification": MessageLookupByLibrary.simpleMessage(
            "Message also contained a notification"),
        "message_data": MessageLookupByLibrary.simpleMessage("Message data"),
        "next": MessageLookupByLibrary.simpleMessage("Далее"),
        "no_data": MessageLookupByLibrary.simpleMessage("No data"),
        "okay": MessageLookupByLibrary.simpleMessage("Окей"),
        "password": MessageLookupByLibrary.simpleMessage("Пароль"),
        "passwordNotMatching":
            MessageLookupByLibrary.simpleMessage("Пароли не совпадают"),
        "phone_number": MessageLookupByLibrary.simpleMessage("Номер телефона"),
        "policy_title": MessageLookupByLibrary.simpleMessage(
            "Используя это приложение вы соглашаетесь с "),
        "privacy_policy":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "problem_connecting_to_the_server":
            MessageLookupByLibrary.simpleMessage(
                "Problem connecting to the server. Please try again"),
        "push_foreground": MessageLookupByLibrary.simpleMessage(
            "Got a message whilst in the foreground!"),
        "referalCode": MessageLookupByLibrary.simpleMessage("Реферальный код"),
        "referalCodeExample":
            MessageLookupByLibrary.simpleMessage("Например: AQN43653876"),
        "referal_code_dialog": MessageLookupByLibrary.simpleMessage(
            " - это личный код приглашения от вашего менеджера."),
        "registration": MessageLookupByLibrary.simpleMessage("Регистрация"),
        "repeat_password":
            MessageLookupByLibrary.simpleMessage("Повторите пароль"),
        "satti": MessageLookupByLibrary.simpleMessage("Satti"),
        "server_is_not_reachable": MessageLookupByLibrary.simpleMessage(
            "Server is not reachable. Please verify your internet connection and try again"),
        "signUp": MessageLookupByLibrary.simpleMessage("Зарегистрироваться"),
        "terms_of_use": MessageLookupByLibrary.simpleMessage("Terms of Use"),
        "title": MessageLookupByLibrary.simpleMessage("Europharm"),
        "understandably": MessageLookupByLibrary.simpleMessage("Понятно"),
        "with_your_help_were_doing_logistics_better":
            MessageLookupByLibrary.simpleMessage(
                "С вашей помощью мы\nделаем логистику лучше.")
      };
}
