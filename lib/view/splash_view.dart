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
    // Auto-navigate setelah 3 detik di halaman terakhir
    if (_currentPage == _pages.length - 1) {
      Future.delayed(const Duration(seconds: 3), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const WelcomeView(), // Navigasi ke WelcomeView
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
          // PageView untuk menampilkan halaman splash
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
          // Indicator untuk menunjukkan halaman aktif
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => Container(
                  width: 10, // Ubah ukuran lingkaran
                  height: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 6), // Ubah margin
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.blue
                        : Colors.grey.withOpacity(0.5), // Ubah warna
                  ),
                ),
              ),
            ),
          ),
          // Tombol "Lewati" di pojok kanan atas
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
                    color: Colors.blue, // Ubah warna teks
                    fontSize: 16,
                    fontWeight: FontWeight.bold, // Tambahkan bold
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
              color: Colors.white, // Warna teks putih
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xCCFFFFFF), // 80% opacity putih
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
                backgroundColor: Colors.white, // Warna tombol putih
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Daftar Sekarang',
                style: TextStyle(
                  fontSize: 16,
                  color: const Color(0xFFB7D7C8), // Warna teks tombol sesuai background
                ),
              ),
            ),
        ],
      ),
    );
  }
}