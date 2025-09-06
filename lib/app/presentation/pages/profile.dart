import 'package:flutter/material.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';
import 'package:sleep_mind/app/domain/usecases/sign_out.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _authStates = sl<AuthStateChanges>();
  final _signOut = sl<SignOut>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.jpeg'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: StreamBuilder<AuthUser?>(
          stream: _authStates(),
          builder: (context, snapshot) {
            final user = snapshot.data;

            if (user == null) {
              return const Center(
                child: Text(
                  'No hay usuario autenticado',
                  style: TextStyle(color: Colors.white),
                ),
              );
            }

            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: user.avatar != null 
                          ? NetworkImage(user.avatar!) 
                          : null,
                      child: user.avatar == null 
                          ? const Icon(Icons.person, size: 60, color: Colors.white)
                          : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name ?? 'Usuario',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      user.email ?? '',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _signOut();
                        if (mounted) {
                          Navigator.of(context).pushReplacementNamed('/');
                        }
                      },
                      icon: const Icon(Icons.logout),
                      label: const Text('Cerrar Sesión'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
