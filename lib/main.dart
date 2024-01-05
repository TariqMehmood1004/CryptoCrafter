import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:trading_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:trading_app/screens/admin/home_screen/admin_home_screen.dart';
import 'package:trading_app/screens/admin_login.dart';
import 'package:trading_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoCraft',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CryptoCraft'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isAdminLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      if (_user != null) {
        _isAdminLoggedIn = true;
      } else {
        _isAdminLoggedIn = false;
      }
      navigateToScreen();
    });
  }

  void navigateToScreen() {
    if (_isAdminLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminHomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const AdminLogin()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const SplashScreen(),
    );
  }
}
