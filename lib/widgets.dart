import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 1. KARTU PILIHAN JENIS KULIT
class SkinOptionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const SkinOptionCard({super.key, required this.title, required this.icon, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDB4D70) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [if (!isSelected) BoxShadow(color: Colors.pink.shade100.withOpacity(0.5), blurRadius: 8, offset: const Offset(0, 4))],
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.pink.shade300),
            const SizedBox(width: 8),
            Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: isSelected ? Colors.white : Colors.grey.shade700)),
          ],
        ),
      ),
    );
  }
}

// 2. KARTU BAHAN AKTIF 
class IngredientCard extends StatelessWidget {
  final String name, function;
  final VoidCallback onTap; 

  const IngredientCard({super.key, required this.name, required this.function, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector( 
      onTap: onTap,
      child: Container(
        width: 160,
        margin: const EdgeInsets.only(right: 14),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Colors.pink.shade300, Colors.pink.shade200], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(color: Colors.pink.shade100, blurRadius: 10, offset: const Offset(0, 5))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.science_outlined, color: Colors.white, size: 28),
                Icon(Icons.info_outline, color: Colors.white70, size: 18), // Ikon info kecil
              ],
            ),
            const SizedBox(height: 10),
            Text(name, style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Expanded(child: Text(function, maxLines: 3, overflow: TextOverflow.ellipsis, style: GoogleFonts.poppins(color: Colors.white70, fontSize: 11))),
          ],
        ),
      ),
    );
  }
}

// 3. KARTU RUTINITAS 
class RoutineCard extends StatelessWidget {
  final String step, desc;
  final int index; 

  const RoutineCard({super.key, required this.step, required this.desc, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(color: Colors.grey.shade100, blurRadius: 6, offset: const Offset(0, 4))],
      ),
      child: Row(
        children: [
          // Bagian Kiri: Ikon Ceklis
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: const Color(0xFFFDEEF4), borderRadius: BorderRadius.circular(12)),
            child: const Icon(Icons.check_circle_outline_rounded, color: Color(0xFFDB4D70)),
          ),
          const SizedBox(width: 14),
          
          // Bagian Tengah: Teks
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step, style: GoogleFonts.poppins(fontWeight: FontWeight.bold, fontSize: 15)),
                Text(desc, style: GoogleFonts.poppins(color: Colors.grey.shade600, fontSize: 12)),
              ],
            ),
          ),

          // Bagian Kanan: Penanda Langkah 
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Text(
              "Langkah ${index + 1}",
              style: GoogleFonts.poppins(fontSize: 10, fontWeight: FontWeight.w600, color: Colors.grey.shade500),
            ),
          ),
        ],
      ),
    );
  }
}

// 4. ACCORDION TIPS
class TipsAccordion extends StatefulWidget {
  final String title, content;
  const TipsAccordion({super.key, required this.title, required this.content});

  @override
  State<TipsAccordion> createState() => _TipsAccordionState();
}

class _TipsAccordionState extends State<TipsAccordion> {
  bool _isOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isOpen = !_isOpen),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [Icon(Icons.lightbulb_outline, color: Colors.pink.shade300), const SizedBox(width: 10), Text(widget.title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600))]),
                Icon(_isOpen ? Icons.expand_less : Icons.expand_more, color: Colors.grey),
              ],
            ),
          ),
          if (_isOpen) Padding(padding: const EdgeInsets.only(top: 12), child: Text(widget.content, style: GoogleFonts.poppins(fontSize: 13, color: Colors.grey.shade700, height: 1.5))),
        ],
      ),
    );
  }
}