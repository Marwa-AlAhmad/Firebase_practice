import 'package:flutter/material.dart';

class CostumButton extends StatelessWidget {

  final void Function()? onPressed;
  final String title;
  const CostumButton({super.key, this.onPressed, required this.title});

  @override
  Widget build(BuildContext context) {
    return 
              MaterialButton(
                height: 60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)
                ),
                    color:Colors.pink[300],
                    onPressed: onPressed,
                    child:Text(title,style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white))
                  );
  }
}

//style:TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white)