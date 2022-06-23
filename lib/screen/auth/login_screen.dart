import 'package:api_first/api/controller/auth_api_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helper{
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _obscure = true;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
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
          'Login',
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
            'Welcome Back ....',
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            'Login to start the App ..',
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
          TextField(
            controller: _passwordController,
            obscureText: _obscure,
            textInputAction: TextInputAction.go,
            onSubmitted: (String value)async{
              await _performLogin() ;
            },
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
              hintText: 'Password',
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
                icon: Icon(_obscure
                    ? Icons.visibility
                    : Icons.visibility_off_outlined),
              ),
              prefixIcon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 0.8,
                  color: Colors.blue.shade200,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: TextButton(
              onPressed: () =>Navigator.pushNamed(context, '/forget_password_Screen'),
              child: const Text(
                'Forget Password ?',
                style: TextStyle(fontSize: 11),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async => await _performLogin(),
            child: const Text('Login'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Don\'t have account ?',
                style: TextStyle(fontSize: 11),
              ),
              TextButton(
                  onPressed: ()=>Navigator.pushNamed(context, '/register_screen'),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(fontSize: 11),
                  ))

            ],
          )
        ],
      ),
    );
  }

  Future<void> _performLogin() async {
    if(checkInput()){
      await login();
    }
  }

  bool checkInput() {
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty) {
      return true;
    }
   showSnackBar(context, message: 'required Data', status: true);
    return false;
  }

  //TODO EXECUTE API REQUEST HERE
  Future<void> login() async {
    ApiResponse apiResponse = await AuthApiController().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );
    showSnackBar(context, message: apiResponse.message, status: apiResponse.status);
    if(apiResponse.status){
      Navigator.pushReplacementNamed(context, '/user_screen');
    }
  }
}
