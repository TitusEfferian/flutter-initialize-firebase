import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:initialize_firebase/Pages/Home/main.dart';
import 'package:provider/provider.dart';

class UserNotifier extends ChangeNotifier {
  bool isLoggedin = false;

  UserNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event == null) {
        isLoggedin = false;
      } else {
        isLoggedin = true;
      }
      notifyListeners();
    });
  }

  void login() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: 'tituseff@gmail.com', password: '123456');
  }

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }
}

class RealTime {
  final String message;

  RealTime(this.message);

  RealTime.fromJson(Map<String, dynamic>? json)
      : message = json!['message'];
}

class RealtimeNotifier extends ChangeNotifier {
  String data = '';
  RealtimeNotifier() {
    FirebaseFirestore.instance.collection('testing_realtime').doc('SYEuk1WJMgOEQbB4P0yW').snapshots().listen((event) {
      data = RealTime.fromJson(event.data()).message;
      notifyListeners();
    });
  }
}

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    runApp(MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (BuildContext context) => UserNotifier(),),
          ChangeNotifierProvider(create: (BuildContext context) => RealtimeNotifier()),
        ],
        child: const MyApp()));
  } catch (e) {
    // ignore: avoid_print
    print('error');
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => const Home(),
      },
    );
  }
}
