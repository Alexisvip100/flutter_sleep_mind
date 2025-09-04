import 'package:flutter/material.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';
import 'package:sleep_mind/app/domain/usecases/sign_in_with_google.dart';
import 'package:sleep_mind/app/domain/usecases/sign_out.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _signIn = sl<SignInWithGoogle>();
  final _signOut = sl<SignOut>();
  final _authStates = sl<AuthStateChanges>();
  bool _loading = false;

  Future<void> _goHome() async {
    if (!mounted) return;
    Navigator.of(context).pushReplacementNamed('/home');
  }

  Future<void> _login() async {
    setState(() => _loading = true);
    try {
      final user = await _signIn();
      if (user != null) _goHome();
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error al iniciar sesión')),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _logout() async => _signOut();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, 0.2),
            colors: [Color.fromARGB(255, 0, 0, 0), Color(0xFF142F4E)],
          ),
        ),
        child: Column(
          children: [
            // points.png arriba
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/points.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // login abajo + escucha de sesión
            Expanded(
              child: Center(
                child: _loading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : StreamBuilder<AuthUser?>(
                        stream: _authStates(),
                        builder: (context, snap) {
                          final user = snap.data;
                          if (user != null) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (user.avatar != null)
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(user.avatar!),
                                  ),
                                const SizedBox(height: 12),
                                Text(user.name ?? 'Sin nombre',
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                Text(user.email ?? '',
                                    style:
                                        const TextStyle(color: Colors.white70)),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  onPressed: _logout,
                                  icon: const Icon(Icons.logout),
                                  label: const Text('Cerrar sesión'),
                                ),
                                ElevatedButton.icon(
                                  onPressed: _goHome,
                                  icon: const Icon(Icons.arrow_forward_rounded),
                                  label: const Text('Ir a Home'),
                                ),
                              ],
                            );
                          }
                          return ElevatedButton.icon(
                            onPressed: _login,
                            icon: const Icon(Icons.login),
                            label: const Text('Iniciar sesión con Google'),
                          );
                        },
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}