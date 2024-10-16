import 'package:flutter/material.dart';

class SertifikasiAll extends StatelessWidget {
  const SertifikasiAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Search bar
          TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: const Color.fromARGB(145, 255, 249, 249),
              filled: true,
            ),
          ),

          const SizedBox(
              height:
                  20), // Spasi antara search bar dan tombol Pengajuan & Upload

          // Button Pengajuan & Upload
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol "Pengajuan" ditekan
                  print("Pengajuan ditekan");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 55, 94, 151), // Warna tombol biru
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding tombol
                ),
                child: const Text(
                  'Pengajuan',
                  style: TextStyle(color: Colors.white), // Warna teks putih
                ),
              ),
              const SizedBox(
                  width: 10), // Jarak antar tombol Pengajuan dan Upload

              ElevatedButton(
                onPressed: () {
                  // Aksi ketika tombol "Upload" ditekan
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                      255, 239, 84, 40), // Warna tombol oranye
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 15), // Padding tombol
                ),
                child: const Text(
                  'Upload',
                  style: TextStyle(color: Colors.white), // Warna teks putih
                ),
              ),
            ],
          ),
          const Divider(
            color: Colors.grey,
            height: 50,
            thickness: 2,
            indent: 0,
            endIndent: 0,
          ),

          const SizedBox(height: 5), // Spasi antara tombol dan ListView

          // Expanded agar ListView bisa scroll
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(
                  color: Colors.black, // Garis pemisah antar item
                );
              },
              itemCount: 5, // Jumlah item
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(
                    Icons.library_books,
                    size: 35.0,
                  ),
                  title: const Text(
                    "Intelligent Manufacturing: IoT, AI, Digital Transformation", // Judul pelatihan
                  ),
                  subtitle: const Text(
                    "Internet of Things (IoT), Artificial Intelligence, and Digital Transformation into Industry 4.0.", // Deskripsi pelatihan
                  ),
                  onTap: () {
                    // Navigasi ke halaman detail pelatihan
                  },
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20.0,
                  ),
                  contentPadding: const EdgeInsets.all(20),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
