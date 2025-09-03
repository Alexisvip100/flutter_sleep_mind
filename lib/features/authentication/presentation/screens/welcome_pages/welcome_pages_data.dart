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
class WelcomePagesData {
  static const List<WelcomePageData> pages = [
    WelcomePageData(
      title: 'Hola 👋🏻',
      description: '🌙 Bienvenido a tu nuevo espacio de descanso. 🧘 Respira profundo. El sueño comienza aquí 😴',
    ),
    WelcomePageData(
      title: 'Tu descanzo es muy importante para nosotros 😴',
      description: 'Mejora tu descanso con sonidos relajantes, meditaciones y rutinas nocturnas. '
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
      title: "Conecta con miembros exptos en la sociedad",
      description: "Mas de 400 usuarios  han tenido un gran aumento de sueño con nuestra ayuda",
      background: '#142F4E',
    ),
    WelcomePageData(
      title: "Sigue tu rutina para alcanzar tus objetivos",
      titleListHours: {
        "11:15 pm":"Iniciaste tu etapa de sueño 😴", 
        "12:35 am":"Empezaste a roncar 🫣",
        "1:30 am": "Hablaste en sueños 👀",
        "6:30 am": "Te despertaste"
      },
    ),
  ];

  static const int overlayPagesStartIndex = 2;
  static bool isOverlayPage(int index) => index >= overlayPagesStartIndex;
}