import 'package:flutter/material.dart';

class Formvalid_page extends StatelessWidget {
  const Formvalid_page({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    const appTitle = 'Form Validation';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  bool _value = false;
  bool value = false;
  String dropdownValue = 'One';
  TextEditingController dateCtl = TextEditingController();


  int val = -1;

  var arguments;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          RadioListTile(

            value: 1,
            groupValue: val,
            onChanged: (value) {
              setState(() {
                val = value as int;
                _value = true;

              });
            },
            title: Text("Radio"),),



          CheckboxListTile(

              title: const Text('check box'),
              subtitle: const Text('Flutter Checkbox.'),
              secondary: const Icon(Icons.code),
              autofocus: false,
              activeColor: Colors.green,
              checkColor: Colors.white,
              selected: _value,
              value: _value,
              onChanged: ( value) {
                setState(() {
                  _value = value!;
                      (bool value) {
                    if (value) {
                      return null;
                    } else {
                      return 'False!';
                    }
                  };
                });

              }

          ),


          DropdownButton<String>(
            value: dropdownValue,
            icon: const Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
              height: 2,
              color: Colors.deepPurpleAccent,
            ),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            items: <String>['One', 'Two', 'three', 'Four']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),


          TextFormField(
            controller: dateCtl,
            decoration: InputDecoration(
              labelText: "Date of birth",
              hintText: "Ex. Insert your dob",),
            onTap: () async{
              DateTime? date = DateTime(1900);
              FocusScope.of(context).requestFocus(new FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate:DateTime.now(),
                  firstDate:DateTime(1900),
                  lastDate: DateTime(2100));

              dateCtl.text = date!.toIso8601String();},

            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter dob';
              }
              return null;
            },


          ),


          // DatePickerDialog(
          // restorationId: 'date_picker_dialog',
          // initialEntryMode: DatePickerEntryMode.calendarOnly,
          // initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          // firstDate: DateTime(2021, 1, 1),
          // lastDate: DateTime(2022, 1, 1),
          // ),


          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}