import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:formpage/changepassword.dart';
import 'package:formpage/sign_uppage.dart';

import 'package:firebase_auth/firebase_auth.dart';

class Formpage extends StatefulWidget {
  const Formpage({super.key});

  @override
  State<Formpage> createState() => _FormpageState();
}

class _FormpageState extends State<Formpage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final _firebaseauth = FirebaseAuth.instance;
  Future<String> login(String email, String password) async {
    try {
      await _firebaseauth.signInWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  bool _obscureText = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  void validate() {
    if (formkey.currentState!.validate()) {
      print('ok');
    } else {
      print("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Website Form"),
      ),
      backgroundColor: Colors.yellow,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                controller: emailcontroller,
                maxLength: 20,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  hintText: "Enter the name",
                  labelText: "email",
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "required";
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: passwordcontroller,
                obscureText: _obscureText,
                maxLength: 10,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility),
                  ),
                  prefix: Icon(Icons.lock),
                  border: OutlineInputBorder(borderSide: BorderSide()),
                  hintText: "Enter the pasword",
                  labelText: "password",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "enter the text";
                  } else {}
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    var res = await login(
                        emailcontroller.text, passwordcontroller.text);
                    if (res == "success") {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: ((context) =>ResetPasswordScreen())));
                    } else {
                      print(res);
                    }

                     validate();
                  },
                  child: const Text("Login")),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Register your acccount ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (context) => SIgnUpPage()));
                    },
                    child: Text("Sign up"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
