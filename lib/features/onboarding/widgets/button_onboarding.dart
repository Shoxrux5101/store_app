import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routes/routes.dart';

class ButtonOnboarding extends StatelessWidget {
  const ButtonOnboarding({super.key,});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        context.push(Routes.signUp);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        width: 341,
        height: 54,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 110),
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
