import 'package:expiration_inventory_tracker_app/api/notification_api.dart';
import 'package:expiration_inventory_tracker_app/screens/home_page.dart';
import 'package:expiration_inventory_tracker_app/services/database.dart';
import 'package:expiration_inventory_tracker_app/shared/clear_form_field_decoration.dart';
import 'package:expiration_inventory_tracker_app/shared/toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String userID = FirebaseAuth.instance.currentUser!.uid;
  String? name, selectedQuantityType, selectedCategory;
  int quantity = 0;
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;
  int id = 0;

  DateTime? date, dates;
  var myFormat = DateFormat('d-MM-yyyy');
  var dateValue = '';

  final List<String> category = [
    'select a category',
    'Raw Materials',
    'Finished Goods',
    'Maintenance, Repair, and Operating (MRO)',
    'Work In Progress (WIP)'
  ];
  final List<String> _quantityType = [
    'select a type',
    'Cartons',
    'Pcs',
    'Crates',
  ];

  setDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        lastDate: DateTime(DateTime.now().year + 10, DateTime.now().month,
            DateTime.now().day));

    if (newDate == null) return;
    setState(() {
      dates = newDate;
      date = newDate.add(Duration(hours: 8));
      dateValue = '${myFormat.format(newDate)}';
      selectedDate = date!.subtract(Duration(
        days: 3,
      ));
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listenNotifications();
  }

  void listenNotifications() =>
      NotificationApi.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String? payload) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => HomePage(),
    ));
  }

  DateTime? selectedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Inventory',
                  style: TextStyle(
                      fontFamily: 'Poppins',
                      letterSpacing: 2,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Product Name',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'Poppins',
                  ),
                  onChanged: (value) => name = value,
                  //autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) => value!.isEmpty
                      ? 'Product Name Field cant be empty'
                      : null,
                  keyboardType: TextInputType.text,
                  decoration: cleartextFormDecoration()
                      .copyWith(hintText: 'Enter product name here..'),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Quantity Type',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  // width: 40,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: selectedQuantityType,
                        items: _quantityType.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value.toString(),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedQuantityType = newValue;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Quantity',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        quantity++;
                      }),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.orange,
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Text('$quantity'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () => setState(() {
                        quantity--;
                        if (quantity < 0) {
                          quantity = 0;
                        }
                      }),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          color: Colors.orange,
                        ),
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Product Expiry Date',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  onTap: () => setDate(context),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.orange),
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(child: Text(dateValue)),
                          Icon(
                            FontAwesomeIcons.calendarAlt,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Item Category',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  // width: 40,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.orange),
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: DropdownButton<String>(
                        underline: Container(),
                        isExpanded: true,
                        value: selectedCategory,
                        items: category.map((value) {
                          return DropdownMenuItem(
                            child: Text(value),
                            value: value.toString(),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedCategory = newValue;
                          });
                        }),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                ButtonTheme(
                  buttonColor: Colors.orange,
                  minWidth: double.infinity,
                  height: 60,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  child: RaisedButton(
                    onPressed: () async {
                      if (_formkey.currentState!.validate()) {
                        if (selectedCategory == 'select a category' ||
                            selectedQuantityType == 'select a type' ||
                            quantity == 0 ||
                            date == null) {
                          if (selectedCategory == 'select a category') {
                            showToast('Please Select a Category !!!');
                          } else if (selectedQuantityType == 'select a type') {
                            showToast('Please Select a Quantity Type !!!');
                          } else if (date == null) {
                            showToast('Please select a date !!!');
                          } else {
                            showToast('Quantity must be greater than 0 !!!');
                          }
                        } else {
                          setState(() {
                            _loading = true;
                          });
                          try {
                            NotificationApi.showScheduleNotifications(
                                id: id,
                                title: 'PRODUCT EXPIRES IN 3 DAYS!!!',
                                body:
                                    'Product $name will expire in 3 days fron now !!!',
                                payload: 'expire_$name',
                                scheduleDateTime: selectedDate!);

                            await DatabaseService(userID: userID).addItems(
                                dateValue,
                                name!,
                                selectedQuantityType!,
                                selectedCategory!,
                                quantity,
                                dates!);
                            print(selectedDate);
                            setState(() {
                              id++;
                              _loading = false;
                              dateValue = '';
                              name = ' b';
                              selectedQuantityType = 'select a type';
                              selectedCategory = 'select a category';
                              quantity = 0;
                              date = null;
                            });
                          } catch (e) {
                            setState(() {
                              _loading = false;
                            });
                            print(e.toString());
                          }
                        }
                      }
                    },
                    child: _loading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
