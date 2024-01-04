import 'package:flutter/material.dart';
import 'package:trading_app/screens/admin_login.dart';
import 'package:trading_app/screens/guest_mode.dart';
import 'package:trading_app/screens/user_login.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cryptographer'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/images/appstore.png',
                  width: 140,
                  height: 140,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Cryptographer is the ultimate cryptocurrency app. Get the latest news, prices, and analysis.',
                style: TextStyle(fontSize: 18, color: Colors.black38),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AdminLogin(),
                    ),
                  );
                },
                child: const Text('Admin Login'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserLogin(),
                    ),
                  );
                },
                child: const Text('User Login'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GuestMode(),
                    ),
                  );
                },
                child: const Text('Guest Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
