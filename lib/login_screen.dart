import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'constants.dart';
import 'custom_route.dart';
import 'dashboard_screen.dart';
import 'users.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = '/auth';

  const LoginScreen({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  LoginMessages lLoginMessages(BuildContext context) {
    return LoginMessages(
        userHint:AppLocalizations.of(context)!.userHint,
        passwordHint:AppLocalizations.of(context)!.passwordHint,
        confirmPasswordHint:AppLocalizations.of(context)!.confirmPasswordHint,
        forgotPasswordButton:AppLocalizations.of(context)!.forgotPasswordButton,
        loginButton: AppLocalizations.of(context)!.loginButton,
        signupButton: AppLocalizations.of(context)!.signupButton,
        recoverPasswordButton:AppLocalizations.of(context)!.recoverPasswordButton,
        recoverPasswordIntro:AppLocalizations.of(context)!.recoverPasswordIntro,
        recoverPasswordDescription:AppLocalizations.of(context)!.recoverPasswordDescription,
        goBackButton:AppLocalizations.of(context)!.goBackButton,
        confirmPasswordError:AppLocalizations.of(context)!.confirmPasswordError,
        recoverPasswordSuccess:AppLocalizations.of(context)!.confirmPasswordError,
        flushbarTitleError:AppLocalizations.of(context)!.flushbarTitleError,
        flushbarTitleSuccess:AppLocalizations.of(context)!.flushbarTitleSuccess,
        providersTitle:AppLocalizations.of(context)!.providersTitle
      );
  }  

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: AppLocalizations.of(context)!.title,
      logo: 'assets/images/gbricon.png',
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      messages: lLoginMessages(context),
      userValidator: (value) {
        if (!value!.contains('@') || !value.endsWith('.com')) {
          return "Email must contain '@' and end with '.com'";
        }
        return null;
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) {
        print('Login info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSignup: (loginData) {
        print('Signup info');
        print('Name: ${loginData.name}');
        print('Password: ${loginData.password}');
        return _loginUser(loginData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => DashboardScreen(),
        ));
      },
      onRecoverPassword: (name) {
        print('Recover password info');
        print('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}
