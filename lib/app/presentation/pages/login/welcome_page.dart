import 'package:flutter/material.dart';
import 'step_cards.dart';
import 'title_line_tile.dart';
import 'welcome_pages_data.dart';
import 'welcome_page_images.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _c;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _isPageChanging = false;

  final List<WelcomePageData> _pages = WelcomePagesData.pages;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    );
    _fade = CurvedAnimation(parent: _c, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.09),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _c, curve: Curves.easeOutCubic));

    // Precargar imágenes para mejor rendimiento
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        WelcomePageImages.preloadImages(context);
      }
    });

    // Iniciar animación después de un breve delay
    Future.delayed(
      const Duration(milliseconds: 250),
      _c.forward,
    );
  }

  @override
  void dispose() {
    _c.dispose();
    _pageController.dispose();
    _isPageChanging = false;
    super.dispose();
  }

  void _nextPage() {
    try {
      if (_currentPage < _pages.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } else {
        Navigator.of(context).pushReplacementNamed('/login');
      }
    } catch (e) {
      // Log error silently or show user-friendly message
      debugPrint('Error navigating to next page: $e');
    }
  }

  bool get _isOverlayPage => WelcomePagesData.isOverlayPage(_currentPage);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackgroundLayer(),
        if (_currentPage == 2) _buildOverlayImagesForPage3(),
        if (_currentPage == 3) _buildOverlayImagesForPage4(),
        _buildForegroundContent(),
      ],
    );
  }

  // ---------- Fondo ----------
  Widget _buildBackgroundLayer() {
    final isTimeline = (_currentPage < _pages.length) &&
        (_pages[_currentPage].titleListHours != null &&
            _pages[_currentPage].titleListHours!.isNotEmpty);

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: (isTimeline || _currentPage == 2 || _currentPage == 3)
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment(0, 0.2),
                colors: [Color.fromARGB(255, 0, 0, 0), Color(0xFF142F4E)],
              )
            : null,
        image: (_currentPage == 2 || _currentPage == 3)
            ? null
            : const DecorationImage(
                image: AssetImage('assets/images/background.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
        color: (_currentPage == 2 || _currentPage == 3)
            ? const Color(0xFF142F4E)
            : null,
      ),
    );
  }

  // ---------- Overlays ----------
  Widget _buildOverlayImagesForPage3() {
    // Solo gradiente de color, sin imágenes
    return Positioned.fill(
      child: Stack(
        alignment: const Alignment(0, -0.83),
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Image.asset(
              'assets/images/points.png',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF142F4E),
                  child: const Center(
                    child: Icon(Icons.people, color: Colors.white54, size: 100),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            child: Image.asset(
              'assets/images/slap-hands.png',
              height: 400,
              width: 400,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOverlayImagesForPage4() {
    return Positioned.fill(
      child: Stack(
        alignment: const Alignment(0, -0.83),
        children: [
          SizedBox(
            height: 400,
            width: 400,
            child: Image.asset(
              'assets/images/points.png',
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF142F4E),
                  child: const Center(
                    child: Icon(Icons.people, color: Colors.white54, size: 100),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            child: Image.asset(
              'assets/images/team.png',
              height: 350,
              width: 350,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Contenido ----------
  Widget _buildForegroundContent() {
    return SafeArea(
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (mounted && !_isPageChanging) {
                      _isPageChanging = true;
                      setState(() => _currentPage = index);
                      Future.delayed(const Duration(milliseconds: 100), () {
                        if (mounted) _isPageChanging = false;
                      });
                    }
                  },
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    return _buildPageContent(_pages[index]);
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _pages.length,
                  (index) => _buildPageIndicator(index),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ---------- Lógica por tipo de página ----------
  Widget _buildPageContent(WelcomePageData pageData) {
    if (pageData.titleListHours != null && pageData.titleListHours!.isNotEmpty) {
      return _buildSleepStepsPage(pageData);
    }

    if (_isOverlayPage) {
      return Padding(
        padding: const EdgeInsets.only(top: 400.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                pageData.h1 ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                  decoration: TextDecoration.none,
                ),
                
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                pageData.title ?? '',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28.0,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                pageData.description ?? '',
                style: const TextStyle(
                  color: Color.fromARGB(174, 255, 255, 255),
                  fontSize: 16.0,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 50),
            _circleButton(
              icon: _currentPage == _pages.length - 1
                  ? Icons.check_rounded
                  : Icons.arrow_forward_rounded,
              onTap: _nextPage,
              size: 24.0,
            ),
          ],
        ),
      );
    }

    // Páginas normales
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            pageData.title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              decoration: TextDecoration.none,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Text(
            pageData.description ?? '',
            style: const TextStyle(
              color: Colors.white,
              decoration: TextDecoration.none,
              fontSize: 17.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(height: 50),
        _circleButton(
          icon: _currentPage == _pages.length - 1
              ? Icons.check_rounded
              : Icons.arrow_forward_rounded,
          onTap: _nextPage,
          size: 20.0,
        ),
      ],
    );
  }

  // ---------- Página de línea de tiempo ----------
  Widget _buildSleepStepsPage(WelcomePageData pageData) {
    final entries = pageData.titleListHours!.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpeg'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        Positioned(
          left: 16,
          right: 16,
          top: 230,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Sigue tu rutina para alcanzar tus objetivos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                decoration: TextDecoration.none,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 360, left: 10, right: 10),
            child: ListView.builder(
              itemCount: entries.length,
              itemBuilder: (context, i) {
                final time = entries[i].key;
                final text = entries[i].value;
                return TimelineTile(
                  time: time,
                  drawTopLine: i != 0,
                  drawBottomLine: i != entries.length - 1,
                  child: StepCard(text: text),
                );
              },
            ),
          ),
        ),
        Positioned(
          bottom: 32,
          left: 0,
          right: 0,
          child: _circleButton(
            icon: Icons.arrow_forward_rounded,
            onTap: _nextPage,
            size: 20.0,
          ),
        ),
      ],
    );
  }

  // ---------- Botón circular reutilizable ----------
  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
    required double size,
  }) {
    return GestureDetector(
      onTap: () {
        // Agregar un pequeño delay para la transición
        Future.delayed(const Duration(milliseconds: 50), onTap);
      },
      child: TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 150),
        tween: Tween(begin: 1.0, end: 1.0),
        builder: (context, scale, child) {
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(122, 156, 198, 1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                iconSize: size,
                color: Colors.white,
                icon: Icon(icon),
                onPressed: null, // Deshabilitamos el onPressed del IconButton
              ),
            ),
          );
        },
        onEnd: () {
          // Animación de retroceso cuando se suelta
          setState(() {});
        },
      ),
    );
  }

  // ---------- Indicadores ----------
  Widget _buildPageIndicator(int index) {
    final bool active = _currentPage == index;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      width: active ? 12 : 8,
      height: active ? 12 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.white : Colors.white.withValues(alpha: 0.5),
        shape: BoxShape.circle,
      ),
    );
  }
}