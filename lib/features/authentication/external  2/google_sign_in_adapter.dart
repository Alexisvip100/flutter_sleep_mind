import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sleep_mind/features/authentication/domain/entities/auth_service.dart';
import 'package:sleep_mind/features/authentication/external%20/firebase_auth_adapter.dart';


class GoogleAuthAdapter {
  final FirebaseAuthPort _fb;

  GoogleAuthAdapter(this._fb);

  Future<AuthUser?> signIn() async {
    if (kIsWeb) {
      final provider = fb.GoogleAuthProvider()
        ..addScope('email')
        ..addScope('profile');
      await _fb.signInWithProvider(provider);
      return _fb.current;
    } else {
      final google = GoogleSignIn(scopes: ['email', 'profile']);
      final account = await google.signIn();
      if (account == null) return null;

      final auth = await account.authentication;
      final credential = fb.GoogleAuthProvider.credential(
        idToken: auth.idToken,
        accessToken: auth.accessToken,
      );
      await _fb.signInWithCredential(credential);
      return _fb.current;
    }
  }

  Future<void> signOut() async {
    await _fb.signOut();
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
  }

  Stream<AuthUser?> authStateChanges() => _fb.authStates();

  AuthUser? get currentUser => _fb.current;
}