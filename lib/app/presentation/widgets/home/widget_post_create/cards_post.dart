import 'package:flutter/material.dart';
import 'package:sleep_mind/app/domain/entities/models/post_user.dart';

class CardsPost extends StatefulWidget {
  final List<PostUser> posts;
  final int maxItems;
  final String title;
  final double topPadding;

  const CardsPost({
    super.key,
    required this.posts,
    this.maxItems = 4,         // ⬅️ máximo 4 elementos visibles
    this.title = 'Hábitos Recomendados',
    this.topPadding = 12,      // puedes poner 150 para despegar del header
  });

  @override
  State<CardsPost> createState() => _CardsPostState();
}

class _CardsPostState extends State<CardsPost> {
  // Inicializado desde la declaración: evita LateInitializationError tras hot reload
  final PageController _pageCtrl = PageController(viewportFraction: 0.86);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visiblePosts = widget.posts.take(widget.maxItems).toList();
    if (visiblePosts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: EdgeInsets.fromLTRB(16, widget.topPadding, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          // Título + Ver más
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              GestureDetector(
                onTap: () {
                  // TODO: Navegar a lista completa si lo deseas
                },
                child: const Text(
                  'Ver más',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Carrusel
          SizedBox(
            height: 140,
            child: PageView.builder(
              controller: _pageCtrl,
              physics: const BouncingScrollPhysics(),
              itemCount: visiblePosts.length,
              onPageChanged: (i) => setState(() => _currentPage = i),
              itemBuilder: (context, index) {
                final post = visiblePosts[index];
                final isCurrent = index == _currentPage;

                return AnimatedScale(
                  scale: isCurrent ? 1.0 : 0.96,
                  duration: const Duration(milliseconds: 220),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2,),
                    child: Card(
                      color: const Color.fromARGB(0, 0, 0, 0).withOpacity(0.58),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                post.content,
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Tipo: ${post.type}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              visiblePosts.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                height: 6,
                width: i == _currentPage ? 18 : 6,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(i == _currentPage ? 0.9 : 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
