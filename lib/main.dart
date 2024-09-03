import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mind_labify/features/admin/admin_bloc/admin_bloc.dart';
import 'package:mind_labify/features/admin/views/sub_features/dashboard/views/admin_dashboard.dart';
import 'package:mind_labify/features/authentication/bloc/authentication_bloc.dart';
import 'package:mind_labify/features/authentication/views/login_screen.dart';
import 'package:mind_labify/features/authentication/views/sub_features/onboarding/views/onboarding_screen.dart';
import 'package:mind_labify/features/user/user_bloc/user_bloc.dart';
import 'package:mind_labify/features/user/views/age_screen.dart';
import 'package:mind_labify/features/user/views/gender_screen.dart';
import 'package:mind_labify/features/user/views/sub_features/select_mood/views/select_mood.dart';
import 'package:mind_labify/firebase_options.dart';
import 'package:mind_labify/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

late final SharedPreferences prefs;
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String age = prefs.getString('age') ?? '';
    String gender = prefs.getString('gender') ?? '';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => UserBloc()
            ..add(
              LoadBreathworkWatchedVideo(),
            ),
        ),
        BlocProvider(
          create: (context) => AdminBloc(),
        ),
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (context) => UserProvider(),
          ),
        ],
        child: MaterialApp(
          title: 'Mind Labify',
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: const ColorScheme.light(
              surface: Color(0xFFF4F2E9),
              onSurface: Color(0xFF2B2B2B),
              primary: Color(0xFFC6B728),
              secondary: Color(0xFFC0BA59),
            ),
          ),
          home: FirebaseAuth.instance.currentUser == null
              ? kIsWeb
                  ? const LoginScreen()
                  : const OnboardingScreen()
              : kIsWeb
                  ? const AdminDashboard()
                  : age.isEmpty
                      ? const AgeScreen()
                      : gender.isEmpty
                          ? const GenderScreen()
                          : const SelectMoodScreen(),
        ),
      ),
    );
  }
}
