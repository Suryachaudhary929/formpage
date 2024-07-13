import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SIgnUpPage extends StatefulWidget {
  const SIgnUpPage({super.key});

  @override
  State<SIgnUpPage> createState() => _SIgnUpPageState();
}

class _SIgnUpPageState extends State<SIgnUpPage> {
  final TextEditingController emailcontroller =TextEditingController();
  final TextEditingController passwordcontroller =TextEditingController();
  final _firebaseauth = FirebaseAuth.instance;
  Future<String> Signup(String email, String password) async {
    try {
      await _firebaseauth.createUserWithEmailAndPassword(
          email: email, password: password);
      return "success";
    } on FirebaseException catch (e) {
      return e.message.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUp Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: emailcontroller,
              maxLength: 20,
              decoration:const InputDecoration(
                labelText: "email",
                hintText: 'email',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
            ),
            TextFormField(
              controller: passwordcontroller,
              maxLength: 20,
              decoration:const InputDecoration(
                labelText: "password",
                hintText: 'password',
                border: OutlineInputBorder(borderSide: BorderSide()),
              ),
            ),
            // TextFormField(
            //   maxLength: 20,
            //   decoration: InputDecoration(
            //     label: Text("Confirm passsword"),
            //     hintText: 'Confirm password',
            //     border: OutlineInputBorder(borderSide: BorderSide()),
            //   ),
            // ),
            ElevatedButton(
                onPressed: () async {
                var res = await Signup(emailcontroller.text, passwordcontroller.text);
                if(res == "success"){
                  Navigator.pop(context);
                  print("register successfully");
                }else{
                  print(res);
                }
                },
                child: Text("Register")),
          ],
        ),
      ),
    );
  }
}
