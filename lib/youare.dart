import 'package:flutter/material.dart';
import 'package:inventory_app/books.dart';
import 'package:inventory_app/pen.dart';
import 'package:inventory_app/pencil.dart';

class youare extends StatefulWidget {
  const youare({super.key});

  @override
  State<youare> createState() => _youareState();
}

class _youareState extends State<youare> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Navigator(
        // Wrap MaterialApp with Navigator
        onGenerateRoute: (settings) {
          return MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.amber,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                ),
              ),
              body: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/login.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello! You are?',
                        style: TextStyle(
                          fontSize: 24, // Adjust the font size here
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                        textAlign: TextAlign.center, // Align the text to center
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const pen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Login As Pen Vendor'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Add signup button functionality
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const pencil()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Login As Pencil Vendor'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const books()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: const Text('Login As Books Vendor'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
