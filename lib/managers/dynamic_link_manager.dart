import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

typedef OnSuccessCallback = Future<dynamic> Function(
    PendingDynamicLinkData? dynamicLink);
typedef OnErrorCallback = Future<dynamic> Function(
    OnLinkErrorException onError);

class DynamicLinkManager {
  void onLink(OnSuccessCallback onSuccess, OnErrorCallback onError) async {
    FirebaseDynamicLinks.instance.onLink(
      onSuccess: onSuccess,
      onError: onError,
    );
  }
}

class CodeStore {
  String? attachCode;
  String? attachEmail;
  String? confirmationCode;
  String? confirmationEmail;

  CodeStore(
      {this.attachCode,
      this.confirmationCode,
      this.attachEmail,
      this.confirmationEmail});

  @override
  bool operator ==(Object? other) {
    return other != null &&
        other is CodeStore &&
        this.attachCode == other.attachCode &&
        this.attachEmail == other.attachEmail &&
        this.confirmationCode == other.confirmationCode &&
        this.confirmationEmail == other.confirmationEmail;
  }

  @override
  int get hashCode => hashValues(
        attachCode.hashCode,
        attachEmail.hashCode,
        confirmationCode.hashCode,
        confirmationEmail.hashCode,
      );
}
