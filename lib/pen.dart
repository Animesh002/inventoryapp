import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class pen extends StatefulWidget {
  const pen({Key? key}) : super(key: key);

  @override
  State<pen> createState() => _penState();
}

class _penState extends State<pen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Pen Seller App',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder<DocumentSnapshot>(
              future: FirebaseFirestore.instance
                  .collection('inventory')
                  .doc('Pen')
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    if (snapshot.hasData && snapshot.data!.exists) {
                      var inventoryData = snapshot.data!.data()!;
                      var inventoryCount = (inventoryData
                              as Map<String, dynamic>)['selectedInventory'] ??
                          'Not available';

                      return DataTable(
                        columns: [
                          DataColumn(label: Text('Item')),
                          DataColumn(label: Text('Inventory')),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('Pen')),
                            DataCell(Text(inventoryCount.toString())),
                          ]),
                        ],
                      );
                    } else {
                      return Text('Document does not exist');
                    }
                  }
                }
              },
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
}
