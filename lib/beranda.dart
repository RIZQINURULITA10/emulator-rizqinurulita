import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Halaman_Utama extends StatefulWidget {
  const Halaman_Utama({super.key});

  @override
  State<Halaman_Utama> createState() => _Halaman_UtamaState();
}

class _Halaman_UtamaState extends State<Halaman_Utama> {
  // Controllers untuk input teks
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _npmController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Data List untuk Dropdown
  final List<String> _prodiList = ['Informatika', 'Mesin', 'Sipil', 'Arsitek'];
  final List<String> _kelasList = ['A', 'B', 'C', 'D', 'E'];
  String? _selectedProdi;
  String? _selectedKelas;
  String _jenisKelamin = 'Pria'; // Default value

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    _namaController.dispose();
    _alamatController.dispose();
    _npmController.dispose();
    _noHpController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Fungsi untuk memuat data dari SharedPreferences
  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaController.text = prefs.getString('nama') ?? '';
      _alamatController.text = prefs.getString('alamat') ?? '';
      _npmController.text = prefs.getString('npm') ?? '';
      _noHpController.text = prefs.getString('noHp') ?? '';
      _emailController.text = prefs.getString('email') ?? '';
      _selectedKelas = prefs.getString('kelas');
      _selectedProdi = prefs.getString('prodi');
      _jenisKelamin = prefs.getString('jenisKelamin') ?? 'Pria';
    });
  }

  // Fungsi untuk menyimpan data ke SharedPreferences
  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', _namaController.text.trim());
    await prefs.setString('alamat', _alamatController.text.trim());
    await prefs.setString('npm', _npmController.text.trim());
    await prefs.setString('noHp', _noHpController.text.trim());
    await prefs.setString('email', _emailController.text.trim());
    await prefs.setString('kelas', _selectedKelas ?? '');
    await prefs.setString('prodi', _selectedProdi ?? '');
    await prefs.setString('jenisKelamin', _jenisKelamin);
  }

  // Fungsi untuk menampilkan modal setelah data disimpan
  void _showModal() async {
    await _saveData(); // Simpan data sebelum menampilkan modal

    final nama = _namaController.text.trim();
    final alamat = _alamatController.text.trim();
    final npm = _npmController.text.trim();
    final noHp = _noHpController.text.trim();
    final email = _emailController.text.trim();
    final kelas = _selectedKelas ?? '-';
    final prodi = _selectedProdi ?? '-';
    final jk = _jenisKelamin;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Data Mahasiswa'),
        content: Text(
          'Nama: $nama\n'
          'Alamat: $alamat\n'
          'NPM: $npm\n'
          'No HP: $noHp\n'
          'Email: $email\n'
          'Kelas: $kelas\n'
          'Prodi: $prodi\n'
          'Jenis Kelamin: $jk',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        backgroundColor: const Color(0xFF800000), // Warna burgundy
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, const Color(0xFF800000).withOpacity(0.1)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ========== LOGO UNIVERSITAS (Tampilan Disederhanakan) ==========
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20, top: 10),
                    child: Column(
                      children: [
                        // Logo UPGRI - Dihapus dari container bulat ber-shadow
                        Image.asset(
                          'asset/image/logo_upgris.png', // Sesuaikan dengan path aset Anda
                          width: 120,
                          height: 120,
                          fit: BoxFit.contain,
                          errorBuilder:
                              (
                                BuildContext context,
                                Object error,
                                StackTrace? stackTrace,
                              ) {
                                // Jika gagal, tampilkan ikon sederhana
                                return const Icon(
                                  Icons.school,
                                  size: 50,
                                  color: Color(0xFF800000),
                                );
                              },
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'Universitas PGRI Semarang',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF800000),
                          ),
                        ),
                        const SizedBox(height: 5),
                        const Text(
                          'Form Data Mahasiswa',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 18, 13, 13),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(
                          color: Color(0xFF800000),
                          thickness: 1,
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ),

                // ========== FORM DATA ==========
                const SizedBox(height: 10),
                const Text(
                  'Data Pribadi',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 16),

                // Nama
                TextField(
                  controller: _namaController,
                  decoration: const InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                ),
                const SizedBox(height: 16),

                // Alamat
                TextField(
                  controller: _alamatController,
                  decoration: const InputDecoration(
                    labelText: 'Alamat',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.home, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                ),
                const SizedBox(height: 16),

                // NPM
                TextField(
                  controller: _npmController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'NPM',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.numbers, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                ),
                const SizedBox(height: 16),

                // No HP
                TextField(
                  controller: _noHpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: 'No HP',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    hintText: '08xxxxxxxxxx',
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                ),
                const SizedBox(height: 16),

                // Email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    hintText: 'contoh@email.com',
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                ),
                const SizedBox(height: 20),

                // ========== DATA AKADEMIK ==========
                const Text(
                  'Data Akademik',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 16),

                // Kelas (Dropdown)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Kelas',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.class_, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                  value:
                      _selectedKelas, // Menggunakan 'value' daripada 'initialValue'
                  items: _kelasList
                      .map(
                        (k) => DropdownMenuItem(
                          value: k,
                          child: Text(
                            k,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedKelas = v),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(height: 16),

                // Prodi (Dropdown)
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Pilih Program Studi',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.school, color: Color(0xFF800000)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF800000),
                        width: 2,
                      ),
                    ),
                    labelStyle: TextStyle(color: Color(0xFF800000)),
                  ),
                  value:
                      _selectedProdi, // Menggunakan 'value' daripada 'initialValue'
                  items: _prodiList
                      .map(
                        (p) => DropdownMenuItem(
                          value: p,
                          child: Text(
                            p,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) => setState(() => _selectedProdi = v),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(height: 20),

                // ========== JENIS KELAMIN (Radio Button) ==========
                const Text(
                  'Jenis Kelamin:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF800000),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Pria',
                            groupValue: _jenisKelamin,
                            onChanged: (v) =>
                                setState(() => _jenisKelamin = v!),
                            activeColor: const Color(0xFF800000),
                          ),
                          const Text('Pria', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Perempuan',
                            groupValue: _jenisKelamin,
                            onChanged: (v) =>
                                setState(() => _jenisKelamin = v!),
                            activeColor: const Color(0xFF800000),
                          ),
                          const Text(
                            'Perempuan',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // ========== TOMBOL SUBMIT ==========
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _showModal,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      backgroundColor: const Color(0xFF800000),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 5,
                      shadowColor: const Color(0xFF800000).withOpacity(0.3),
                    ),
                    child: const Text(
                      'SIMPAN DATA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ========== FOOTER ==========
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: const Center(
                    child: Text(
                      '© 2024 Universitas PGRI Semarang - Sistem Data Mahasiswa',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
