import 'package:flutter/material.dart';
import 'package:midilink/features/authentication/screens/login/widgets/login_form.dart';

import '../../../../common/styles/spacing_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Log in"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
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
