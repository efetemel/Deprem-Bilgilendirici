import 'package:deprembilgilendirici/controllers/MainController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ayarlar"),
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){MainController.instance.getQuakes();Get.back();}
        ),
      ),
      body: SafeArea(
        child: Obx(()=>SettingsList(
          sections: [
            SettingsSection(
              title: Text('Genel Ayarlar'),
              tiles: <SettingsTile>[
                SettingsTile.switchTile(
                  onToggle: (value) async{
                    MainController.instance.settingsModel.value.onlyQuakesFourAndAboveView = value;
                    MainController.instance.settingsModel.refresh();
                    await MainController.instance.settingsBox.write("settings", MainController.instance.settingsModel.value.toJson());
                  },
                  initialValue: MainController.instance.settingsModel.value.onlyQuakesFourAndAboveView,
                  leading: Icon(Icons.alarm),
                  title: Text('Sadece 4 ve üstü büyüklükleri göster'),
                ),

              ],
            ),
            SettingsSection(
              title: Text("Hakkında"),
              tiles: [
                SettingsTile(
                  title: Text("Versiyon"),
                  value: Text("0.0.1"),
                ),
                SettingsTile(
                  title: Text("Hazırlayan"),
                  value: Text("Efe Temel ERSÖZ"),
                  onPressed: (v)async {
                    await launchUrl(Uri.parse("https://github.com/efetemel"));
                  },
                )
              ],
            )
          ],
        )),
      ),
    );
  }
}
