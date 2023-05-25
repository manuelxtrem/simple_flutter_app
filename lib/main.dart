import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:simple_flutter_app/bloc/auth_bloc.dart';
import 'package:simple_flutter_app/bloc/wallet_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/res/user_settings.dart';
import 'package:simple_flutter_app/service_locator.dart';
import 'package:simple_flutter_app/views/commons/dialogs.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';
import 'package:simple_flutter_app/views/screens/dashboard.dart';
import 'package:simple_flutter_app/views/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late UserCache _userCache;
  late AuthBloc _authBloc;
  late WalletBloc _walletBloc;
  final sessionConfig = SessionConfig(
    invalidateSessionForAppLostFocus: const Duration(seconds: 15),
    invalidateSessionForUserInactivity: const Duration(seconds: 30),
  );

  @override
  void initState() {
    _userCache = sl();
    _authBloc = AuthBloc(_userCache);
    _walletBloc = WalletBloc(_userCache);

    sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
      if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
        _authBloc.add(UserActivityChangeAuthEvent());
      } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
        _authBloc.add(UserActivityChangeAuthEvent());
      }
    });

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
              BlocProvider<WalletBloc>.value(value: _walletBloc),
            ],
            child: MaterialApp(
              title: 'Simple Payment App',
              theme: ThemeData(
                primarySwatch: AppColors.primarySwatch,
                backgroundColor: Colors.grey.shade300,
              ),
              home: BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) async {
                  if (state is AuthLogoutSuccess) {
                    Dialogs.showSingleMessageDialog(context, message: state.message);
                  } else if(state is )
                },
                builder: (context, state) {
                  if (!_authBloc.isLoggedIn()) {
                    return const LoginEmailScreen();
                  }
                  return const DashboardScreen();
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
                  style: AppStyles.textHeadline2,
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
