import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key,});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        width: 341,
        height: 54,
        child: Center(
          child: Row(
            children: [
              Text('Get Started',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 16,color: Colors.white),),
              Icon(Icons.arrow_forward,color: Colors.white,),
            ],
          ),
        ),
      ),
    );
  }
}
