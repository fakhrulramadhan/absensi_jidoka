import 'package:get/get.dart';

import '../modules/absensi/bindings/absensi_binding.dart';
import '../modules/absensi/views/absensi_view.dart';
import '../modules/absensi_offline/bindings/absensi_offline_binding.dart';
import '../modules/absensi_offline/views/absensi_offline_view.dart';
import '../modules/absensi_online/bindings/absensi_online_binding.dart';
import '../modules/absensi_online/views/absensi_online_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/dashboard_profile/bindings/dashboard_profile_binding.dart';
import '../modules/dashboard_profile/views/dashboard_profile_view.dart';
import '../modules/dashboard_utama/bindings/dashboard_utama_binding.dart';
import '../modules/dashboard_utama/views/dashboard_utama_view.dart';
import '../modules/detail_presensi/bindings/detail_presensi_binding.dart';
import '../modules/detail_presensi/views/detail_presensi_view.dart';
import '../modules/ganti_tema/bindings/ganti_tema_binding.dart';
import '../modules/ganti_tema/views/ganti_tema_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/izin/bindings/izin_binding.dart';
import '../modules/izin/views/izin_view.dart';
import '../modules/izin_pengajuan/bindings/izin_pengajuan_binding.dart';
import '../modules/izin_pengajuan/views/izin_pengajuan_view.dart';
import '../modules/izin_persetujuan/bindings/izin_persetujuan_binding.dart';
import '../modules/izin_persetujuan/views/izin_persetujuan_view.dart';
import '../modules/izinpengajuanlist/bindings/izinpengajuanlist_binding.dart';
import '../modules/izinpengajuanlist/views/izinpengajuanlist_view.dart';
import '../modules/izinpersetujuanlist/bindings/izinpersetujuanlist_binding.dart';
import '../modules/izinpersetujuanlist/views/izinpersetujuanlist_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/logindeny/bindings/logindeny_binding.dart';
import '../modules/logindeny/views/logindeny_view.dart';
import '../modules/notifikasi/bindings/notifikasi_binding.dart';
import '../modules/notifikasi/views/notifikasi_view.dart';
import '../modules/semua_presensi/bindings/semua_presensi_binding.dart';
import '../modules/semua_presensi/views/semua_presensi_view.dart';
import '../modules/tambah_pegawai/bindings/tambah_pegawai_binding.dart';
import '../modules/tambah_pegawai/views/tambah_pegawai_view.dart';
import '../modules/update_profile/bindings/update_profile_binding.dart';
import '../modules/update_profile/views/update_profile_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI,
      page: () => const AbsensiView(),
      binding: AbsensiBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_UTAMA,
      page: () => DashboardUtamaView(),
      binding: DashboardUtamaBinding(),
    ),
    GetPage(
      name: _Paths.LOGINDENY,
      page: () => const LogindenyView(),
      binding: LogindenyBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI_ONLINE,
      page: () => const AbsensiOnlineView(),
      binding: AbsensiOnlineBinding(),
    ),
    GetPage(
      name: _Paths.ABSENSI_OFFLINE,
      page: () => const AbsensiOfflineView(),
      binding: AbsensiOfflineBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_PROFILE,
      page: () => DashboardProfileView(),
      binding: DashboardProfileBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PROFILE,
      page: () => UpdateProfileView(),
      binding: UpdateProfileBinding(),
    ),
    GetPage(
      name: _Paths.TAMBAH_PEGAWAI,
      page: () => const TambahPegawaiView(),
      binding: TambahPegawaiBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PRESENSI,
      page: () => DetailPresensiView(),
      binding: DetailPresensiBinding(),
      children: [
        GetPage(
          name: _Paths.DETAIL_PRESENSI,
          page: () => DetailPresensiView(),
          binding: DetailPresensiBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SEMUA_PRESENSI,
      page: () => const SemuaPresensiView(),
      binding: SemuaPresensiBinding(),
    ),
    GetPage(
      name: _Paths.GANTI_TEMA,
      page: () => const GantiTemaView(),
      binding: GantiTemaBinding(),
    ),
    GetPage(
      name: _Paths.IZIN,
      page: () => const IzinView(),
      binding: IzinBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_PENGAJUAN,
      page: () => IzinPengajuanView(),
      binding: IzinPengajuanBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_PERSETUJUAN,
      page: () => const IzinPersetujuanView(),
      binding: IzinPersetujuanBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFIKASI,
      page: () => const NotifikasiView(),
      binding: NotifikasiBinding(),
    ),
    GetPage(
      name: _Paths.IZINPENGAJUANLIST,
      page: () => const IzinpengajuanlistView(),
      binding: IzinpengajuanlistBinding(),
    ),
    GetPage(
      name: _Paths.IZINPERSETUJUANLIST,
      page: () => const IzinpersetujuanlistView(),
      binding: IzinpersetujuanlistBinding(),
    ),
  ];
}
