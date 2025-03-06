import 'package:flutter/material.dart';
import 'package:midilink/app.dart';
import 'package:midilink/features/authentication/screens/login/widgets/login_form.dart';
import 'package:midilink/features/authentication/screens/login/widgets/login_header.dart';

import '../../../../common/styles/spacing_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log in"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [

              // Login form
              TLoginForm(),
            ],
          ),
        ),
      ),
    );
  }
}
