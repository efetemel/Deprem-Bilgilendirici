import 'package:deprembilgilendirici/Links.dart';
import 'package:deprembilgilendirici/models/QuakeModel.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../models/SettingsModel.dart';

class MainController extends GetxController{

  static MainController instance = Get.find();
  Dio dio = Dio();
  RxList<QuakeModel> quakeList = RxList();
  var settingsBox = GetStorage("Settings");
  var settingsModel = SettingsModel().obs;

  MainController(){
    readSettings();
    getQuakes();
  }

  Future readSettings()async{
    await GetStorage.init();
    var response = await settingsBox.read("settings");
    if(response != null){
      settingsModel.value = SettingsModel.fromJson(response);
    }
    else{
      settingsModel.value = SettingsModel(
          onlyQuakesFourAndAboveView:true
      );
      await settingsBox.write("settings", settingsModel.value.toJson());
    }
  }

  Future getQuakes()async{
    quakeList.clear();
    var response = await dio.get(Links.lastQuake);
    List x = response.data["result"];
    x.forEach((element) {
      var quake = QuakeModel.fromJson(element);
      quakeList.value.add(quake);
    });
    quakeList.refresh();
  }

}