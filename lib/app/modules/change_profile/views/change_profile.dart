import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_smarcerti/app/data/models/bidang_minat_my_account_model.dart';
import 'package:mobile_smarcerti/app/data/models/mata_kuliah_my_account_model.dart';
import 'package:mobile_smarcerti/app/modules/change_profile/controllers/change_profile_controller.dart';
import 'package:mobile_smarcerti/app/modules/my_account/controllers/my_account_controller.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ChangeProfileScreen extends StatelessWidget {
  final ChangeProfileController controller = Get.put(ChangeProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: controller.profileImage.value != null
                              ? FileImage(controller.profileImage.value!)
                              : AssetImage('assets/images/profile-dosen.jpg')
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            icon: Icon(Icons.camera_alt,
                                color: Colors.white, size: 24),
                            onPressed: controller.pickImage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  LabelField(
                    label: 'Nama Lengkap',
                    controller: controller.nameController,
                  ),
                  SizedBox(height: 20),
                  LabelField(
                    label: 'Username',
                    controller: controller.usernameController,
                  ),
                  MultiSelectDialogField(
                    buttonText: const Text('Bidang Minat'),
                    title: const Text('Bidang Minat'),
                    items: controller.bidangMinatList.map((bidangMinat) {
                      return MultiSelectItem<String>(
                        bidangMinat.idBidangMinat.toString(),
                        bidangMinat.namaBidangMinat,
                      );
                    }).toList(),
                    initialValue: controller
                        .selectedBidangMinat, // Data lama tetap terpilih
                    onConfirm: (val) {
                      controller.selectedBidangMinat =
                          val; // Update pilihan baru
                    },
                  ),
                  MultiSelectDialogField(
                    buttonText: const Text('Mata Kuliah'),
                    title: const Text('Mata Kuliah'),
                    items: controller.mataKuliahList.map((mataKuliah) {
                      return MultiSelectItem<String>(
                        mataKuliah.idMatakuliah.toString(),
                        mataKuliah.namaMatakuliah,
                      );
                    }).toList(),
                    initialValue: controller
                        .selectedMataKuliah, // Data lama tetap terpilih
                    onConfirm: (val) {
                      controller.selectedMataKuliah =
                          val; // Update pilihan baru
                    },
                  ),
                  SizedBox(height: 20),
                  LabelField(
                    label: 'Nomor Telepon',
                    controller: controller.noTeleponController,
                  ),
                  SizedBox(height: 20),
                  LabelField(
                    label: 'Email',
                    controller: controller.emailController,
                  ),
                  SizedBox(height: 20),
                  LabelField(
                    label: 'Jenis Kelamin',
                    controller: controller.jenisKelaminController,
                  ),
                  SizedBox(height: 30),
                  Center(
                    child: controller.isLoading.value
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () {
                              showChangeProfileDialog(
                                  context); // Memanggil metode dialog
                              // Handle save action here
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF375E97),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildDropdownField<T>({
    required String label,
    required List<T> items,
    required T? selectedItem,
    required void Function(T?) onChanged,
    required String Function(T?) displayText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Card(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                isExpanded: true,
                value: selectedItem,
                hint: Text('Pilih $label'),
                items: items.map((item) {
                  return DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      displayText(item),
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Color(0xFF375E97),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Color(0xFF375E97),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showChangeProfileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 239, 84, 40), // Warna latar belakang
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Apakah Anda yakin ingin mengubah profil anda?",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Tidak",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color:
                                Color.fromARGB(255, 239, 84, 40), // Warna teks
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop(); // Tutup dialog
                        },
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 239, 84, 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        child: const Text(
                          "Ya",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () async {
                          controller.updateProfile(context);
                          await Future.delayed(Duration(seconds: 1));
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class LabelField extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const LabelField({super.key, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        Card(
          color: Colors.white,
          elevation: 1,
          margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: TextFormField(
              controller: controller,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF375E97),
              ),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: InputBorder.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
