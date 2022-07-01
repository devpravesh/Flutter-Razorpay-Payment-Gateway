import 'package:flutter/material.dart';

class edit extends StatefulWidget {
  // const edit({Key? key}) : super(key: key);
  var userindex;
  // String name, phone;
  // edit({
  //   Key? key,
  //   required this.name,
  //   required this.phone,
  //   this.userindex,
  // }) : super(key: key);
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  // Future updateuser({
  //   required String name,
  //   phone,
  // }) async {
  //   await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(widget.userindex)
  //       .update({
  //     'firstname': name,
  //     'Phone': phone,
  //   });
  // }
  String? name;
  var phone;
  var secondname;
  final _firstname = TextEditingController();
  final _secondname = TextEditingController();
  final _phone = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // _firstname.text = name!;
    // _secondname.text = secondname;
    // _phone.text = phone;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Details'),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Form(
            key: _formkey,
            child:
                // padding: EdgeInsets.all(10),
                Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    // controller: _firstname,
                    autofocus: false,
                    onChanged: (value) => {},
                    decoration: const InputDecoration(
                        labelText: 'Name:',
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter a name";
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    // controller: _secondname,
                    autofocus: false,
                    onChanged: (value) => {},
                    decoration: const InputDecoration(
                        labelText: "second name:",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter the second name";
                      }
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    // controller: _phone,
                    autofocus: false,
                    onChanged: (value) => {},
                    decoration: const InputDecoration(
                        labelText: "Phone:",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter 10 digit no.";
                      }
                    },
                  ),
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                          onPressed: () {}, child: const Text("Update")),
                      // ElevatedButton(onPressed: (){}, child: child)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
