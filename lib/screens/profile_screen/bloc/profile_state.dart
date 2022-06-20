part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateError extends ProfileState {
  final AppError error;

  ProfileStateError({
    required this.error,
  });
}

class ProfileStateLoaded extends ProfileState {
  final ProfileResponse profile;

  ProfileStateLoaded({
    required this.profile,
  });
}
