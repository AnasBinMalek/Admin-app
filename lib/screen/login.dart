import 'dart:convert';

import 'package:admin_app/screen/nav_bar/home_page.dart';
import 'package:admin_app/screen/main_page.dart';
import 'package:admin_app/widget/brand_colors.dart';
import 'package:admin_app/widget/text_field.dart';
import 'package:admin_app/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading == true,
      progressIndicator: spinkit,
      child: Scaffold(
        body: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Login Page",
                  style: myStyle(22),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Enter your Email",
                style: myStyle(22),
              ),
              CustomeTextField(
                controller: emailController,
                hintText: "Enter your email",
                icon: Icons.email,
              ),
              Text(
                "Enter your Password",
                style: myStyle(22),
              ),
              CustomeTextField(
                controller: passwordController,
                hintText: "Enter your Password",
                icon: Icons.password,
              ),
              Center(
                child: MaterialButton(
                  onPressed: () {
                    getLogin();
                  },
                  height: 80,
                  minWidth: 120,
                  child: Text(
                    "Submit",
                    style: myStyles14(),
                  ),
                  color: Colors.pink,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SharedPreferences? sharedPreferences;
  bool isLoading = false;

  getLogin() async {
    try {
      setState(() {
        isLoading = true;
      });
      sharedPreferences = await SharedPreferences.getInstance();
      String link = "https://apihomechef.antapp.space/api/admin/sign-in";
      var responce = await http.post(Uri.parse(link), body: {
        "email": emailController.text,
        "password": passwordController.text,
      });
      if (responce.statusCode == 200) {
        print("Successsss ${responce.body}");
        var data = jsonDecode(responce.body);
        setState(() {
          isLoading = false;
        });
        showToast("Login Succesfull");
        sharedPreferences!.setString("token", data["access_token"]);
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MainPage()));
        print("Token save ${sharedPreferences!.getString("token")}");
      } else {
        setState(() {
          isLoading = false;
        });
        showToast("Email or Password not match");
        print("Login Failed");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showToast("Login Failed");
    }
  }

  isLogin() async {
    sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences!.getString("token") != null) {
      print("token is ${sharedPreferences!.getString("token")}");
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => MainPage()));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    isLogin();
    super.initState();
  }
}
