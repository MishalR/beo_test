

import 'package:flutter/material.dart';

import 'color_loader.dart';

class OTP extends StatefulWidget{

 const OTP({Key key}) : super(key: key);
  @override
  OTPState createState() => new OTPState();
}

class OTPState extends State<OTP>
   {

@override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    return Container(
        child:Center(

      child: Padding(
                padding: const EdgeInsets.all(36.0),
          child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

              InkWell(
                 key:Key('button'),
                  onTap: (){
                   /* Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen(),
                      ),
                    );*/

                  },

                     child:   Icon(Icons.gps_fixed)

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

      ),);


  }


}