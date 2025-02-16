import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yogesh Shankar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

void _downloadCV() {
  const String url =
      'https://yourwebsite.com/Yogesh_CV.pdf'; // Replace with actual PDF URL
  html.AnchorElement anchorElement = html.AnchorElement(href: url)
    ..setAttribute("download", "Yogesh_CV.pdf") // Sets file name
    ..click(); // Triggers download
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  Text("Yogesh Jaisankar",
                      style: GoogleFonts.lexend(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold)),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Home",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "About",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Skills",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Projects",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "Contact",
                      style: GoogleFonts.lexend(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  GestureDetector(
                    onTap: _downloadCV,
                    child: Container(
                      height: 40,
                      width: 110,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Download CV",
                            style: GoogleFonts.lexend(
                                color: Colors.amber,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
