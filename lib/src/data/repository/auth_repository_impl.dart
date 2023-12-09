import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../domain/entity/user_response_entity.dart';
import '../../domain/repository/auth_repository.dart';
import '../datasource/remote/auth_remote_datasource.dart';
import '../model/register_user_request_model.dart';
import '../model/user_response_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  const AuthRepositoryImpl({required this.remoteDatasource});

  @override
  String? getCurrentSignInEmail() {
    return FirebaseAuth.instance.currentUser?.email;
  }

  @override
  Future<UserDataEntity?> getUserByEmail({required String email}) async {
    UserResponseModel? userModel =
        await remoteDatasource.getUserByEmail(email: email);
    if (userModel != null) {
      print('userModel: ${userModel.toJson()}');
      final data = UserDataEntity(
        iduser: userModel.data?.iduser ?? '',
        userName: userModel.data?.userName ?? '',
        userEmail: userModel.data?.userEmail ?? '',
        userFoto: userModel.data?.userFoto ?? '',
        userAsalSekolah: userModel.data?.userAsalSekolah ?? '',
        dateCreate: userModel.data?.dateCreate ?? '',
        jenjang: userModel.data?.jenjang ?? '',
        userGender: userModel.data?.userGender ?? '',
        userStatus: userModel.data?.userStatus ?? '',
      );
      return data;
    }
    return null;
  }

  @override
  bool isSignInWithGoogle() {
    return getCurrentSignInEmail() != null;
  }

  @override
  Future<bool> isUserRegistered() async {
    bool isRegistered =
        await getUserByEmail(email: getCurrentSignInEmail() ?? '') != null;
    print('isRegistered: $isRegistered');
    return true;
  }

  @override
  Future<bool> registerUser({required RegisterUserRequestModel request}) async {
    final response = await remoteDatasource.registerUser(request: request);

    if (response.message == 'ok') {
      return true;
    }

    return false;
  }

  @override
  Future<bool> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('Error signInWithGoogle: $e, $stackTrace');
      }
      return false;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      UserCredential userCredentialResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      return userCredentialResult.user;
    } catch (e) {
      debugPrint('Err signInWithGoogle $e');
      return null;
    }
  }
}
