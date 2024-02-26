import 'package:flutter/material.dart';
import 'package:inventory_app/books.dart';
import 'package:inventory_app/pen.dart';
import 'package:inventory_app/pencil.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_app/youare.dart';

class vendor extends StatefulWidget {
  const vendor({Key? key}) : super(key: key);

  @override
  State<vendor> createState() => _vendorState();
}

class _vendorState extends State<vendor> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email == '' || password == '') {
      return;
    } else {
      if (email.toLowerCase().contains('subhash')) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Error'),
              content: const Text('You are not allowed to login as vendor.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Proceed with login
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const youare()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: const EdgeInsets.all(20), // Add padding for spacing
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
                height: 20), // Add space between username and password fields
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(
                height:
                    20), // Add space between password field and login button
            ElevatedButton(
              onPressed: () {
                // Implement login functionality
                login();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.amber, // Set button color to amber
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10), // Set rounded corners
                ),
              ),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
