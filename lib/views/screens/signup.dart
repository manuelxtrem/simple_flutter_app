import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_flutter_app/bloc/auth_bloc.dart';
import 'package:simple_flutter_app/res/colors.dart';
import 'package:simple_flutter_app/res/dimens.dart';
import 'package:simple_flutter_app/res/styles.dart';
import 'package:simple_flutter_app/res/utils.dart';
import 'package:simple_flutter_app/views/commons/button.dart';
import 'package:simple_flutter_app/views/commons/dialogs.dart';
import 'package:simple_flutter_app/views/commons/loading.dart';
import 'package:simple_flutter_app/views/commons/text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late AuthBloc _authBloc;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController countryCodeController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _authBloc = context.read<AuthBloc>();

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        Utils.log('listener changing $state');
        if (state is AuthSignUpSuccess) {
          Dialogs.showSingleMessageDialog(context, message: state.message, title: 'Successful');
        } else if (state is AuthSignUpError) {
          Dialogs.showSingleMessageDialog(context, message: state.message, title: 'Oops!');
        }
      },
      builder: (context, state) {
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
                          child: _getForm(),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(Utils.pageRoute(const SignUpScreen()));
                      },
                      child: const Text('Back to Login', style: AppStyles.textBody4),
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

  Form _getForm() {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'REGISTER AN ACCOUNT',
            style: AppStyles.textTitle1.copyWith(color: AppColors.textPrimaryLight),
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: firstNameController,
            title: 'First Name',
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a valid name';
              }
            },
          ),
          const SizedBox(height: 10),
          AppTextField(
            controller: lastNameController,
            title: 'Last Name',
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a valid name';
              }
            },
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
            controller: phoneNumberController,
            title: 'Phone Number',
            inputType: TextInputType.phone,
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
          const SizedBox(height: 10),
          AppTextField(
            controller: passwordController,
            title: 'Confirm Password',
            isPassword: true,
            validator: (val) {
              if (Utils.isEmptyOrNull(val)) {
                return 'Enter a password';
              }
              if (val.toString().length < 6) {
                return 'Password should be more than 6 characters';
              }
              if (val != passwordController.text) {
                return 'Both passwords should be the same';
              }
            },
          ),
          const SizedBox(height: 20),
          AppButton(
            onPressed: () => _signUp(),
            text: 'Register',
          ),
        ],
      ),
    );
  }

  _signUp() {
    if (_formKey.currentState?.validate() == true) {
      _authBloc.add(
        SignUpAuthEvent(
          firstName: firstNameController.text,
          lastName: lastNameController.text,
          email: emailController.text,
          msisdn: phoneNumberController.text,
          countryCode: countryCodeController.text,
          password: passwordController.text,
        ),
      );
    }
  }
}
