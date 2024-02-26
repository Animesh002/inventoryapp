import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class InventoryItem {
  String itemName;
  String? selectedInventory;

  InventoryItem({required this.itemName, this.selectedInventory});
}

class Subhash extends StatefulWidget {
  const Subhash({Key? key}) : super(key: key);

  @override
  State<Subhash> createState() => _SubhashState();
}

class _SubhashState extends State<Subhash> {
  List<InventoryItem> _inventoryItems = [
    InventoryItem(itemName: 'Pen'),
    InventoryItem(itemName: 'Pencil'),
    InventoryItem(itemName: 'Books'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Subhash Stationary App',
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DataTable(
              columns: [
                DataColumn(label: Text('Items')),
                DataColumn(label: Text('Inventory')),
              ],
              rows: _inventoryItems
                  .map(
                    (item) => DataRow(cells: [
                      DataCell(Text(item.itemName)),
                      DataCell(
                        DropdownButton<String>(
                          value: item.selectedInventory,
                          onChanged: (String? value) {
                            setState(() {
                              item.selectedInventory = value;
                            });
                          },
                          items: <String?>['Low', 'Medium', 'High', null]
                              .map((String? value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value ?? 'Select Inventory',
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ]),
                  )
                  .toList(),
            ),
            SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                updateInventory();
              },
              child: const Text(
                'Update',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                // Implement logout functionality here
                Navigator.pop(context);
              },
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void updateInventory() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      for (var item in _inventoryItems) {
        await firestore.collection('inventory').doc(item.itemName).set({
          'itemName': item.itemName,
          'selectedInventory': item.selectedInventory ?? 'Low',
        });
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update Successful'),
            content: Text('Inventory has been updated successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (error) {
      print('Error updating inventory: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content:
                Text('Failed to update inventory. Please try again later.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
