import 'package:flutter/material.dart';
import 'package:forpionifty/controller/signIn.dart';
import 'package:get/get.dart';

class edit extends StatefulWidget {
  // const edit({Key? key}) : super(key: key);

  String name, phone;
  edit({
    Key? key,
    required this.name,
    required this.phone,

    // this.userindex,
  }) : super(key: key);
  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  SignInController _controller = Get.find<SignInController>();
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
  // String? name;
  var phone = "";
  var name = ""; // var secondname;
  final _studentname = TextEditingController();
  // final _secondname = TextEditingController();
  // final _phone = TextEditingController();
  final _studentphone = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  @override
  void initState() {
    _studentname.text = widget.name;
    _studentphone.text = widget.phone;
  }

  @override
  Widget build(BuildContext context) {
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
                    controller: _studentname,
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
                // Container(
                //   margin: EdgeInsets.all(10),
                //   child: TextFormField(
                //     keyboardType: TextInputType.name,
                //     // controller: _secondname,
                //     autofocus: false,
                //     onChanged: (value) => {},
                //     decoration: const InputDecoration(
                //         labelText: "second name:",
                //         floatingLabelBehavior: FloatingLabelBehavior.auto,
                //         border: OutlineInputBorder()),
                //     validator: (value) {
                //       if (value == null || value.isEmpty) {
                //         return "Please enter the second name";
                //       }
                //     },
                //   ),
                // ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: _studentphone,
                    autofocus: false,
                    onChanged: (value) => {},
                    decoration: const InputDecoration(
                        labelText: "Phone:",
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder()),
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length < 10) {
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
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                              _controller.updateNameandPhone(
                                  name: _studentname.text,
                                  phone: _studentphone.text);
                            }
                          },
                          child: const Text("Update")),
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
