import 'package:expiration_inventory_tracker_app/model/menu_data_model.dart';
import 'package:flutter/material.dart';

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
            return Container(
              height: 200,
              child: Card(
                semanticContainer: true,
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(15.0)),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: double.maxFinite,
                        child: Image.asset(menu[index].url),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(menu[index].title),
                    ],
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
