import 'package:expiration_inventory_tracker_app/shared/clear_form_field_decoration.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class AddPage extends StatefulWidget {
  AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String? name, selectedQuantityType, selectedCategory;
  int quantity = 0;
  final _formkey = GlobalKey<FormState>();
  bool _loading = false;

  DateTime? date;
  var myFormat = DateFormat('d-MM-yyyy');
  var dateValue = '';

  final List<String> category = [
    'Raw Materials',
    'Finished Goods',
    'Maintenance, Repair, and Operating (MRO)',
    'Work In Progress (WIP)'
  ];
  final List<String> _quantityType = [
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
      date = newDate;
      dateValue = '${myFormat.format(newDate)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
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
                  onChanged: (value) => this.name = value,
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
                      if (_formkey.currentState!.validate()) {}
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
