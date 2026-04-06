import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ==========================
// A. MENYAPA
// ==========================

// 1. tanpa parameter, tanpa return
void sapaTanpaParameterTanpaReturn() {
  debugPrint("Halo, selamat datang!");
}

// 2. dengan parameter, tanpa return
void sapaDenganParameterTanpaReturn(String nama) {
  debugPrint("Halo, $nama!");
}

// 3. tanpa parameter, dengan return
String sapaTanpaParameterDenganReturn() {
  return "Halo, selamat datang!";
}

// 4. dengan parameter, dengan return
String sapaDenganParameterDenganReturn(String nama) {
  return "Halo, $nama!";
}

// ==========================
// B. LUAS PERSEGI
// ==========================

// 1. tanpa parameter, tanpa return
void luasPersegiTanpaParameterTanpaReturn() {
  int sisi = 4;
  int luas = sisi * sisi;
  debugPrint("Luas persegi sisi $sisi adalah $luas");
}

// 2. dengan parameter, tanpa return
void luasPersegiDenganParameterTanpaReturn(int sisi) {
  int luas = sisi * sisi;
  debugPrint("Luas persegi sisi $sisi adalah $luas");
}

// 3. tanpa parameter, dengan return
int luasPersegiTanpaParameterDenganReturn() {
  int sisi = 5;
  return sisi * sisi;
}

// 4. dengan parameter, dengan return
int luasPersegiDenganParameterDenganReturn(int sisi) {
  return sisi * sisi;
}

// ==========================
// C. DISKON
// ==========================

// 1. tanpa parameter, tanpa return
void diskonTanpaParameterTanpaReturn() {
  double harga = 100000;
  double diskon = 10;
  double hasil = harga - (harga * diskon / 100);
  debugPrint("Harga setelah diskon: $hasil");
}

// 2. dengan parameter, tanpa return
void diskonDenganParameterTanpaReturn(double harga, double diskon) {
  double hasil = harga - (harga * diskon / 100);
  debugPrint("Harga setelah diskon: $hasil");
}

// 3. tanpa parameter, dengan return
double diskonTanpaParameterDenganReturn() {
  double harga = 120000;
  double diskon = 10;
  return harga - (harga * diskon / 100);
}

// 4. dengan parameter, dengan return
double diskonDenganParameterDenganReturn(double harga, double diskon) {
  return harga - (harga * diskon / 100);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Function',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        scaffoldBackgroundColor: const Color(0xfff4f6fb),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController sisiController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();
  final TextEditingController persenController = TextEditingController();

  String hasilSapa = "-";
  String hasilLuas = "-";
  String hasilDiskon = "-";

  @override
  void dispose() {
    namaController.dispose();
    sisiController.dispose();
    hargaController.dispose();
    persenController.dispose();
    super.dispose();
  }

  void prosesSapa() {
    String nama = namaController.text.trim();

    setState(() {
      if (nama.isEmpty) {
        hasilSapa = "Silakan masukkan nama terlebih dahulu.";
      } else {
        sapaDenganParameterTanpaReturn(nama);
        hasilSapa = sapaDenganParameterDenganReturn(nama);
      }
    });
  }

  void prosesLuas() {
    int? sisi = int.tryParse(sisiController.text);

    setState(() {
      if (sisi == null) {
        hasilLuas = "Masukkan angka sisi yang valid.";
      } else {
        luasPersegiDenganParameterTanpaReturn(sisi);
        hasilLuas =
            "Luas persegi dengan sisi $sisi adalah ${luasPersegiDenganParameterDenganReturn(sisi)}";
      }
    });
  }

  void prosesDiskon() {
    double? harga = double.tryParse(hargaController.text);
    double? diskon = double.tryParse(persenController.text);

    setState(() {
      if (harga == null || diskon == null) {
        hasilDiskon = "Masukkan harga dan diskon yang valid.";
      } else {
        diskonDenganParameterTanpaReturn(harga, diskon);
        double hasil = diskonDenganParameterDenganReturn(harga, diskon);
        hasilDiskon =
            "Harga setelah diskon ${diskon.toStringAsFixed(0)}% adalah Rp ${hasil.toStringAsFixed(0)}";
      }
    });
  }

  Widget buildSectionCard({
    required String title,
    required String subtitle,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              )),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget buildResultBox(String label, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xfff7f8fc),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xffd9deea)),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 15,
            color: Colors.black87,
          ),
          children: [
            TextSpan(
              text: "$label\n",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  Widget buildInputField({
    required TextEditingController controller,
    required String label,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          filled: true,
          fillColor: const Color(0xfffafbff),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Function Dart"),
        centerTitle: true,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xff4f46e5), Color(0xff7c3aed)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tugas Function Sederhana",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "Terdiri dari 3 topik: Menyapa, Kalkulator Luas Persegi, dan Kalkulator Diskon.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              buildSectionCard(
                title: "A. Topik Menyapa",
                subtitle:
                    "Contoh function sapaan dengan input nama dari pengguna.",
                children: [
                  buildInputField(
                    controller: namaController,
                    label: "Masukkan nama",
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: prosesSapa,
                      child: const Text("OK"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildResultBox("Hasil:", hasilSapa),
                ],
              ),

              buildSectionCard(
                title: "B. Kalkulator Luas Persegi",
                subtitle:
                    "Menghitung luas persegi berdasarkan nilai sisi yang diinput.",
                children: [
                  buildInputField(
                    controller: sisiController,
                    label: "Masukkan sisi persegi",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: prosesLuas,
                      child: const Text("Hitung"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildResultBox("Hasil:", hasilLuas),
                ],
              ),

              buildSectionCard(
                title: "C. Kalkulator Diskon",
                subtitle:
                    "Menghitung harga akhir setelah diskon berdasarkan input pengguna.",
                children: [
                  buildInputField(
                    controller: hargaController,
                    label: "Masukkan harga",
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  buildInputField(
                    controller: persenController,
                    label: "Masukkan diskon (%)",
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: prosesDiskon,
                      child: const Text("Hitung"),
                    ),
                  ),
                  const SizedBox(height: 12),
                  buildResultBox("Hasil:", hasilDiskon),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}