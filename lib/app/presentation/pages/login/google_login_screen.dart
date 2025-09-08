import 'package:flutter/material.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/usecases/sign_in_with_google.dart';
import 'package:sleep_mind/app/presentation/pages/login/welcome_pages_data.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _signIn = sl<SignInWithGoogle>();
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


  @override
  Widget build(BuildContext context) {
    const items = LoginPageData.listItems;

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0, 0.2),
            colors: [Color.fromARGB(255, 0, 0, 0), Color(0xFF142F4E)],
          ),
        ),
        child: Column(
          children: [
            // ================== STACK con background e ítems ==================
            SizedBox(
              height: 400,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Imagen de fondo
                  Container(
                    height: 400,
                    width: 400,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/points.png"),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),

                  // Todas las pages encima (sin PageView)
                  Positioned(
                    top: 40,
                    child: Column(
                      children: [
                        for (var item in items)
                          Container(
                            margin: EdgeInsets.only(
                              top: 10,
                              left: item.left ?? 0.0,
                              right: item.right ?? 0.0,
                            ),
                            width: 260,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                const SizedBox(width: 8),
                                Image.asset(
                                  item.imgGifs ?? '',
                                  width: 60,
                                  height: 60,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(
                                      Icons.nightlight_round,
                                      color: Colors.blue,
                                      size: 40,
                                    );
                                  },
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.textSleep ?? '',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              heightFactor: 2.0,
              child: Column(
                children: [
                  const Text(
                    'Iniciar Sesión',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _loading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : ElevatedButton.icon(
                          onPressed: _login,
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          label: const Text(
                            'Iniciar sesión con Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(
                              255,
                              255,
                              255,
                              255,
                            ),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                          ),
                        ),
                  const SizedBox(height: 16),

                  // Opcional: botón de logout si quieres mostrarlo aquí
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
