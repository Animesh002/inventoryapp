import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore package

class pencil extends StatefulWidget {
  const pencil({Key? key}) : super(key: key);

  @override
  State<pencil> createState() => _pencilState();
}

class _pencilState extends State<pencil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        elevation: 0,
        title: const Text(
          'Pencil Seller App',
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
                  .doc('Pencil')
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
                            DataCell(Text('Pencil')),
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
