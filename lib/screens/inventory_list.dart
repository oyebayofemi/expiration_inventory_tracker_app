import 'package:expiration_inventory_tracker_app/model/menu_data_model.dart';
import 'package:expiration_inventory_tracker_app/screens/finished_goods_list.dart';
import 'package:expiration_inventory_tracker_app/screens/mro_list.dart';
import 'package:expiration_inventory_tracker_app/screens/raw_materials_list.dart';
import 'package:expiration_inventory_tracker_app/screens/show_all_list.dart';
import 'package:expiration_inventory_tracker_app/screens/wip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventoryList extends StatelessWidget {
  const InventoryList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<MenuData> menu = [
      MenuData('Raw Materials', 'assets/raw-materials (1).png'),
      MenuData('Finished Goods', 'assets/package-box.png'),
      MenuData('Maintannce, Repair, and Operating (MRO)', 'assets/tools.png'),
      MenuData('Work in Progress(WIP)', 'assets/progress.png'),
      MenuData('Show All Items', 'assets/clipboard.png')
    ];
    return Scaffold(
      //appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: menu.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                if (menu[index].title == 'Show All Items') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAllItems(),
                      ));
                }
                if (menu[index].title == 'Raw Materials') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAllItemsRawMaterials(),
                      ));
                }
                if (menu[index].title == 'Finished Goods') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAllItemsFinishedGoods(),
                      ));
                }
                if (menu[index].title ==
                    'Maintannce, Repair, and Operating (MRO)') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAllItemsMRO(),
                      ));
                }
                if (menu[index].title == 'Work in Progress(WIP)') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowAllItemsFinishedWIP(),
                      ));
                }
              },
              child: Container(
                height: 190.h,
                child: Card(
                  semanticContainer: true,
                  shape: RoundedRectangleBorder(
                      side: BorderSide(color: Colors.grey, width: 1.w),
                      borderRadius: BorderRadius.circular(15.0.r)),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Column(
                      children: [
                        Container(
                          height: 220.h,
                          width: double.maxFinite,
                          child: Image.asset(menu[index].url),
                        ),
                        SizedBox(
                          height: 35.h,
                        ),
                        Text(menu[index].title),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
