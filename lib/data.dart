import 'package:flutter/material.dart';

class SkinType {
  final String id, name, desc;
  final IconData icon;
  final Color color;
  SkinType(this.id, this.name, this.desc, this.icon, this.color);
}

class Ingredient {
  final String name, func, detail, suitableFor; 
  Ingredient(this.name, this.func, this.detail, this.suitableFor);
}

// --- DATA JENIS KULIT ---
final List<SkinType> skinTypes = [
  SkinType('s_oily', 'Berminyak', 'Mengkilap di seluruh wajah, pori-pori besar, rentan jerawat.', Icons.water_drop, const Color(0xFF8ED4B8)),
  SkinType('s_dry', 'Kering', 'Terasa ketarik, kasar, kusam, kadang mengelupas.', Icons.ac_unit, const Color(0xFFFFD6D9)),
  SkinType('s_comb', 'Kombinasi', 'Berminyak di T-zone (dahi, hidung), tapi kering di pipi.', Icons.bubble_chart, const Color(0xFFDCCFF9)),
  SkinType('s_sens', 'Sensitif', 'Mudah perih, merah, gatal, dan bereaksi pada produk keras.', Icons.spa, const Color(0xFFFFE6F0)),
  SkinType('s_acne', 'Berjerawat', 'Sedang meradang, banyak komedo, dan butuh penanganan khusus.', Icons.warning_amber_rounded, const Color(0xFFFFCDD2)),
  SkinType('s_norm', 'Normal', 'Seimbang, tidak terlalu berminyak atau kering, jarang bermasalah.', Icons.star, const Color(0xFFFFE9C6)),
];

// --- DATA BAHAN AKTIF ---
final List<Ingredient> ingredients = [
  Ingredient('Niacinamide', 'Kontrol minyak & Cerah.', 'Vitamin B3 yang serba bisa: memperkuat skin barrier, mencerahkan noda, dan meredakan kemerahan.', 'Semua jenis kulit (Terutama Berminyak & Kusam).'),
  Ingredient('Salicylic Acid', 'Bersihkan pori (BHA).', 'Masuk ke dalam pori-pori untuk melarutkan minyak dan kotoran. Musuh utama komedo dan jerawat.', 'Berminyak, Berjerawat, Kombinasi.'),
  Ingredient('Hyaluronic Acid', 'Hidrasi ekstra.', 'Mengikat air 1000x beratnya sendiri. Membuat kulit kenyal, lembap, dan menyamarkan garis halus.', 'Kering, Dehidrasi, Normal, Sensitif.'),
  Ingredient('Retinol', 'Anti-aging terbaik.', 'Mempercepat regenerasi sel kulit. Ampuh untuk kerutan dan tekstur kasar, tapi bisa bikin kering di awal.', 'Normal, Berminyak, Kering (Usia 25+).'),
  Ingredient('Centella Asiatica', 'Menenangkan (Soothing).', 'Tanaman "Cica" yang mendinginkan kulit iritasi, kemerahan, atau habis terpapar matahari.', 'Sensitif, Berjerawat, Kemerahan.'),
  Ingredient('Ceramide', 'Lem kulit (Barrier).', 'Lipid alami yang menyatukan sel kulit agar tidak gampang iritasi dan tetap lembap. Wajib untuk barrier rusak.', 'Kering, Sensitif, Rusak.'),
  Ingredient('Vitamin C', 'Antioksidan & Cerah.', 'Melindungi dari sinar UV dan polusi, serta memudarkan bekas jerawat hitam (PIH).', 'Normal, Kering, Kombinasi (Kusam).'),
  Ingredient('Tea Tree Oil', 'Anti-bakteri alami.', 'Minyak alami yang membunuh bakteri penyebab jerawat dan mengurangi peradangan.', 'Berjerawat, Berminyak.'),
  Ingredient('Azelaic Acid', 'Redakan merah & jerawat.', 'Sangat lembut tapi efektif untuk membunuh bakteri jerawat dan mengatasi Rosacea/kemerahan.', 'Sensitif, Berjerawat, Ibu Hamil.'),
  Ingredient('Snail Mucin', 'Penyembuhan & Glow.', 'Lendir siput yang mempercepat penyembuhan luka jerawat dan memberi efek "glass skin".', 'Kering, Normal, Sensitif.'),
  Ingredient('AHA (Glycolic)', 'Eksfoliasi permukaan.', 'Mengangkat sel kulit mati di permukaan agar kulit tidak kusam dan tekstur lebih halus.', 'Kering, Normal, Kusam.'),
  Ingredient('Panthenol', 'Vit B5 Pelembap.', 'Menarik air dan menahan kelembapan sekaligus menenangkan kulit yang meradang.', 'Semua jenis kulit (Terutama Sensitif).'),
];

