import 'package:flutter/material.dart';
import 'package:test2/regesteration.dart';
import 'package:test2/signup.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _RegesterationState createState() => _RegesterationState();
}

class _RegesterationState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            appBar: AppBar(
        title: Text("Smart Home App"),
        titleTextStyle: TextStyle(fontSize: 30, color: Colors.cyan[400]),
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

          )),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            Text("HEY, WELCOME BACK TO THE HOME",
            style:  TextStyle(fontSize: 20,color: const Color.fromARGB(255, 235, 232, 227),
            fontWeight:FontWeight.bold )),
            SizedBox(height: 20,),
             MaterialButton(
              onPressed: () {
                Navigator.of(context)
                .push(MaterialPageRoute(builder: (context)=>Regesteration()));

              },
              height: 75,
              minWidth: 200,
              color: Colors.white24,
              textColor: Colors.lightBlueAccent,
              child: Text("Sign in"),
            ),
            SizedBox(height: 20,),
            MaterialButton(
              onPressed: () {
              Navigator.of(context)
                .push(MaterialPageRoute(builder: (context)=>Signup()));


              },
              height: 75,
              minWidth: 200,
              color: Colors.white24,
              textColor: Colors.lightBlueAccent,
              child: Text("Sign up"),
            ),

          ]
          ),
          )
            
    );
  }
}
