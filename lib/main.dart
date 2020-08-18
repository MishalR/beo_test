import 'package:flutter/material.dart';

import 'otp_validate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: OTP(),
    );
  }
}

class FormFields extends StatefulWidget {
  FormFields();
  FormFieldsState createState() => new FormFieldsState();
}




class FormFieldsState extends State<FormFields>
{


  final username = TextEditingController();
  final password1 = TextEditingController();

  Map<String,dynamic> mapValue;


  @override
  Widget build(BuildContext context) {
    return (new Container(
      margin: new EdgeInsets.symmetric(horizontal:15.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          new Form(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Card(
                    color: Colors.grey,
                    elevation: 1,
                    child: Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[

                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            title:TextFormField(
                              key: Key('username'),
                              controller: username,
                              autofocus: false,
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                  hintText : ('Enter Your Username'),
                                  hintStyle: TextStyle(color: Colors.black,),
                                  suffixIcon:  Icon(Icons.person_outline,color: Colors.black38,)),
                            ),
                          ),
                          SizedBox(height: 10.0),

                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            title: TextFormField(
                              key: Key('password'),
                              autofocus: false,
                              controller: password1,
                              obscureText: true,
                              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                                  hintText: "Enter your Password",
                                  hintStyle: TextStyle(color: Colors.black,),
                                  suffixIcon: Icon(Icons.lock_outline,color: Colors.black38,)),
                            ),
                          ),

                          SizedBox(height: 5.0,),

                          Divider(color: Colors.grey,),

                          ListTile(
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical:0),
                            title:
                            FlatButton(
                              key: Key('button'),
                              onPressed: () {

                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OTP(),
                          ),
                          );

                          print(' username:  ${username.text}');
                          print(' pass:  ${password1.text}');
                          // loginData(context);
                          },


                            ),



                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    ));
  }
}