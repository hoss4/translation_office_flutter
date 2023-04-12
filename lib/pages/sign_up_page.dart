import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/services/api_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/ProgressHUD.dart';

import '../models/register_request_model.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isApiCallProcess = false;
  bool hidePassword = true;
  GlobalKey<FormState> globalFormKey = GlobalKey<FormState>();
  String? userName;
  String? password;
  String? email;
  String? name;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.blue,
      body: ProgressHUD(
        child: Form(
          key: globalFormKey,
          child: _signupUI(context),
        ),
        inAsyncCall: isApiCallProcess,
        opacity: 0.3,
        key: UniqueKey(),
      ),
    ));
  }

  Widget _signupUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Colors.cyan,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(80),
                bottomRight: Radius.circular(80),
              ),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/logo.png',
                    width: 220,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20,
              left: 20,
              bottom: 30,
            ),
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          FormHelper.inputFieldWidget(
            context,
            "Username",
            "Username",
            prefixIcon: Icon(
              Icons.person,
            ),
            prefixIconPaddingLeft: 25,
            showPrefixIcon: true,
            (onValidateValue) {
              if (onValidateValue.isEmpty) {
                return "Must Add Username";
              }
              return null;
            },
            (onSavedValue) => {
              userName = onSavedValue,
            },
            borderFocusColor: Colors.white,
            prefixIconColor: Colors.white,
            borderColor: Colors.white,
            textColor: Colors.white,
            hintColor: Colors.white.withOpacity(0.7),
            borderRadius: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "Password",
              "Password",
              prefixIcon: Icon(
                Icons.security,
              ),
              prefixIconPaddingLeft: 25,
              showPrefixIcon: true,
              (onValidateValue) {
                if (onValidateValue.isEmpty) {
                  return "Must Add a Password ";
                }
                return null;
              },
              (onSavedValue) => {
                password = onSavedValue,
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
              obscureText: hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(
                    () {
                      hidePassword = !hidePassword;
                    },
                  );
                },
                color: Colors.white.withOpacity(0.7),
                icon: Icon(
                    hidePassword ? Icons.visibility_off : Icons.visibility),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "Email",
              "Email",
              prefixIcon: Icon(
                Icons.email,
              ),
              prefixIconPaddingLeft: 25,
              showPrefixIcon: true,
              (onValidateValue) {
                if (onValidateValue.isEmpty) {
                  return "You must add your email";
                }
                return null;
              },
              (onSavedValue) => {
                email = onSavedValue,
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: FormHelper.inputFieldWidget(
              context,
              "Name",
              "Name",
              prefixIcon: Icon(
                Icons.abc,
              ),
              prefixIconPaddingLeft: 25,
              showPrefixIcon: true,
              (onValidateValue) {
                if (onValidateValue.isEmpty) {
                  return "You must put your Name";
                }
                return null;
              },
              (onSavedValue) => {
                name = onSavedValue,
              },
              borderFocusColor: Colors.white,
              prefixIconColor: Colors.white,
              borderColor: Colors.white,
              textColor: Colors.white,
              hintColor: Colors.white.withOpacity(0.7),
              borderRadius: 10,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Center(
            child: FormHelper.submitButton(
              "Register",
              () {
                if (validateAndSave()) {
                  setState(() {
                    isApiCallProcess = true;
                  });
                  RegisterRequestModel model = RegisterRequestModel(
                    username: userName!,
                    password: password!,
                    email: email!,
                    name: name!,
                  );
                  APIService.resgister(model).then((response) {
                    setState(() {
                      isApiCallProcess = false;
                    });
                    if (response.data != null) {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        "Succes",
                        "Registered Succesfully, please Login ",
                        "OK",
                        () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/login',
                            (route) => false,
                          );
                        },
                      );
                    } else {
                      FormHelper.showSimpleAlertDialog(
                        context,
                        "An Error has occured",
                        response.message,
                        "OK",
                        () {
                          Navigator.pop(context);
                        },
                      );
                    }
                  });
                }
              },
              btnColor: Colors.blue,
              txtColor: Colors.white,
              borderColor: Colors.white,
              borderRadius: 10,
            ),
          ),
        ],
      ),
    );
  }

  bool validateAndSave() {
    final form = globalFormKey.currentState;

    if (form!.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }
}
