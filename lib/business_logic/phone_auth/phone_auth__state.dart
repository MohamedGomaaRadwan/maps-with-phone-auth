part of 'phone_auth__cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState{}

class ErrorOccurred extends PhoneAuthState{
  late final String errorMsg;

  ErrorOccurred({required this.errorMsg});

}
class PhoneNumberSubmited extends PhoneAuthState{}

class PhoneOtpVerified extends PhoneAuthState{}
