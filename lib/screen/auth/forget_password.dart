import 'package:api_first/api/controller/auth_api_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/screen/auth/reset_password_screen.dart';
import 'package:api_first/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen>
    with Helper {
  late TextEditingController _emailController;

  @override
  void initState() {
    _emailController = TextEditingController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Forget Password',
          style: GoogleFonts.nunito(
            fontSize: 25,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsetsDirectional.all(20),
        children: [
          Text(
            'Forget Password ...',
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            'Enter your email address',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              // height: 1),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Email',
                prefixIcon: const Icon(Icons.email),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 0.8, color: Colors.blue.shade200))),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async => await _performForgetPassword(),
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performForgetPassword() async {
    if (checkInput()) {
      await forget();
    }
  }

  bool checkInput() {
    if (_emailController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'required Data', status: true);
    return false;
  }

  //TODO EXECUTE API REQUEST HERE
  Future<void> forget() async {
    print('we are here');
    ApiResponse apiResponse =
        await AuthApiController().forGetPassword(email: _emailController.text);
    showSnackBar(context,
        message: apiResponse.message, status: !apiResponse.status);
    if (apiResponse.status==true) {
      print(apiResponse.status);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(
            email: _emailController.text,
          ),
        ),
      );
      showSnackBar(context,
          message: apiResponse.message, status: !apiResponse.status);
    }
  }
}