// --- DATA RUTINITAS ---
final Map<String, Map<String, List<Map<String, String>>>> routines = {
  // 1. BERMINYAK
  's_oily': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Foaming cleanser (Busa lembut)'}, {'step': 'Toner', 'desc': 'BHA Toner / Pore refining'}, {'step': 'Moisturizer', 'desc': 'Gel moisturizer (Oil-free)'}, {'step': 'Sunscreen', 'desc': 'Matte/Gel finish SPF 30+'}],
    'Malam': [{'step': 'Double Cleanse', 'desc': 'Micellar Water + Face Wash'}, {'step': 'Serum', 'desc': 'Niacinamide / Salicylic Acid'}, {'step': 'Moisturizer', 'desc': 'Gel moisturizer ringan'}],
  },
  // 2. KERING
  's_dry': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Milk/Cream cleanser (Non-stripping)'}, {'step': 'Toner', 'desc': 'Hydrating toner (Hyaluronic)'}, {'step': 'Moisturizer', 'desc': 'Cream pelembap tekstur tebal'}, {'step': 'Sunscreen', 'desc': 'Dewy/Cream finish'}],
    'Malam': [{'step': 'Cleanser', 'desc': 'Cleansing Oil + Gentle Wash'}, {'step': 'Serum', 'desc': 'Hyaluronic Acid / Ceramide'}, {'step': 'Moisturizer', 'desc': 'Sleeping mask / Thick cream'}],
  },
  // 3. KOMBINASI 
  's_comb': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Gel cleanser pH seimbang'}, {'step': 'Toner', 'desc': 'Balancing toner'}, {'step': 'Moisturizer', 'desc': 'Lotion/Gel-cream ringan'}, {'step': 'Sunscreen', 'desc': 'Hybrid sunscreen (ringan)'}],
    'Malam': [{'step': 'Cleanser', 'desc': 'Bersihkan T-zone ekstra'}, {'step': 'Serum', 'desc': 'Niacinamide (seluruh wajah)'}, {'step': 'Moisturizer', 'desc': 'Gel di T-zone, Cream di pipi'}],
  },
  // 4. SENSITIF 
  's_sens': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Gentle wash (Tanpa busa/SLS)'}, {'step': 'Toner', 'desc': 'Calming toner (Cica/Aloe)'}, {'step': 'Moisturizer', 'desc': 'Barrier repair cream'}, {'step': 'Sunscreen', 'desc': 'Physical/Mineral sunscreen'}],
    'Malam': [{'step': 'Cleanser', 'desc': 'Oil cleanser (Tanpa pewangi)'}, {'step': 'Serum', 'desc': 'Centella / Panthenol'}, {'step': 'Moisturizer', 'desc': 'Pelembap tanpa alkohol/parfum'}],
  },
  // 5. BERJERAWAT 
  's_acne': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Cleanser dengan Salicylic Acid'}, {'step': 'Toner', 'desc': 'Tea Tree / Witch Hazel'}, {'step': 'Moisturizer', 'desc': 'Non-comedogenic moisturizer'}, {'step': 'Sunscreen', 'desc': 'Oil-free sunscreen'}],
    'Malam': [{'step': 'Double Cleanse', 'desc': 'Wajib! Hapus debu & sebum'}, {'step': 'Treatment', 'desc': 'Obat totol jerawat / Retinol'}, {'step': 'Moisturizer', 'desc': 'Pelembap ringan (Jaga barrier)'}],
  },
  // 6. NORMAL 
  's_norm': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Pembersih wajah basic'}, {'step': 'Serum', 'desc': 'Vitamin C (Untuk cerah)'}, {'step': 'Moisturizer', 'desc': 'Lotion pelembap'}, {'step': 'Sunscreen', 'desc': 'Lotion SPF 30+'}],
    'Malam': [{'step': 'Cleanser', 'desc': 'Cuci muka bersih'}, {'step': 'Eksfoliasi', 'desc': 'AHA/BHA (2x seminggu)'}, {'step': 'Moisturizer', 'desc': 'Krim malam nutrisi'}],
  },
  // Fallback
  'default': {
    'Pagi': [{'step': 'Cleanser', 'desc': 'Cuci muka'}, {'step': 'Moisturizer', 'desc': 'Pelembap'}, {'step': 'Sunscreen', 'desc': 'Sunscreen'}],
    'Malam': [{'step': 'Cleanser', 'desc': 'Cuci muka'}, {'step': 'Moisturizer', 'desc': 'Pelembap'}],
  },
};