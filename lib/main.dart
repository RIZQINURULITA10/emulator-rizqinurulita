import 'package:flutter/material.dart';
import 'beranda.dart'; // Asumsikan Halaman_Utama ada di file beranda.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi tema untuk mempertahankan warna burgundy
    return MaterialApp(
      title: 'Aplikasi Data Mahasiswa',
      theme: ThemeData(
        // Menentukan warna utama aplikasi
        primaryColor: const Color(0xFF800000), // Warna burgundy
        fontFamily: 'Roboto',
        useMaterial3: true,

        // Gaya untuk Input Fields
        inputDecorationTheme: InputDecorationTheme(
          // Gaya untuk TextFormField
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            // Menggunakan warna abu-abu muda seperti di screenshot
            borderSide: const BorderSide(
              color: Color.fromARGB(255, 235, 216, 216),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: Color(0xFF800000), // Focus ke burgundy
              width: 2,
            ),
          ),
          filled: true,
          fillColor: Colors.white, // Latar belakang input putih
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 16,
          ),
        ),

        // Gaya untuk Elevated Button (Tombol Login)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF800000), // Warna burgundy
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            minimumSize: const Size(
              double.infinity,
              50,
            ), // Membuat tombol full-width
            textStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
    );
  }
}

// --- LOGIKA HALAMAN LOGIN ---

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _login() {
    if (_formKey.currentState!.validate()) {
      // Simulasi login sederhana: username='admin', password='admin'
      if (_usernameController.text == 'admin' &&
          _passwordController.text == 'admin') {
        // Navigasi ke Halaman Utama setelah login berhasil
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Halaman_Utama()),
        );
      } else {
        // Tampilkan snackbar jika login gagal
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      }
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Membuat Scaffold dengan latar belakang abu-abu muda
    return Scaffold(
      backgroundColor:
          Colors.blue.shade50, // Latar belakang di luar kotak login
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (Disajikan tanpa bingkai bulat)
              // Pastikan Anda telah mendeklarasikan aset di pubspec.yaml
              // dan mengganti 'assets/logo_login.png' dengan path logo Anda
              Image.asset(
                'asset/image/logo_upgris.png', // Ganti dengan path logo Anda yang benar
                height: 100, // Sesuaikan ukuran
                width: 100, // Sesuaikan ukuran
              ),

              const SizedBox(height: 40),

              // Container untuk form login (Kotak putih)
              Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Bagian "Selamat Datang"
                    const Text(
                      'Selamat Datang',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF800000), // Warna burgundy
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Silakan login untuk melanjutkan',
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 30),

                    // Form Input
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _usernameController,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              hintText: 'Masukkan username Anda',
                              prefixIcon: Icon(
                                Icons.person,
                                color: Color(0xFF800000),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              hintText: 'Masukkan password Anda',
                              prefixIcon: Icon(
                                Icons.lock,
                                color: Color(0xFF800000),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Password tidak boleh kosong';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 30),
                          // Tombol Login
                          ElevatedButton(
                            onPressed: _login,
                            child: const Text('Login'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
