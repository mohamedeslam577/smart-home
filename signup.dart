import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test2/regesteration.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _emailupController = TextEditingController();
  final _passwordupController = TextEditingController();

  @override
  void dispose() {
    _emailupController.dispose();
    _passwordupController.dispose();
    super.dispose();
  }

 Future<void> signUp() async {
  try {
    final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailupController.text.trim(),
      password: _passwordupController.text.trim(),
    );

    // Send email verification
    await credential.user?.sendEmailVerification();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Verification email sent to: ${credential.user?.email}. Please check your inbox.")),
    );

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Regesteration()));

  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The password provided is too weak.')),
      );
    } else if (e.code == 'email-already-in-use') {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('The account already exists for that email.')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(e.toString())),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Home App"),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.cyan[400]),
        backgroundColor: Colors.white,
      ),
      body: Container(
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://img.pikbest.com/backgrounds/20220119/smart-home-house-blue-technology-poster_6244629.jpg!sw800",
            ),
            fit: BoxFit.fill,
          ),
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailupController,
              minLines: 1,
              maxLines: 3,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: "Enter the Username",
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordupController,
              obscureText: true,
              minLines: 1,
              maxLines: 1,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              onPressed: signUp,
              height: 75,
              minWidth: 200,
              color: Colors.white24,
              textColor: Colors.lightBlueAccent,
              child: Text("Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
