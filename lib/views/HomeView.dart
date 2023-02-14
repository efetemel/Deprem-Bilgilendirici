import 'package:deprembilgilendirici/controllers/MainController.dart';
import 'package:deprembilgilendirici/views/SettingsView.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deprem Bilgilendirici"),
        actions:[IconButton(onPressed: (){Get.to(()=>SettingsView());}, icon: Icon(Icons.more_horiz_rounded))] ,
      ),
      body:SafeArea(
        child: Obx(()=>RefreshIndicator(child: ListView.builder(
          itemCount: MainController.instance.quakeList.value.length,
          itemBuilder: (_,int pos){
            if(MainController.instance.settingsModel.value.onlyQuakesFourAndAboveView! == true){
              if(MainController.instance.quakeList.value[pos].mag! >= 4){
                return ListTile(
                  tileColor:Colors.red,
                  trailing: Column(
                    children: [
                      Text("Büyüklük"),
                      SizedBox(height: 5),
                      Text(MainController.instance.quakeList.value[pos].mag.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                    ],
                  ),
                  title: Text(MainController.instance.quakeList.value[pos].title!),
                  subtitle:  Text(MainController.instance.quakeList.value[pos].date!),
                );
              }
              return Container();
            }
            else{
              return ListTile(
                tileColor:  MainController.instance.quakeList.value[pos].mag! >= 4 ? Colors.red : Colors.transparent,
                trailing: Column(
                  children: [
                    Text("Büyüklük"),
                    SizedBox(height: 5),
                    Text(MainController.instance.quakeList.value[pos].mag.toString(),style: TextStyle(fontWeight: FontWeight.bold),)
                  ],
                ),
                title: Text(MainController.instance.quakeList.value[pos].title!),
                subtitle:  Text(MainController.instance.quakeList.value[pos].date!),
              );
            }
          },
        ), onRefresh: ()async{
          MainController.instance.getQuakes();
        })),
      )
    );
  }
}
