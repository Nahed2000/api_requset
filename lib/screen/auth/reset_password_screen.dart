import 'package:api_first/api/controller/auth_api_controller.dart';
import 'package:api_first/model/api_response.dart';
import 'package:api_first/utils/Helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../widget/code_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;

  const ResetPasswordScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> with Helper {
  String _code = '';
  late TextEditingController _firstCodeController;

  late TextEditingController _secondCodeController;

  late TextEditingController _thirdCodeController;

  late TextEditingController _fourthCodeController;

  late FocusNode _firstFocusNode;
  late FocusNode _secondFocusNode;
  late FocusNode _thirdFocusNode;
  late FocusNode _forthFocusNode;

  late TextEditingController newPasswordController;
  late TextEditingController newPasswordConfirmationController;

  @override
  void initState() {
    newPasswordController = TextEditingController();
    newPasswordConfirmationController = TextEditingController();

    _secondCodeController = TextEditingController();
    _thirdCodeController = TextEditingController();
    _fourthCodeController = TextEditingController();
    _firstCodeController = TextEditingController();

    _secondFocusNode = FocusNode();
    _thirdFocusNode = FocusNode();
    _forthFocusNode = FocusNode();
    _firstFocusNode = FocusNode();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    newPasswordController.dispose();
    newPasswordConfirmationController.dispose();
    _firstCodeController.dispose();
    _secondCodeController.dispose();
    _thirdCodeController.dispose();
    _fourthCodeController.dispose();
    _firstFocusNode.dispose();
    _secondFocusNode.dispose();
    _thirdFocusNode.dispose();
    _forthFocusNode.dispose();
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
          'Reset Password',
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
          Row(
            children: [
              Expanded(
                child: CodeTextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _secondFocusNode.requestFocus();
                    }
                  },
                  focusNode: _firstFocusNode,
                  textEditingController: _firstCodeController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _thirdFocusNode.requestFocus();
                    } else {
                      _firstFocusNode.requestFocus();
                    }
                  },
                  focusNode: _secondFocusNode,
                  textEditingController: _secondCodeController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      _forthFocusNode.requestFocus();
                    } else {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                  focusNode: _thirdFocusNode,
                  textEditingController: _thirdCodeController,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: CodeTextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      _thirdFocusNode.requestFocus();
                    }
                  },
                  focusNode: _forthFocusNode,
                  textEditingController: _fourthCodeController,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          TextField(
            controller: newPasswordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                hintText: 'New Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 0.8, color: Colors.blue.shade200))),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: newPasswordConfirmationController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                hintText: 'Confirm Password',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(width: 0.8, color: Colors.blue.shade200))),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () async => await _performResetPassword(),
            child: const Text('Send'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(0, 50),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _performResetPassword() async {
    if (checkData()) {
      await resetPassword();
    }
  }

  bool checkData() {
    if (checkCode() && checkPassword()) {
      return true;
    }
    return false;
  }

  bool checkPassword() {
    if (newPasswordController.text.isNotEmpty &&
        newPasswordConfirmationController.text.isNotEmpty) {
      if (newPasswordConfirmationController.text ==
          newPasswordController.text) {
        return true;
      }
      showSnackBar(context,
          message: 'Password and Confirmation Not Match', status: true);
      return false;
    }
    showSnackBar(context, message: 'Enter Required Data', status: true);
    return false;
  }

  bool checkCode() {
    if (_firstCodeController.text.isNotEmpty &&
        _thirdCodeController.text.isNotEmpty &&
        _secondCodeController.text.isNotEmpty &&
        _fourthCodeController.text.isNotEmpty) {
      getDate();
      return true;
    }
    showSnackBar(context,
        message: 'Please Enter The Code Number', status: true);
    return false;
  }

  void getDate() {
    _code = _firstCodeController.text +
        _thirdCodeController.text +
        _secondCodeController.text +
        _fourthCodeController.text;
  }

  //TODO EXECUTE API REQUEST HERE
  Future<void> resetPassword() async {
    ApiResponse apiResponse = await AuthApiController().resetPassword(
        email: widget.email, password: newPasswordController.text, code: _code);
    showSnackBar(context, message: apiResponse.message, status: !apiResponse.status);
    if(apiResponse.status){
      Navigator.pop(context);
    }
  }
}
