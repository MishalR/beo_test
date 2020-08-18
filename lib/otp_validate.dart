

import 'package:flutter/material.dart';

import 'color_loader.dart';

class OTP extends StatefulWidget{

 const OTP({Key key}) : super(key: key);
  @override
  OTPState createState() => new OTPState();
}

class OTPState extends State<OTP>
    with TickerProviderStateMixin {

@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    backgroundColor: Colors.white,
    body: Center(

      child: Padding(
                padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

              InkWell(
                 key:Key('loader'),
                  onTap: (){
                     print("hello");
                  },

                     child:   ColorLoader3(
                   radius: 20.0,
                   dotRadius: 6.0,
                     ),
              
              ),
          
            SizedBox(height: 20.0,),

            Container(
              alignment: Alignment.center,
                width:360,
                height:40,
              child:Text('AUTO OTP VALIDATION IN PROGRESS...',
              style:TextStyle(color: Colors.black,fontSize: 15.0)),

            ),


                  ]
          ),
  
           ),

      ),
    
    );
  }


}