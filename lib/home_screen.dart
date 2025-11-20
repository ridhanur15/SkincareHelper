import 'dart:async'; 
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'data.dart';
import 'widgets.dart';

const Color _softBlush = Color(0xFFF2C7C7);
const Color _white = Color(0xFFFFFFFF);
const Color _mint = Color(0xFFD5F3D8);
const Color _darkCherry = Color(0xFFDB4D70); 
const Color _backgroundFallback = Color(0xFFFBF5F6);
 
final List<List<Color>> _bgGradients = [
  [_softBlush.withAlpha(230), _white],
  [_white, _mint.withAlpha(200)],
  [_mint.withAlpha(230), _softBlush.withAlpha(200)],
  [_white, _softBlush.withAlpha(200)],
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String _selectedSkinId = 's_comb'; 
  int _selectedIndex = 0;

  // Logic Animasi Background
  late AnimationController _colorController;
  late Animation<Color?> _colorAnimation1;
  late Animation<Color?> _colorAnimation2;
  int _currentGradientIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), 
    );
    
    _initializeAnimations();
    _startGradientCycle();
  }
  
  @override
  void dispose() {
    _timer?.cancel();
    _colorController.dispose();
    super.dispose();
  }

  void _initializeAnimations() {
    final nextIndex = (_currentGradientIndex + 1) % _bgGradients.length;

    // Animasi dari warna gradien saat ini ke warna gradien berikutnya
    _colorAnimation1 = ColorTween(
      begin: _bgGradients[_currentGradientIndex][0],
      end: _bgGradients[nextIndex][0],
    ).animate(_colorController);

    _colorAnimation2 = ColorTween(
      begin: _bgGradients[_currentGradientIndex][1],
      end: _bgGradients[nextIndex][1],
    ).animate(_colorController);

    _currentGradientIndex = nextIndex;
  }

  void _startGradientCycle() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _colorController.reset();
      setState(() {
        _initializeAnimations(); // Siapkan animasi untuk transisi berikutnya
      });
      _colorController.forward();
    });
    _colorController.forward(); // Mulai animasi pertama
  }

  // Fungsi Pop Up Detail Bahan Aktif
  void _showIngredientDetail(BuildContext context, Ingredient ing) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          backgroundColor: Colors.white,
          titlePadding: const EdgeInsets.all(0),
          title: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Row(
              children: [
                Icon(Icons.science, color: Colors.pink.shade300),
                const SizedBox(width: 12),
                Expanded(child: Text(ing.name, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 18, color: _darkCherry))),
              ],
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailSection("Fungsi Utama:", ing.func),
                const SizedBox(height: 16),
                _buildDetailSection("Penjelasan Detail:", ing.detail),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(color: const Color(0xFFF0Fdf4), borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.green.shade100)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [Icon(Icons.check_circle, size: 16, color: Colors.green), const SizedBox(width: 6), Text("Cocok untuk Kulit:", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green.shade800))]),
                      const SizedBox(height: 4),
                      Text(ing.suitableFor, style: GoogleFonts.poppins(fontSize: 13, color: Colors.green.shade900)),
                    ],
                  ),
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Tutup", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, color: Colors.pink.shade300)),
            )
          ],
        );
      },
    );
  }

  Widget _buildDetailSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
        const SizedBox(height: 4),
        Text(content, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade700, height: 1.5)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentSkin = skinTypes.firstWhere((s) => s.id == _selectedSkinId);
    final currentRoutine = routines[currentSkin.id] ?? routines['default']!;

    return Scaffold(
      backgroundColor: _backgroundFallback, 
      body: Stack( 
        children: [
          AnimatedBuilder(
            animation: _colorController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      _colorAnimation1.value ?? _backgroundFallback,
                      _colorAnimation2.value ?? _backgroundFallback,
                    ],
                  ),
                ),
              );
            },
          ),
          
          // 2. Content (Home/Tips)
          SafeArea(
            child: _selectedIndex == 0 ? _buildHomeContent(currentSkin, currentRoutine) : _buildTipsContent(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        height: 70,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(35), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20)]),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [_navButton(Icons.spa_rounded, "Home", 0), _navButton(Icons.lightbulb_rounded, "Tips", 1)]),
      ),
    );
  }

  // --- HOME CONTENT ---
  Widget _buildHomeContent(SkinType skin, Map<String, List<Map<String, String>>> routine) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Halo, Ridha! ✨", style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold, color: _darkCherry)), Text("Skincare Helper siap membantu.", style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade600))])),
          CircleAvatar(backgroundColor: Colors.pink.shade100, child: const Icon(Icons.person, color: _white)),
        ]),
        const SizedBox(height: 24),
        
        SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: skinTypes.map((s) => SkinOptionCard(title: s.name, icon: s.icon, isSelected: _selectedSkinId == s.id, onTap: () => setState(() => _selectedSkinId = s.id))).toList())),
        const SizedBox(height: 24),
        
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(color: skin.color.withOpacity(0.4), borderRadius: BorderRadius.circular(24)),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text("Karakter ${skin.name}", style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 16)), const SizedBox(height: 6), Text(skin.desc, style: GoogleFonts.poppins(fontSize: 13, height: 1.4))])),
            const SizedBox(width: 12), Icon(skin.icon, size: 48, color: Colors.black45),
          ]),
        ),
        const SizedBox(height: 24),

        Text("Rutinitas Harian", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        
        if (routine['Pagi'] != null) ...routine['Pagi']!.asMap().entries.map((entry) => RoutineCard(step: "Pagi: ${entry.value['step']}", desc: entry.value['desc']!, index: entry.key)),
        if (routine['Malam'] != null) ...routine['Malam']!.asMap().entries.map((entry) => RoutineCard(step: "Malam: ${entry.value['step']}", desc: entry.value['desc']!, index: entry.key)),

        const SizedBox(height: 24),

        Text("Kamus Bahan Aktif", style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        SizedBox(
          height: 140,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: ingredients.map((i) => IngredientCard(name: i.name, function: i.func, onTap: () => _showIngredientDetail(context, i))).toList(),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // --- TIPS CONTENT ---
  Widget _buildTipsContent() {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text("Tips & Trik 💡", style: GoogleFonts.poppins(fontSize: 24, fontWeight: FontWeight.w900, color: _darkCherry)),
        const SizedBox(height: 4),
        Text("Panduan esensial agar kulit sehat maksimal.", style: GoogleFonts.poppins(color: Colors.grey)),
        const SizedBox(height: 20),
        
        const TipsAccordion(
          title: "Filosofi Dasar: CTMP", 
          content: "Jangan pusing dengan 10 langkah skincare. Kamu hanya butuh 4 fondasi utama:\n\n1. Cleanse (Membersihkan): Menghapus debu & minyak.\n2. Tone (Menyeimbangkan): Mengembalikan pH kulit.\n3. Moisturize (Melembapkan): Mengunci air agar kulit tidak kering.\n4. Protect (Melindungi): Sunscreen untuk menangkal sinar UV penyebab penuaan."
        ),
        const TipsAccordion(
          title: "Aturan Emas Sunscreen", 
          content: "Sunscreen adalah skincare terpenting. Tanpanya, serum mahalmu percuma.\n\n• Takaran: Gunakan sebanyak 2 jari penuh (telunjuk & tengah) untuk wajah dan leher.\n• Waktu: Pakai 15 menit sebelum keluar rumah.\n• Re-apply: Oleskan ulang setiap 3-4 jam, terutama jika berkeringat."
        ),
        const TipsAccordion(
          title: "Kenali Skin Barrier Rusak", 
          content: "Jika kulitmu tiba-tiba perih saat pakai produk biasa, merah, gatal, dan muncul jerawat kecil-kecil, itu tandanya Skin Barrier (pelindung kulit) rusak.\n\nSolusi: STOP eksfoliasi (scrub/asam). Kembali ke basic skincare (Cuci muka lembut & Moisturizer Ceramide) sampai kulit tenang kembali."
        ),
        const TipsAccordion(
          title: "Pentingnya Patch Test", 
          content: "Jangan langsung pakai produk baru ke seluruh wajah! Kulit butuh perkenalan.\n\nCara: Oleskan sedikit produk di belakang telinga atau bawah rahang. Tunggu 24 jam. Jika tidak ada gatal atau merah, baru gunakan ke seluruh wajah. Ini menyelamatkanmu dari breakout parah."
        ),
      ],
    );
  }

  Widget _navButton(IconData icon, String label, int index) {
    bool isActive = _selectedIndex == index;
    return InkWell(
      onTap: () => setState(() => _selectedIndex = index),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: isActive ? BoxDecoration(color: _darkCherry, borderRadius: BorderRadius.circular(20)) : null,
        child: Row(children: [Icon(icon, color: isActive ? _white : Colors.grey.shade400), if (isActive) ...[const SizedBox(width: 8), Text(label, style: GoogleFonts.poppins(color: _white, fontWeight: FontWeight.w600))]]),
      ),
    );
  }
}