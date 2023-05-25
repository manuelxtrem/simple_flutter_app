import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:simple_flutter_app/bloc/auth_bloc.dart';
import 'package:simple_flutter_app/firebase_options.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/res/user_settings.dart';
import 'package:simple_flutter_app/service_locator.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';
import 'package:simple_flutter_app/views/home.dart';
import 'package:simple_flutter_app/views/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initServices();
  runApp(Phoenix(
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserCache _userSettings;
  late AuthBloc _authBloc;

  @override
  void initState() {
    _userSettings = sl();
    _authBloc = AuthBloc(_userSettings);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
        future: _init(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SplashScreen();
          }
          return MultiBlocProvider(
            providers: [
              BlocProvider<AuthBloc>.value(value: _authBloc),
            ],
            child: MaterialApp(
              title: 'Simple Payment App',
              theme: ThemeData(
                primarySwatch: AppColors.primarySwatch,
                backgroundColor: Colors.grey.shade300,
              ),
              home: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {},
                builder: (context, state) {
                  if (!_authBloc.isLoggedIn()) {
                    return const LoginEmailScreen();
                  }
                  return const HomeScreen();
                },
              ),
            ),
          );
        });
  }

  Future<bool> _init() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    return true;
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Payment App',
      theme: ThemeData(
        primarySwatch: AppColors.primarySwatch,
      ),
      color: Colors.white,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  'Simple Payment App',
                  style: AppStyles.textHeadline1,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                LoadingWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
