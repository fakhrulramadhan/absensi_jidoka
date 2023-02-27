import 'package:absensi_jidoka/app/modules/izin/controllers/izin_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../izinpengajuanlist/views/izinpengajuanlist_view.dart';

void main() => runApp(const IzinView());

class IzinView extends StatelessWidget {
  const IzinView({super.key});

  static const String _title = 'Izin Dinas';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({super.key});

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

/// [AnimationController]s can be created with `vsync: this` because of
/// [TickerProviderStateMixin].
class _MyStatefulWidgetState extends State<MyStatefulWidget>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final IzinController pageIC = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Izin Dinas'),
        bottom: TabBar(
          controller: _tabController,
          tabs: <Widget>[
            const Tab(
              //icon: Icon(Icons.notes),
              text: "Pengajuan",
            ),
            StreamBuilder<Object>(
                stream: pageIC.streamUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.none) {
                    return const Center(
                      child: Text("No Connection Available"),
                    );
                  }
                  return const Tab(
                    icon: Icon(Icons.check),
                  );
                }),
            const Tab(
              icon: Icon(Icons.brightness_5_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          Center(
            //child: Text("Pengajuan Izin Dinas"),
            child: IzinpengajuanlistView(),
          ),
          Center(
            child: Text("Persetujuan Izin Dinas"),
          ),
          Center(
            child: Text("It's sunny here"),
          ),
        ],
      ),
    );
  }
}
