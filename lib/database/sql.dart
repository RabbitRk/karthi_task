import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';

import 'db_helper.dart';
import 'model.dart';

class sql extends StatelessWidget
 {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: StudentPage(),
    );
  }
}

class StudentPage extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<StudentPage> {
  late String conn;
  late String conn1;

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  late Future<List<Student>> students;
  late String _studentName;
  bool isUpdate = false;
  late int studentIdForUpdate;
  late DBHelper dbHelper;
  final _studentNameController = TextEditingController();


  @override
  void initState() {
    super.initState();
    initConnectivity();

    dbHelper = DBHelper();
    refreshStudentList();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if(_connectionStatus=="mobile"){
      conn1="is network connected";
    }
    else{
      conn1="is offline mode";
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
      return;
    }

    void showInSnackBar(String message) {

      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("insert data")));
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }


  refreshStudentList() {
    setState(() {
      students = dbHelper.getStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite in Flutter'),
      ),
      body:

      Column(

        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Text('Connection Status: ${_connectionStatus.toString()}'),
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    // validator: (value) {
                    //   if (value.isEmpty) {
                    //     return 'Please Enter Student Name';
                    //   }
                    //   return null;
                    // },
                    onSaved: (value) {
                      _studentName = value!;
                    },
                    controller: _studentNameController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.purple,
                                width: 2,
                                style: BorderStyle.solid)),
                        // hintText: "Student Name",
                        labelText: "Enter your Name",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.purple,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.purple,
                child: Text(
                  (isUpdate ? 'UPDATE' : 'ADD'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));

                  if (isUpdate) {
                    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));

                    if (_formStateKey.currentState!.validate()) {
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));

                      _formStateKey.currentState!.save();
                      dbHelper
                          .update(Student(studentIdForUpdate, _studentName))
                          .then((data) {
                        setState(() {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));

                          isUpdate = false;
                        });
                      });
                    }
                  } else {



                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();
                      _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));
                      dbHelper.add(Student(0, _studentName));
                    }
                  }
                  _studentNameController.text = '';
                  _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text("Insert data successfully")));
                  // refreshStudentList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.blueAccent,
                child: Text(
                  (isUpdate ? 'CANCEL UPDATE' : 'Retreive'),
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  refreshStudentList();
                  setState(() {
                    isUpdate = false; //
                    refreshStudentList();
                    studentIdForUpdate = 0;
                  });
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: students,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // return generateList("");
                }
                // if (snapshot.data == null || snapshot.d == 0) {
                //   return Text('No Data Found');
                // }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('NAME'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: students
              .map(
                (student) => DataRow(
              cells: [
                DataCell(
                  Text(student.name),
                  onTap: () {
                    setState(() {
                      isUpdate = true;
                      studentIdForUpdate = student.id;
                    });
                    _studentNameController.text = student.name;
                  },
                ),
                DataCell(
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.delete(student.id);
                      refreshStudentList();
                    },
                  ),
                )
              ],
            ),
          )
              .toList(),
        ),
      ),
    );
  }
}