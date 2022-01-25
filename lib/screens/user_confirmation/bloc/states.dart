part of 'bloc_verification.dart';

abstract class StateBlocVerification {
  const StateBlocVerification();
}

class StateVerificationInitial extends StateBlocVerification {}

class StateVerificationFirstStep extends StateBlocVerification {}

class StateVerificationSecondStep extends StateBlocVerification {
  final List<String>? idImages;

  StateVerificationSecondStep({
    this.idImages,
  });
}

class StateVerificationThirdStep extends StateBlocVerification {}

class StateVerificationFourthStep extends StateBlocVerification {}
