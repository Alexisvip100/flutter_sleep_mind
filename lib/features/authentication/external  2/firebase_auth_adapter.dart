import 'package:firebase_auth/firebase_auth.dart' as fb;
import 'package:sleep_mind/features/authentication/domain/entities/auth_service.dart';

AuthUser? _mapFbUser(fb.User? u) {
  if (u == null) return null;
  return AuthUser(
    user_id: u.uid,
    name: u.displayName,
    email: u.email,
    avatar: u.photoURL, 
    is_premium: false,
    background_image: null,
  );
}

class FirebaseAuthPort {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Stream<AuthUser?> authStates() => _auth.authStateChanges().map(_mapFbUser);

  AuthUser? get current => _mapFbUser(_auth.currentUser);

  Future<void> signOut() => _auth.signOut();

  Future<fb.UserCredential> signInWithCredential(fb.AuthCredential c) =>
      _auth.signInWithCredential(c);

  Future<fb.UserCredential> signInWithProvider(fb.AuthProvider p) =>
      _auth.signInWithPopup(p);
}