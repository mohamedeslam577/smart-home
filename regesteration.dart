import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test2/reading.dart';


class Regesteration extends StatefulWidget {
  const Regesteration({super.key});

  @override
  _RegesterationState createState() => _RegesterationState();
}

class _RegesterationState extends State<Regesteration> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> signIn() async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    // Check if email is verified
    if (credential.user?.emailVerified ?? false) {
      Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reading()));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please verify your email before signing in.')),
      );
      await FirebaseAuth.instance.signOut(); // Sign out the user
    }
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided for that user.';
    } else {
      message = 'An error occurred. Please try again.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}



  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Smart Home App"),
        titleTextStyle: TextStyle(fontSize: 30,color: Colors.cyan[400]),
        backgroundColor: Colors.white70,
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
              controller: _emailController,
              minLines: 1,
              maxLines: 3,
              maxLength: 100,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white, fontSize: 15),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _passwordController,
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
            onPressed: signIn,          
               height: 75,
              minWidth: 200,
              color: Colors.white24,
              textColor: Colors.lightBlueAccent,
              child: Text("Sign In"),
            ),
          ],
        ),
      ),
    );
  }
}
