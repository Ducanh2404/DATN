import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:project/all_imports.dart';
import 'package:project/views/admin/main.dart';

import '../../../constants.dart';

class StorageDetails extends StatefulWidget {
  const StorageDetails({
    Key? key,
  }) : super(key: key);

  @override
  State<StorageDetails> createState() => _StorageDetailsState();
}

class _StorageDetailsState extends State<StorageDetails> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerEmail = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  initState() {
    User? user = auth.currentUser;
    if (user != null) {
      _controllerName.text = user.displayName!;
      _controllerEmail.text = user.email!;
    }
    super.initState();
  }

  Future<void> signOut() async {
    try {
      await auth.signOut();
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Đăng xuất thành công'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(),
          ));
    } catch (e) {
      print(' $e');
    }
  }

  Future<void> updateUserInformation(String newName) async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        await user.updateDisplayName(newName);
        await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: user.email)
            .get()
            .then(
          (QuerySnapshot query) {
            query.docs.forEach((doc) {
              doc.reference.update({
                'name': newName,
              });
            });
          },
        );
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Cập nhật thông tin thành công'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Admin(),
            ));
      }
    } catch (e) {
      print('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Thông tin tài khoản",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Tên',
                  ),
                  controller: _controllerName,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  controller: _controllerEmail,
                ),
              ),
            ],
          ),
          SizedBox(height: defaultPadding),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    updateUserInformation(_controllerName.text);
                  },
                  child: Text('Cập Nhật')),
              ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red)),
                  onPressed: () {
                    signOut();
                  },
                  child: Text(
                    'Đăng Xuất',
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          ),
          SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
