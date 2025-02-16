import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yogesh Jaisankar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
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
      'https://drive.google.com/file/d/19NaEjDWuOGypsnvXrmSG1CI0Kixs46jQ/view?usp=share_link';
  html.AnchorElement anchorElement = html.AnchorElement(href: url)
    ..setAttribute("download", "Yogesh_CV.pdf")
    ..click();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey _homeKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _skillsKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey sectionKey) {
    final RenderBox renderBox =
        sectionKey.currentContext!.findRenderObject() as RenderBox;
    final double offset =
        renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset;

    _scrollController.animateTo(
      offset - 80, // Adjust to prevent content getting hidden under navbar
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );

    if (MediaQuery.of(context).size.width < 900) {
      Navigator.pop(context); // Close drawer after selection
    }
  }

  late AnimationController _controller;
  late Animation<double> _blurAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _blurAnimation = Tween<double>(begin: 50, end: 120).animate(_controller);
    _glowAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.amber,
      drawer: _buildDrawer(), // Side navigation drawer
      body: Column(
        children: [
          // Navigation Bar
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("P O R T F O L I O",
                    style: GoogleFonts.lexend(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Shimmer.fromColors(
                  baseColor: Colors.black,
                  highlightColor: Colors.amberAccent,
                  period: const Duration(seconds: 2),
                  child: Icon(
                    Icons.terminal, // Replace with your desired icon
                    size: 30, // Adjust the size as needed
                    color: Colors.amber, // Optional, shimmer will override this
                  ),
                ),
                const Spacer(),
                if (MediaQuery.of(context).size.width >=
                    900) // Show full navbar on large screens
                  Row(
                    children: [
                      _navItem("Home", _homeKey),
                      _navItem("About", _aboutKey),
                      _navItem("Skills", _skillsKey),
                      _navItem("Projects", _projectsKey),
                      _navItem("Contact", _contactKey),
                    ],
                  ),
                if (MediaQuery.of(context).size.width <
                    900) // Show menu button for small screens
                  IconButton(
                    icon: const Icon(Icons.menu, size: 30, color: Colors.black),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
              ],
            ),
          ),

          // Scrollable Sections
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      double screenWidth = constraints.maxWidth;
                      bool isMobile = screenWidth < 768;
                      bool isTablet = screenWidth >= 768 && screenWidth < 1024;

                      return Container(
                        key: _homeKey,
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 20 : 50),
                        child: Flex(
                          direction: isMobile ? Axis.vertical : Axis.horizontal,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: isMobile ? 0 : 1,
                              child: Center(
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      height: isMobile ? 250 : 310,
                                      width: isMobile ? 250 : 310,
                                      decoration: BoxDecoration(
                                        color: Colors.amberAccent,
                                        borderRadius:
                                            BorderRadius.circular(320),
                                      ),
                                    ),
                                    CircleAvatar(
                                      radius: isMobile ? 120 : 150,
                                      backgroundImage: const NetworkImage(
                                        'https://raw.githubusercontent.com/Yogesh-Jaisankar/portfolio/main/assets/images/image.jpeg',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                                width: isMobile ? 0 : 50,
                                height: isMobile ? 40 : 0),
                            Expanded(
                              flex: isMobile ? 0 : 1,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Shimmer.fromColors(
                                    baseColor:
                                        Colors.amberAccent.withOpacity(0.8),
                                    highlightColor: Colors.grey.shade900,
                                    period: const Duration(seconds: 5),
                                    child: Text(
                                      "Hello 👋🏻!, Myself\nYogesh Shankar",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lexend(
                                        color: Colors.white,
                                        fontSize: isMobile ? 30 : 40,
                                        fontWeight: FontWeight.bold,
                                        height: 1.3,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SizedBox(
                                    width: isMobile ? 300 : 800,
                                    child: Text(
                                      "I thrive on creating impactful applications that bridge technology and business.With expertise in Flutter, MongoDB, AI/ML, and backend systems, I specialize in developing scalable, user-centric solutions.",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.lexend(
                                        color: Colors.white70,
                                        fontSize: isMobile ? 16 : 18,
                                        height: 1.5,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  _buildSocialIcons(isMobile),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: _downloadCV,
                                    child: Container(
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Colors.amber,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            "Download CV",
                                            style: GoogleFonts.lexend(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile =
                          constraints.maxWidth < 800; // Responsive breakpoint
                      return Container(
                        key: _aboutKey,
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        width: double.infinity,
                        color: Colors.grey[900], // Background color
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Heading at the Top (For Better Mobile View)
                            Text(
                              "EDUCATION",
                              style: GoogleFonts.lexend(
                                color: Colors.amberAccent,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),

                            // Adaptive Layout
                            Flex(
                              direction:
                                  isMobile ? Axis.vertical : Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Lottie Animation
                                Lottie.asset(
                                  "assets/images/edi.json",
                                  width: isMobile
                                      ? 250
                                      : 500, // Adjust size for mobile
                                  height: isMobile ? 250 : 500,
                                  fit: BoxFit.contain,
                                ),
                                SizedBox(width: 100),
                                SizedBox(
                                    height: isMobile ? 20 : 0,
                                    width: isMobile ? 0 : 50),

                                // Education Details
                                Container(
                                  width: isMobile ? double.infinity : 550,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                        .withOpacity(0.1), // Glassmorphism
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.2)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Gradient Line
                                      Container(
                                        height: 5,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.amberAccent,
                                              Colors.deepOrange
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(height: 15),

                                      // Education Entries
                                      _buildEducationTile(
                                        "Integrated M.Tech in Computer Science & Engineering with Business Analytics",
                                        "Vellore Institute of Technology (VIT), Chennai",
                                        "Expected Graduation: 2026",
                                      ),
                                      _buildEducationTile(
                                        "Grade 12 (CBSE)",
                                        "Vailankanni Public School, Krishnagiri",
                                        "82.4% | 2021",
                                      ),
                                      _buildEducationTile(
                                        "Grade 10 (Matriculation)",
                                        "Sri Vijay Vidyalaya Matric Higher Secondary School, Krishnagiri",
                                        "87.6% | 2019",
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      bool isMobile = constraints.maxWidth < 800;

                      return Container(
                        key: _skillsKey,
                        padding:
                            EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                        width: double.infinity,
                        color: Colors.grey[900], // Background color
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // 🏷 Heading
                            Text(
                              "SKILLS",
                              style: GoogleFonts.lexend(
                                color: Colors.amberAccent,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 20),

                            // 🔹 First Row: Lottie + Relevant Coursework
                            isMobile
                                ? Column(
                                    children: [
                                      Lottie.asset(
                                        "assets/images/skills.json",
                                        width: 500,
                                        height: 500,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(height: 20),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: isMobile
                                              ? double.infinity
                                              : 800, // Prevents stretching
                                        ),
                                        padding: EdgeInsets.all(20),
                                        decoration: _glassmorphismStyle(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Skills",
                                              style: GoogleFonts.lexend(
                                                color: Colors.amberAccent,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Wrap(
                                              spacing: 15,
                                              runSpacing: 10,
                                              alignment: WrapAlignment
                                                  .center, // Center skills
                                              children: [
                                                _buildSkillChip(
                                                    "Mobile App Development", [
                                                  {
                                                    "name": "Flutter",
                                                    "icon":
                                                        "assets/images/flutter.png"
                                                  },
                                                  {
                                                    "name": "Dart",
                                                    "icon":
                                                        "assets/images/dart.png"
                                                  },
                                                  {
                                                    "name": "Android (Kotlin)",
                                                    "icon":
                                                        "assets/images/kotlin.png"
                                                  },
                                                  {
                                                    "name": "iOS (Swift)",
                                                    "icon":
                                                        "assets/images/swift.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Programming Languages", [
                                                  {
                                                    "name": "Dart",
                                                    "icon":
                                                        "assets/images/dart.png"
                                                  },
                                                  {
                                                    "name": "Python",
                                                    "icon":
                                                        "assets/images/python.png"
                                                  },
                                                  {
                                                    "name": "Java",
                                                    "icon":
                                                        "assets/images/java.png"
                                                  },
                                                  {
                                                    "name": "C",
                                                    "icon":
                                                        "assets/images/c.png"
                                                  },
                                                  {
                                                    "name": "Kotlin",
                                                    "icon":
                                                        "assets/images/kotlin.png"
                                                  },
                                                  {
                                                    "name": "JavaScript",
                                                    "icon":
                                                        "assets/images/js.png"
                                                  },
                                                  {
                                                    "name": "SQL",
                                                    "icon":
                                                        "assets/images/sql.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "State Management", [
                                                  {
                                                    "name": "Provider",
                                                    "icon":
                                                        "assets/images/provider.png"
                                                  },
                                                  {
                                                    "name": "Riverpod",
                                                    "icon":
                                                        "assets/images/riverpod.png"
                                                  },
                                                  {
                                                    "name": "Bloc",
                                                    "icon":
                                                        "assets/images/bloc.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Backend & API Integration",
                                                    [
                                                      {
                                                        "name": "REST API",
                                                        "icon":
                                                            "assets/images/api.png"
                                                      },
                                                    ]),
                                                _buildSkillChip(
                                                    "Database Management", [
                                                  {
                                                    "name": "MongoDB",
                                                    "icon":
                                                        "assets/images/mongo.png"
                                                  },
                                                  {
                                                    "name": "Firebase",
                                                    "icon":
                                                        "assets/images/firebase.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Version Control", [
                                                  {
                                                    "name": "Git",
                                                    "icon":
                                                        "assets/images/gi.png"
                                                  },
                                                  {
                                                    "name": "GitHub",
                                                    "icon":
                                                        "assets/images/git.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Monetization & Analytics",
                                                    [
                                                      {
                                                        "name": "AdMob",
                                                        "icon":
                                                            "assets/images/admob.png"
                                                      },
                                                      {
                                                        "name":
                                                            "In-App Purchases",
                                                        "icon":
                                                            "assets/images/ps.png"
                                                      },
                                                    ]),
                                                _buildSkillChip(
                                                    "Tools & IDEs", [
                                                  {
                                                    "name": "Jupyter Notebook",
                                                    "icon":
                                                        "assets/images/jupyter.png"
                                                  },
                                                  {
                                                    "name": "PyCharm",
                                                    "icon":
                                                        "assets/images/il.png"
                                                  },
                                                  {
                                                    "name": "IntelliJ IDEA",
                                                    "icon":
                                                        "assets/images/ij.png"
                                                  },
                                                  {
                                                    "name": "Eclipse",
                                                    "icon":
                                                        "assets/images/ec.png"
                                                  },
                                                  {
                                                    "name": "VS Code",
                                                    "icon":
                                                        "assets/images/vs.png"
                                                  },
                                                  {
                                                    "name": "Android Studio",
                                                    "icon":
                                                        "assets/images/as.png"
                                                  },
                                                ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Lottie.asset(
                                        "assets/images/skills.json",
                                        width: 500,
                                        height: 500,
                                        fit: BoxFit.contain,
                                      ),
                                      SizedBox(width: 100),
                                      Container(
                                        constraints: BoxConstraints(
                                          maxWidth: isMobile
                                              ? double.infinity
                                              : 800, // Prevents stretching
                                        ),
                                        padding: EdgeInsets.all(20),
                                        decoration: _glassmorphismStyle(),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Skills",
                                              style: GoogleFonts.lexend(
                                                color: Colors.amberAccent,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 10),
                                            Wrap(
                                              spacing: 15,
                                              runSpacing: 10,
                                              alignment: WrapAlignment
                                                  .center, // Center skills
                                              children: [
                                                _buildSkillChip(
                                                    "Mobile App Development", [
                                                  {
                                                    "name": "Flutter",
                                                    "icon":
                                                        "assets/images/flutter.png"
                                                  },
                                                  {
                                                    "name": "Dart",
                                                    "icon":
                                                        "assets/images/dart.png"
                                                  },
                                                  {
                                                    "name": "Android (Kotlin)",
                                                    "icon":
                                                        "assets/images/kotlin.png"
                                                  },
                                                  {
                                                    "name": "iOS (Swift)",
                                                    "icon":
                                                        "assets/images/swift.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Programming Languages", [
                                                  {
                                                    "name": "Dart",
                                                    "icon":
                                                        "assets/images/dart.png"
                                                  },
                                                  {
                                                    "name": "Python",
                                                    "icon":
                                                        "assets/images/python.png"
                                                  },
                                                  {
                                                    "name": "Java",
                                                    "icon":
                                                        "assets/images/java.png"
                                                  },
                                                  {
                                                    "name": "C",
                                                    "icon":
                                                        "assets/images/c.png"
                                                  },
                                                  {
                                                    "name": "Kotlin",
                                                    "icon":
                                                        "assets/images/kotlin.png"
                                                  },
                                                  {
                                                    "name": "JavaScript",
                                                    "icon":
                                                        "assets/images/js.png"
                                                  },
                                                  {
                                                    "name": "SQL",
                                                    "icon":
                                                        "assets/images/sql.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "State Management", [
                                                  {
                                                    "name": "Provider",
                                                    "icon":
                                                        "assets/images/provider.png"
                                                  },
                                                  {
                                                    "name": "Riverpod",
                                                    "icon":
                                                        "assets/images/riverpod.png"
                                                  },
                                                  {
                                                    "name": "Bloc",
                                                    "icon":
                                                        "assets/images/bloc.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Backend & API Integration",
                                                    [
                                                      {
                                                        "name": "REST API",
                                                        "icon":
                                                            "assets/images/api.png"
                                                      },
                                                    ]),
                                                _buildSkillChip(
                                                    "Database Management", [
                                                  {
                                                    "name": "MongoDB",
                                                    "icon":
                                                        "assets/images/mongo.png"
                                                  },
                                                  {
                                                    "name": "Firebase",
                                                    "icon":
                                                        "assets/images/firebase.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Version Control", [
                                                  {
                                                    "name": "Git",
                                                    "icon":
                                                        "assets/images/gi.png"
                                                  },
                                                  {
                                                    "name": "GitHub",
                                                    "icon":
                                                        "assets/images/git.png"
                                                  },
                                                ]),
                                                _buildSkillChip(
                                                    "Monetization & Analytics",
                                                    [
                                                      {
                                                        "name": "AdMob",
                                                        "icon":
                                                            "assets/images/admob.png"
                                                      },
                                                      {
                                                        "name":
                                                            "In-App Purchases",
                                                        "icon":
                                                            "assets/images/ps.png"
                                                      },
                                                    ]),
                                                _buildSkillChip(
                                                    "Tools & IDEs", [
                                                  {
                                                    "name": "Jupyter Notebook",
                                                    "icon":
                                                        "assets/images/jupyter.png"
                                                  },
                                                  {
                                                    "name": "PyCharm",
                                                    "icon":
                                                        "assets/images/il.png"
                                                  },
                                                  {
                                                    "name": "IntelliJ IDEA",
                                                    "icon":
                                                        "assets/images/ij.png"
                                                  },
                                                  {
                                                    "name": "Eclipse",
                                                    "icon":
                                                        "assets/images/ec.png"
                                                  },
                                                  {
                                                    "name": "VS Code",
                                                    "icon":
                                                        "assets/images/vs.png"
                                                  },
                                                  {
                                                    "name": "Android Studio",
                                                    "icon":
                                                        "assets/images/as.png"
                                                  },
                                                ]),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),

                            SizedBox(height: 30),

                            // 🔥 Second Section: Skills Container
                          ],
                        ),
                      );
                    },
                  ),
                  _buildSection(_projectsKey, Colors.grey[800]!, "Projects"),
                  _buildSection(_contactKey, Colors.grey[800]!, "Contaxt Me"),
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.black),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () => html.window.open(
                                  'https://www.linkedin.com/in/yogeshjaisankar/',
                                  '_blank'),
                              child: Image.asset('assets/images/ln.png',
                                  width: 30, height: 30),
                            ),
                            const SizedBox(width: 20), // Spacing between icons
                            GestureDetector(
                              onTap: () => html.window.open(
                                  'https://github.com/Yogesh-Jaisankar',
                                  '_blank'),
                              child: Image.asset('assets/images/git.png',
                                  width: 40, height: 40),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () => html.window.open(
                                  'https://www.facebook.com/yogesh.jaisankar.9',
                                  '_blank'),
                              child: Image.asset('assets/images/fb.png',
                                  width: 30, height: 30),
                            ),
                            const SizedBox(width: 20),
                            GestureDetector(
                              onTap: () => html.window.open(
                                  'https://www.instagram.com/__yogesh_shankar/',
                                  '_blank'),
                              child: Image.asset('assets/images/ig.png',
                                  width: 30, height: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "© Yogesh Shankar - All Rights Reserved",
                          style: GoogleFonts.lexend(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRelevantCoursework() {
    return Container(
      width: 400,
      padding: EdgeInsets.all(20),
      decoration: _glassmorphismStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Relevant Coursework",
            style: GoogleFonts.lexend(
              color: Colors.amberAccent,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          ...[
            "Software Engineering",
            "Database Management Systems",
            "Data Structures & Algorithms",
            "Design & Analysis of Algorithms",
            "Machine Learning",
            "Deep Learning",
            "NoSQL Databases",
          ].map((course) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  "• $course",
                  style: GoogleFonts.lexend(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // Glassmorphism Style Function
  BoxDecoration _glassmorphismStyle() {
    return BoxDecoration(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Colors.white.withOpacity(0.2)),
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          spreadRadius: 2,
          offset: Offset(0, 4),
        ),
      ],
    );
  }

// Skill Chip Widget
  Widget _buildSkillChip(String title, List<Map<String, String>> skills) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // 🔹 Title
        Text(
          title,
          style: GoogleFonts.lexend(
            color: Colors.amberAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),

        // 🔥 Custom Skill Display (Replaces Chips)
        Wrap(
          spacing: 12,
          runSpacing: 10,
          children: skills
              .map((skill) => Container(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          skill['icon']!, // 🔥 Load PNG Icon
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 8),
                        Text(
                          skill['name']!,
                          style: GoogleFonts.lexend(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildSocialIcons(bool isMobile) {
    return Wrap(
      spacing: isMobile ? 12 : 20,
      runSpacing: isMobile ? 12 : 0,
      alignment: WrapAlignment.center,
      children: [
        GestureDetector(
          onTap: () => html.window
              .open('https://www.linkedin.com/in/yogeshjaisankar/', '_blank'),
          child: Image.asset('assets/images/ln.png',
              width: isMobile ? 25 : 30, height: isMobile ? 25 : 30),
        ),
        GestureDetector(
          onTap: () =>
              html.window.open('https://github.com/Yogesh-Jaisankar', '_blank'),
          child: Image.asset('assets/images/git.png',
              width: isMobile ? 35 : 40, height: isMobile ? 35 : 40),
        ),
        GestureDetector(
          onTap: () => html.window
              .open('https://www.facebook.com/yogesh.jaisankar.9', '_blank'),
          child: Image.asset('assets/images/fb.png',
              width: isMobile ? 25 : 30, height: isMobile ? 25 : 30),
        ),
        GestureDetector(
          onTap: () => html.window
              .open('https://www.instagram.com/__yogesh_shankar/', '_blank'),
          child: Image.asset('assets/images/ig.png',
              width: isMobile ? 25 : 30, height: isMobile ? 25 : 30),
        ),
      ],
    );
  }

  Widget _buildEducationTile(String title, String institute, String details) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "📌 $title",
            style: GoogleFonts.lexend(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            institute,
            style: GoogleFonts.lexend(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          Text(
            details,
            style: GoogleFonts.lexend(
              color: Colors.amberAccent,
              fontSize: 14,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // Navbar Items for Large Screens
  Widget _navItem(String title, GlobalKey sectionKey) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: MouseRegion(
        cursor: SystemMouseCursors.click, // Change cursor to pointer
        child: GestureDetector(
          onTap: () => _scrollToSection(sectionKey),
          child: Text(
            title,
            style: GoogleFonts.lexend(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  // Sidebar Navigation Drawer for Small Screens
  Widget _buildDrawer() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              child: Text("Navigation",
                  style: GoogleFonts.lexend(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            ),
            _drawerItem("Home", _homeKey),
            _drawerItem("About", _aboutKey),
            _drawerItem("Skills", _skillsKey),
            _drawerItem("Projects", _projectsKey),
            _drawerItem("Contact", _contactKey),
            ListTile(
              leading: const Icon(Icons.download, color: Colors.black),
              title: Text("Download CV",
                  style: GoogleFonts.lexend(
                      fontSize: 16, fontWeight: FontWeight.bold)),
              onTap: _downloadCV,
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerItem(String title, GlobalKey sectionKey) {
    return MouseRegion(
      cursor: SystemMouseCursors.click, // Change cursor to pointer
      child: ListTile(
        title: Text(title, style: GoogleFonts.lexend(fontSize: 16)),
        onTap: () => _scrollToSection(sectionKey),
      ),
    );
  }

  // Section Builder
  Widget _buildSection(GlobalKey key, Color color, String title) {
    return Container(
      key: key,
      height: 700,
      width: double.infinity,
      color: color,
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.lexend(
              fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
