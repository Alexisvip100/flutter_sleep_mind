# 💤 SleepMind (Flutter + Firebase)

SleepMind es una aplicación Flutter que integra **Firebase** para autenticación con Google y muestra una **pantalla personalizada con fondo**.  

---

## 🚀 Tecnologías utilizadas
- [Flutter](https://flutter.dev/) (con Material 3)
- [Firebase Core](https://pub.dev/packages/firebase_core)
- [Firebase Auth](https://pub.dev/packages/firebase_auth)
- [Google Sign In](https://pub.dev/packages/google_sign_in)
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) *(opcional, para variables de entorno)*
- **Assets locales** (para fondos de pantalla e imágenes)

---

## 🔑 Configuración de Firebase
1. **Inicialización** en `main.dart`:

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}