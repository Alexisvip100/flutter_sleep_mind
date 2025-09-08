class WelcomePageData {
  final String? title;
  final String? description;
  final String? h1;
  final String? background;
  final String? img;
  final Map<String, String>? titleListHours;

  const WelcomePageData({
    this.title,
    this.description,
    this.h1,
    this.background,
    this.img,
    this.titleListHours,
  });
}

class LoginPageData {
  final String? textSleep;
  final String? imgGifs;
  final double? right;
  final double? left;

  const LoginPageData({
    required this.textSleep,
    required this.imgGifs,
    this.left,
    this.right,
  });

  // Datos para la página de login
  static const List<LoginPageData> listItems = [
    LoginPageData(
      textSleep: 'Habitos para dormir',
      imgGifs: 'assets/login_gifs/Panda_sleep.gif',
      right: 40.0,
      left: 0.0,
    ),
    LoginPageData(
      textSleep: 'Habitos Saludables',
      imgGifs: 'assets/login_gifs/list_purple.gif',
      right: 0.0,
      left: 0.0,
    ),
    LoginPageData(
      textSleep: 'Rutina Nocturna',
      imgGifs: 'assets/login_gifs/Notification_Bell.gif',
      right: 0.0,
      left: 70.0,
    ),
    LoginPageData(
      textSleep: 'Sonidos relajantes',
      imgGifs: 'assets/login_gifs/Sound_Waves.gif',
      right: 0.0,
      left: 0.0,
    ),
    LoginPageData(
      textSleep: 'Recomendaciones por expertos',
      imgGifs: 'assets/login_gifs/list_purple.gif',
      right: 40.0,
      left: 0.0,
    ),
  ];
}

class WelcomePagesData {
  static const List<WelcomePageData> pages = [
    WelcomePageData(
      title: 'Hola 👋🏻',
      description:
          '🌙 Bienvenido a tu nuevo espacio de descanso. 🧘 Respira profundo. El sueño comienza aquí 😴',
    ),
    WelcomePageData(
      title: 'Tu descanzo es muy importante para nosotros 😴',
      description:
          'Mejora tu descanso con sonidos relajantes, meditaciones y rutinas nocturnas. '
          'Reduce el estrés, concilia el sueño más rápido y despierta con más energía.',
    ),
    WelcomePageData(
      h1: "SleepMind",
      title: "Clap your hands to stop the music songs",
      description: "Stop the song when you want before go to sleep 😴",
      background: '#142F4E',
    ),
    WelcomePageData(
      h1: "SleepMind",
      title: "Conecta con miembros expertos en la sociedad",
      description:
          "Más de 400 usuarios han tenido un gran aumento de sueño con nuestra ayuda",
      background: '#142F4E',
    ),
    WelcomePageData(
      title: "Sigue tu rutina para alcanzar tus objetivos",
      titleListHours: {
        "11:15 pm": "Iniciaste tu etapa de sueño 😴",
        "12:35 am": "Empezaste a roncar 🫣",
        "1:30 am": "Hablaste en sueños 👀",
        "6:30 am": "Te despertaste",
      },
    ),
  ];

  static const int overlayPagesStartIndex = 2;
  static bool isOverlayPage(int index) => index >= overlayPagesStartIndex;
}
