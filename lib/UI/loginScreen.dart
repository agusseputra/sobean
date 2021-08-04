import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:sobean/Model/errormsg.dart';
import 'package:sobean/Service/api.dart';
import 'package:sobean/UI/PPL/home.dart';

const users = const {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginScreen extends StatelessWidget {
  static var routeName="login";
  late ErrorMSG res;
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String> _authUser(LoginData data) {
    //print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      var params =  {
        'email':data.name,
        'password':data.password,
        'device_name':'flutterMobile'
      };
      res=await ApiService.sigIn(params);
      if (res.success!=true) {
        return res.message;
      }
      return '';
    });
  }

  Future<String> _recoverPassword(String name) {
    print('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'SIPROTANI',
      logo: 'assets/images/figure.png',
      onLogin: _authUser,
      onSignup: _authUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Home(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}