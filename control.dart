import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test2/homepage.dart';
import 'package:test2/reading.dart';

class Control extends StatefulWidget {
  const Control({super.key});

  @override
  _ControlState createState() => _ControlState();
}

class _ControlState extends State<Control> {

  bool doorstatue=true;
  bool televesionstatue=true;
  bool garagedoorstatue=true;

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Welcome to the control",
                  style: GoogleFonts.oswald(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Smart devices",
                  style: GoogleFonts.abyssinicaSil(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 70), // Added spacing between text and containers
              // Container 1
              Container(
                width: 600,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[850]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10), // Circular border radius
                ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Doors",style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(width:150 ,),

                  Switch(
                    activeColor: Colors.blue[700],
                    value: doorstatue,
                     onChanged: (val){
                      setState(() {
                        doorstatue=val;
                      }); 
                  }
                  )
                ],
              ),
                ),
              SizedBox(height: 20), // Spacing between containers
              // Container 2
              SizedBox(height: 20), // Spacing between containers
              // Container 3
              Container(
                width: 600,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[850]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20), // Circular border radius
                ),
                    child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Television",style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(width:110 ,),

                  Switch(
                    activeColor: Colors.blue[700],
                    value: televesionstatue,
                     onChanged: (val){
                      setState(() {
                        televesionstatue=val;
                      }); 
                  }
                  
                  )
                ],
              ),
              ),
              SizedBox(height: 20),
               Container(
                width: 600,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.grey[850]?.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(20), // Circular border radius
                ),
                    child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text("Garage Door",style: GoogleFonts.oswald(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                  SizedBox(width:80 ,),

                  Switch(
                    activeColor: Colors.blue[700],
                    value: garagedoorstatue,
                     onChanged: (val){
                      setState(() {
                        garagedoorstatue=val;
                      }); 
                  }
                  
                  )
                ],
              ),
              ),
              SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
               MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Reading()));
              },
              height: 75,
              minWidth: 150,
              color: Colors.black54,
              textColor: Colors.cyan[400],
              child: Text("Back To Readings"),
            ),  

            
               MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => Homepage()));
              },
              height: 75,
              minWidth: 150,
              color: Colors.black54,
              textColor: Colors.cyan[400],
              child: Text("Back To Homepage"),
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
