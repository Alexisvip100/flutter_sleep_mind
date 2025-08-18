import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _loading = false;

  Future<UserCredential?> login() async {
    setState(() => _loading = true);
    try {
      if (kIsWeb) {
        final provider = GoogleAuthProvider()
          ..addScope('email')
          ..addScope('profile');
        final userCred = await FirebaseAuth.instance.signInWithPopup(provider);
        return userCred;
      } else {
        // 🔹 ANDROID / iOS: usa google_sign_in
        final google = GoogleSignIn(
          scopes: ['email', 'profile'],
        );

        final GoogleSignInAccount? googleUser = await google.signIn();
        if (googleUser == null) return null; // usuario canceló

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, // ⚠️ accessToken ya no existe en v7.x
        );

        return await FirebaseAuth.instance.signInWithCredential(credential);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return null;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Auth error: ${e.code}')),
      );
      return null;
    } catch (e) {
      return null;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    if (!kIsWeb) {
      await GoogleSignIn().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Google Login')),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (user != null) ...[
                    if (user.photoURL != null)
                      CircleAvatar(
                        radius: 32,
                        backgroundImage: NetworkImage(user.photoURL!),
                      ),
                    const SizedBox(height: 12),
                    Text(user.displayName ?? 'Sin nombre'),
                    Text(user.email ?? ''),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: logout,
                      icon: const Icon(Icons.logout),
                      label: const Text('Cerrar sesión'),
                    ),
                  ] else ...[
                    ElevatedButton.icon(
                      onPressed: login,
                      icon: const Icon(Icons.login),
                      label: const Text('Iniciar sesión con Google'),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}