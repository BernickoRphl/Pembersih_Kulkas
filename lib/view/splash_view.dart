import 'package:flutter/material.dart';
import 'package:pembersih_kulkas/view/welcome_view.dart'; // Sesuaikan dengan path yang benar

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final PageController _pageController = PageController(initialPage: 0);

  int _currentPage = 0;

  // Daftar halaman splash
  final List<Widget> _pages = [
    SplashPage(
      image: 'assets/images/aa.png',
      title: 'Selamat Datang di Aplikasi Kami',
      description: 'Temukan resep terbaik untuk makanan sehari-hari.',
    ),
    SplashPage(
      image: 'assets/images/aa.png',
      title: 'Motto Kami',
      description: 'Membuat memasak menjadi mudah dan menyenangkan.',
    ),
    SplashPage(
      image: 'assets/images/aa.png',
      title: 'Mulai Sekarang',
      description: 'Daftar sekarang dan mulai jelajahi resep-resep menarik!',
      showButton: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    if (_currentPage == _pages.length - 1) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const WelcomeView(), 
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _pages.map((page) {
              return AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: page,
              );
            }).toList(),
          ),
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: 10, 
                  height: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6), 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5), 
                  ),
                ),
              ),
            ),
          ),
          if (_currentPage != _pages.length - 1)
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _pageController.jumpToPage(_pages.length - 1);
                },
                child: const Text(
                  'Lewati',
                  style: TextStyle(
                    color: Colors.blue, 
                    fontSize: 16,
                    fontWeight: FontWeight.bold, 
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class SplashPage extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final bool showButton;

  const SplashPage({
    super.key,
    required this.image,
    required this.title,
    required this.description,
    this.showButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFB7D7C8),
            const Color(0xFF9FC5B2),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            image,
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white, 
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xCCFFFFFF), 
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (showButton)
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WelcomeView(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, 
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Daftar Sekarang',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFFB7D7C8), 
                ),
              ),
            ),
        ],
      ),
    );
  }
}