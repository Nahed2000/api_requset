import 'package:api_first/model/student_api.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../api/controller/auth_api_controller.dart';
import '../../model/api_response.dart';
import '../../utils/Helper.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with Helper {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _fullNameController;
  bool _obscure = true;
  String gender = 'M';

  @override
  void initState() {
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        title: Text(
          'Register',
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
            'Create New Account',
            style: GoogleFonts.nunito(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text(
            'New Register Here',
            style: GoogleFonts.nunito(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              // height: 1),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _fullNameController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                hintText: 'Full Name ',
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 0.8, color: Colors.blue.shade200))),
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
            onSubmitted: (String value) async {
              await _performLogin();
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
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                  child: RadioListTile<String>(
                      title: const Text('Male'),
                      value: 'M',
                      groupValue: gender,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            gender = value;
                          });
                        }
                      })),
              Expanded(
                  child: RadioListTile<String>(
                      title: const Text('Female'),
                      value: 'F',
                      groupValue: gender,
                      onChanged: (String? value) {
                        if (value != null) {
                          setState(() {
                            gender = value;
                          });
                        }
                      }))
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async => await _performLogin(),
            child: const Text('Register'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performLogin() async {
    if (checkInput()) {
      await _register();
    }
  }

  bool checkInput() {
    if (_passwordController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(context, message: 'required Data', status: true);
    return false;
  }

  //TODO EXECUTE API REQUEST HERE
  Future<void> _register() async {
    ApiResponse apiResponse =
        await AuthApiController().register(student :student);
    if(apiResponse.status){
      Navigator.pop(context);
  }
    showSnackBar(context, message: apiResponse.message, status: !apiResponse.status);

  }
  Student get student {
    Student student = Student();
      student.email = _emailController.text;
      student.password = _passwordController.text;
      student.fullName = _fullNameController.text;
      student.gender = gender;
    return student;
  }
}
