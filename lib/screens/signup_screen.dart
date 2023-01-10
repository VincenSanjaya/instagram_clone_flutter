import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_flutter/resources/auth_methods.dart';
import 'package:instagram_clone_flutter/screens/login_screen.dart';
import 'package:instagram_clone_flutter/utils/colors.dart';
import 'package:instagram_clone_flutter/utils/utils.dart';
import 'package:instagram_clone_flutter/widgets/text_field_input.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signUpUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        bio: _bioController.text,
        username: _usernameController.text,
        file: _image!
    );

    if (res == 'Success Sign In') {
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
  void navigateToLogIn() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 32),
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
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.grey,
                      backgroundImage: MemoryImage(_image!)
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundColor: Colors.grey,
                      backgroundImage: NetworkImage(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTt1ceyneFkZchgkrwN7dZxWNl_C5Dctvc5BzNh_rEzPQ&s'),
                    ),
              Positioned(
                  child: IconButton(
                      onPressed: selectImage, icon: const Icon(Icons.add_a_photo)),
                  bottom: -10,
                  left: 80)
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          TextFieldInput(
            textEditingController: _usernameController,
            hintText: 'Enter Your Username',
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 24,
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
          TextFieldInput(
            textEditingController: _bioController,
            hintText: 'Enter Your Bio',
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 24,
          ),
          InkWell(
            onTap: signUpUser,
            child: Container(
              child: _isLoading? const Center(child: CircularProgressIndicator(
                color: primaryColor,
              ),) : const Text(
                'Sign Up',
              ),
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
                child: const Text("Already have an account?"),
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
              const SizedBox(
                width: 3,
              ),
              GestureDetector(
                onTap: navigateToLogIn,
                child: Container(
                  child: const Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
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
