import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'phone_auth__state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  late String verificationId;

  PhoneAuthCubit() : super(PhoneAuthInitial());

  Future<void> submitPhoneNumber(String phoneNumber) async {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationComplete,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationComplete(PhoneAuthCredential credential) async {
    print('verification completed');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) {
    print('verification failed : ${error.toString()}');
    emit(ErrorOccurred(errorMsg: error.toString()));
  }

  void codeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    print('codeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    try{
      await FirebaseAuth.instance.signInWithCredential(credential);
      emit(PhoneOtpVerified());
    }catch(error){
      emit(ErrorOccurred(errorMsg: error.toString()));
    }
  }

  Future<void> logout() async{
    await FirebaseAuth.instance.signOut();
  }
  User getLoggedOut(){
    User fireBaseUser=FirebaseAuth.instance.currentUser!;
    return fireBaseUser;
  }

}

