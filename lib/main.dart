import 'dart:html' as html;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.white,
      drawer: _buildDrawer(), // Side navigation drawer
      body: Column(
        children: [
          // Navigation Bar
          Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Text("Yogesh Jaisankar",
                    style: GoogleFonts.lexend(
                        fontSize: 30,
                        color: Colors.black,
                        fontWeight: FontWeight.bold)),
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
                      ),
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
                  Container(
                    height: 700,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(color: Colors.black),
                    child: Row(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            // Animated Blurred Background Glow
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(460),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: _blurAnimation.value,
                                      sigmaY: _blurAnimation.value,
                                    ),
                                    child: Container(
                                      height: 420,
                                      width: 420,
                                      decoration: BoxDecoration(
                                        gradient: RadialGradient(
                                          colors: [
                                            Color.fromRGBO(218, 112, 214,
                                                0.6), // Soft glowing center
                                            Color.fromRGBO(75, 0, 130,
                                                0.3), // Outer fading effect
                                          ],
                                          stops: [0.3, 1.0],
                                          radius: _glowAnimation
                                              .value, // Smooth expansion
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(420),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),

                            // Animated Avatar Glow
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        Color.fromRGBO(
                                            218, 112, 214, 1), // Bright center
                                        Color.fromRGBO(
                                            75, 0, 130, 1), // Dark outer glow
                                      ],
                                      stops: [0.4, 1.0],
                                      radius: _glowAnimation
                                          .value, // Expanding glow effect
                                    ),
                                  ),
                                  child: const CircleAvatar(
                                    radius: 200,
                                    backgroundImage: NetworkImage(
                                      'https://raw.githubusercontent.com/Yogesh-Jaisankar/portfolio/main/assets/images/image.jpeg',
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        SizedBox(width: 100),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "Hello 👋🏻!, Myself\nYOGESH JAISANKAR",
                              textAlign: TextAlign.center, // Center the text
                              style: GoogleFonts.lexend(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold, // Emphasize name
                                height: 1.3, // Improve line spacing
                              ),
                            ),
                            const SizedBox(
                                height: 20), // Add spacing between texts
                            SizedBox(
                              width: 800, // Limit width for better readability
                              child: Text(
                                "My journey as a self-taught developer has been fueled by curiosity and innovation. Whether it's building AI-driven dating platforms like VCult or solving logistical inefficiencies with Wheel and Meal, I thrive on creating impactful applications that bridge technology and business. With expertise in Flutter, MongoDB, AI/ML, and backend systems, I specialize in developing scalable, user-centric solutions.",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.lexend(
                                  color: Colors
                                      .white70, // Slightly muted color for readability
                                  fontSize: 18,
                                  height: 1.5, // Improve readability
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
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
                                const SizedBox(
                                    width: 20), // Spacing between icons
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
                          ],
                        ),
                      ],
                    ),
                  ),
                  _buildSection(_homeKey, Colors.black, "Home Section"),
                  _buildSection(_aboutKey, Colors.grey[900]!, "About Me"),
                  _buildSection(_skillsKey, Colors.grey[850]!, "Skills"),
                  _buildSection(_projectsKey, Colors.grey[800]!, "Projects"),
                  _buildSection(_contactKey, Colors.grey[800]!, "Contaxt Me"),
                  Container(
                    height: 80,
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
