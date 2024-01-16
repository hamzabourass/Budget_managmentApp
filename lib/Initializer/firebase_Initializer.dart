import 'package:firebase_core/firebase_core.dart';

class FirebaseInitializer {
  static Future<void> initializeFirebase() async {
    const FirebaseOptions firebaseOptions = FirebaseOptions(
      apiKey: "AIzaSyBI0BJU-jap-o2P4nVfBKhlRruAHBY3Yqw",
      authDomain: "application-44b49.firebaseapp.com",
      projectId: "application-44b49",
      storageBucket: "application-44b49.appspot.com",
      appId: "1:991383950453:android:334d87afd3df74e3e9543c",
      messagingSenderId: 's',
    );

    await Firebase.initializeApp(options: firebaseOptions);
  }
}
