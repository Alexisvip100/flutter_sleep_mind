import 'package:flutter/material.dart';
import 'package:sleep_mind/app/domain/usecases/posts_state_changes.dart';
import 'package:sleep_mind/app/injection/di.dart';
import 'package:sleep_mind/app/domain/entities/models/auth_service.dart';
import 'package:sleep_mind/app/domain/entities/models/post_user.dart';
import 'package:sleep_mind/app/domain/usecases/auth_state_changes.dart';
import 'package:sleep_mind/app/presentation/widgets/home/widget_post_create/cards_post.dart';
import 'package:sleep_mind/app/presentation/widgets/home/widget_post_create/post_create.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _authStates = sl<AuthStateChanges>();
  final _postsStates = sl<PostsStateChanges>();

  @override
  void initState() {
    super.initState();
    _postsStates.loadPosts(); // Cargar posts al iniciar
  }

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
              // Fondo
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
              // Contenido
              SafeArea(
                child: Column(
                  children: [
                    // Encabezado
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Texto Bienvenida (seguro con .last)
                          Text(
                            'Good Night ${user.name.toString().split(' ').last}',
                            softWrap: true,
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
                          // Íconos
                          Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.19),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.add,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return const PostCreate();
                                      },
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 10.0),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(0, 0, 0, 0.19),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.notifications,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                  onPressed: () {
                                    // acción notificación
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // StreamBuilder para los posts
                    Expanded(
                      child: StreamBuilder<List<PostUser>>(
                        stream: _postsStates(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            );
                          }

                          if (snapshot.hasError) {
                            return Center(
                              child: Text(
                                'Error: ${snapshot.error}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }

                          final posts = snapshot.data ?? [];
                          if (posts.isEmpty) {
                            return const Center(
                              child: Text(
                                'No hay posts disponibles',
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          return CardsPost(
                            posts: posts,
                            title: 'Hábitos Recomendados',
                            topPadding: 150,
                          );
                        },
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
