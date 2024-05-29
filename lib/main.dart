import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kudosware_assignment/src/blocs/auth/auth_bloc.dart';
import 'package:kudosware_assignment/src/repositories/auth_repository.dart';
import 'package:kudosware_assignment/src/repositories/firestore_repository.dart';
import 'package:kudosware_assignment/src/screens/home_screen.dart';
import 'package:kudosware_assignment/src/screens/login_screen.dart';
import 'package:kudosware_assignment/src/screens/signup_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthRepository>(
          create: (_) => AuthRepository(firebaseAuth: FirebaseAuth.instance),
        ),
        Provider<FirestoreRepository>(
          create: (_) => FirestoreRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            )..add(AuthStarted()),
          ),
        ],
        child: MaterialApp(
          title: 'Student Management App',
          theme: ThemeData(scaffoldBackgroundColor: Colors.black),
          initialRoute: '/',
          routes: {
            '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthAuthenticated) {
                      return HomeScreen();
                    } else if (state is AuthUnauthenticated) {
                      return LoginScreen();
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
            '/signup': (context) => SignUpScreen(),
            '/login': (context) => LoginScreen(),
            '/home': (context) => HomeScreen(),
          },
        ),
      ),
    );
  }
}
