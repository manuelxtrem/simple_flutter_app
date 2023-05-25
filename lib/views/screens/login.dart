import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/bloc/auth_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/dimens.dart';
import 'package:simple_flutter_app/res/enums.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/res/utils.dart';
import 'package:simple_flutter_app/views/commons/button.dart';
import 'package:simple_flutter_app/views/commons/dialogs.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';
import 'package:simple_flutter_app/views/commons/text_field.dart';
import 'package:simple_flutter_app/views/screens/signup.dart';

class LoginEmailScreen extends StatefulWidget {
  const LoginEmailScreen({super.key});

  @override
  State<LoginEmailScreen> createState() => _LoginEmailScreenState();
}

class _LoginEmailScreenState extends State<LoginEmailScreen> {
  late AuthBloc _authBloc;
  final _phoneFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authBloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        Utils.log('listener changing $state');
        if (state is AuthSignInSuccess) {
          Dialogs.showSingleMessageDialog(context, message: state.message, title: 'Successful');
        } else if (state is AuthSignInError) {
          Dialogs.showSingleMessageDialog(context, message: state.message, title: 'Oops!');
        }
      },
      builder: (context, state) {
        Utils.log('state changing $state');
        return Scaffold(
          backgroundColor: AppColors.windowBackground,
          body: LoadingOverlay(
            enabled: state is AuthLoading,
            message: (state is AuthLoading) ? state.message : null,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    Center(
                      child: Card(
                        shape: RoundedRectangleBorder(borderRadius: Dimens.circularBorderRadius),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: _detectForm(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextButton(
                      onPressed: () {
                        _authBloc.add(ChangeLoginModeAuthEvent());
                      },
                      child: Text(
                        "Sign in with ${_authBloc.signInType == SignInType.email ? 'phone' : 'email'}",
                        style: AppStyles.textBody4,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(Utils.pageRoute(const SignUpScreen()));
                      },
                      child: const Text('Register a new account', style: AppStyles.textBody4),
                    ),
                    TextButton(
                      onPressed: () {
                        // Navigator.of(context).push(Utils.pageRoute(const LoginPhoneScreen()));
                      },
                      child: const Text('Forgot my password', style: AppStyles.textBody4),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Form _detectForm() {
    if (_authBloc.signInType == SignInType.email) {
      return _emailForm();
    }
    return _phoneForm();
  }

  Form _emailForm() {
    return Form(
      key: _emailFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LOGIN WITH EMAIL',
            style: AppStyles.textTitle1.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: emailController,
            title: 'Email',
            inputType: TextInputType.emailAddress,
            validator: (val) {
              if (Utils.isEmptyOrNull(val) || !Utils.validateEmail(val)) {
                return 'Enter a valid email address';
              }
            },
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: passwordController,
            title: 'Password',
            isPassword: true,
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a password';
              }
              if (val.toString().length < 6) {
                return 'Password should be more than 6 characters';
              }
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            onPressed: () => _signInWithEmail(),
            text: 'Sign In',
          ),
        ],
      ),
    );
  }

  Form _phoneForm() {
    return Form(
      key: _phoneFormKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'LOGIN WITH PHONE',
            style: AppStyles.textTitle1.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: phoneController,
            title: 'Phone',
            inputType: TextInputType.phone,
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a valid phone number';
              }
            },
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: passwordController,
            title: 'Password',
            isPassword: true,
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a password';
              }
              if (val.toString().length < 6) {
                return 'Password should be more than 6 characters';
              }
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            onPressed: () => _signInWithPhone(),
            text: 'Sign In',
          ),
        ],
      ),
    );
  }

  _signInWithPhone() {
    if (_phoneFormKey.currentState?.validate() == true) {
      _authBloc.add(
        SignInAuthEvent(SignInType.msisdn, phoneController.text, passwordController.text),
      );
    }
  }

  _signInWithEmail() {
    if (_emailFormKey.currentState?.validate() == true) {
      _authBloc.add(
        SignInAuthEvent(SignInType.email, emailController.text, passwordController.text),
      );
    }
  }
}
