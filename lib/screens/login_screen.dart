import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone_flutter/screens/signup_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/global_variables.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';

import '../resources/auth_methods.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);


    if (res == 'Success Log In') {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout())));
    } else {
      showSnackBar(res, context);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void navigateToSignUp() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignupScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: MediaQuery.of(context).size.width > webScreenSize
          ? EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 3)
          : const EdgeInsets.symmetric(horizontal: 32),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(child: Container(), flex: 2),
          SvgPicture.asset(
            'assets/ic_instagram.svg',
            color: primaryColor,
            height: 64,
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
            textEditingController: _emailController,
            hintText: 'Enter Your Email',
            textInputType: TextInputType.emailAddress,
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            textEditingController: _passwordController,
            hintText: 'Enter Your Password',
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: loginUser,
            child: Container(
              child: _isLoading? const Center(child: CircularProgressIndicator(
                color: primaryColor,
              ),) : const Text("Log In"),
              width: double.infinity,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(4),
                )),
                color: blueColor,
              ),
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Flexible(child: Container(), flex: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text("Don't have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: navigateToSignUp,
                child: Container(
                  child: const Text("Sign Up", style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
              ),
            ],
          )
        ],
      ),
    )));
  }
}
