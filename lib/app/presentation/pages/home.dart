import 'package:flutter/material.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';
import 'package:sleep_mind/app/domain/usecases/sign_out.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authStates = sl<AuthStateChanges>();
  final _signOut = sl<SignOut>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AuthUser?>(
        stream: _authStates(),
        builder: (context, snapshot) {
          final user = snapshot.data;

          if (user == null) {
            return const Center(child: Text('No hay usuario autenticado'));
          }
          
          return Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background.jpeg'),
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ),
              // Welcome text at the top
              SafeArea(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                      child: Column(
                        children: [
                          Text(
                            'Bienvenido ${user.name ?? 'Usuario'}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 22,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Colors.black54,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            user.email ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              shadows: [
                                Shadow(
                                  offset: Offset(1, 1),
                                  blurRadius: 2,
                                  color: Colors.black54,
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
            ],
          );
        },
      ),
    );
  }
}
