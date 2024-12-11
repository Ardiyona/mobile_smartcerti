import 'package:get/get.dart';
import 'package:mobile_smarcerti/app/data/models/my_account_model.dart';
import 'package:mobile_smarcerti/app/data/models/user_model.dart';
import 'package:mobile_smarcerti/app/data/provider/api_provider.dart';
import 'package:mobile_smarcerti/app/modules/auth/controllers/base_controller.dart';
import 'package:mobile_smarcerti/services/api_service.dart';
import 'package:mobile_smarcerti/services/my_account_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends BaseController {
  final MyAccountService _profileService = MyAccountService(ApiService());
  final ApiProvider _apiProvider = ApiProvider();
  final profiles = Rx<User?>(null);
  var namaLengkap = ''.obs; // State reaktif untuk nama lengkap
  RxString avatarUrl = ''.obs;
  RxList<User> myAccount = <User>[].obs;
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // initializeData();
    update();
    initializeData();
  }

  Future<void> initializeData() async {
    try {
      await loadProfiles();
      await loadAvatarUrl();
      await loadNamaLengkap();
    } catch (e) {
      handleError(e);
    }
  }

  Future<void> loadNamaLengkap() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? nama = prefs.getString('nama_lengkap');
    namaLengkap.value = nama ?? 'User'; // Update nilai reaktif
  }
Future<void> loadAvatarUrl() async {
  isLoading.value = true; // Set loading sebelum delay
  await Future.delayed(const Duration(seconds: 10)); // Delay 3 detik
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? avatar = prefs.getString('avatarUrl');
  avatarUrl.value = avatar ?? ''; // Update nilai reaktif avatar URL
  print('Avatar URL from SharedPreferences: ${avatarUrl.value}'); // Debugging
  isLoading.value = false; // Set loading selesai
}

  Future<void> loadProfiles() async {
    try {
      isLoading.value = true;
      var data = await _profileService.getMyAccounts(); // Panggil fungsi API
      print("Raw API Response Profile: $data"); // Lihat data mentah dari API
      if (data.isNotEmpty) {
        print(
            "Mengambil data untuk profile======================================================");
        myAccount.assignAll(data); // Masukkan data ke dalam observable
      } else {
        print(
            "Tidak Mengambil data untuk profile======================================================");
        myAccount.clear(); // Pastikan tidak ada data lama
      }
    } catch (e) {
      print("Error saat mengambil profile: $e");
    } finally {
      isLoading.value = false; // Pastikan loading selesai
    }
  }

  // Future<void> addMedicine(
  //     String pharmacyId, String name, String content, String imageUrl) async {
  //   try {
  //     isLoading.value = true;
  //     await pharmacyService.addMedicine(pharmacyId, name, content, imageUrl);
  //     await loadMedicines(pharmacyId); // Refresh the list
  //     Get.snackbar(
  //       'Sukses',
  //       'Berhasil menambahkan obat',
  //       backgroundColor: Colors.green.shade100,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Gagal menambahkan obat: ${e.toString()}',
  //       backgroundColor: Colors.red.shade100,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> updateMedicine(
  //     String medicineId, String name, String content, String imageUrl) async {
  //   try {
  //     isLoading.value = true;
  //     await pharmacyService.updateMedicine(medicineId, name, content, imageUrl);
  //     // Find and update the medicine in the local list
  //     final index = medicines.indexWhere((med) => med.id == medicineId);
  //     Get.snackbar(
  //       'Sukses',
  //       'Berhasil mengupdate obat',
  //       backgroundColor: Colors.green.shade100,
  //     );
  //     if (index != -1) {
  //       medicines[index] = Medicine(
  //         id: medicineId,
  //         name: name,
  //         content: content,
  //         imageUrl: imageUrl,
  //       );
  //       medicines.refresh(); // Notify GetX to update the UI
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Gagal mengupdate obat: ${e.toString()}',
  //       backgroundColor: Colors.red.shade100,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  // Future<void> deleteMedicine(String medicineId) async {
  //   try {
  //     isLoading.value = true;
  //     await pharmacyService.deleteMedicine(medicineId);
  //     // Remove the medicine from the local list
  //     medicines.removeWhere((med) => med.id == medicineId);
  //     Get.snackbar(
  //       'Sukses',
  //       'Berhasil menghapus obat',
  //       backgroundColor: Colors.green.shade100,
  //     );
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Gagal menghapus obat: ${e.toString()}',
  //       backgroundColor: Colors.red.shade100,
  //     );
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
}
