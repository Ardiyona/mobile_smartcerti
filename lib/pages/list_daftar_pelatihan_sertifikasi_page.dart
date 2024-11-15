import 'package:flutter/material.dart';
import 'package:mobile_smarcerti/layouts/appbar_tabbar.dart';
import 'package:mobile_smarcerti/widgets/list_daftar_pelatihan_sertifikasi_body.dart';
import 'package:mobile_smarcerti/widgets/pimpinan_bottom_nav_bar.dart';

class ListDaftarPelatihanSertifikasiPage extends StatelessWidget {
  const ListDaftarPelatihanSertifikasiPage({super.key});

  static final List<Tab> myTab = [
    const Tab(
      text: "Pelatihan",
    ),
    const Tab(
      text: "Sertifikasi",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTab.length,
      child: const Scaffold(
        appBar: AppBarTabBar(title: 'Daftar Pelatihan & Sertifikasi'),
        body: ListDaftarPelatihanSertifikasiBody(),
        bottomNavigationBar: PimpinanBottomNavBar(currentIndex: -1),
      ),
    );
  }
}
