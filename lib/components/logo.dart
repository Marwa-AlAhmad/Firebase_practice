import 'package:flutter/material.dart';

class CostumLogoOuth extends StatelessWidget {
  const CostumLogoOuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
                   child: Container(
                    decoration: BoxDecoration(
                      color:Colors.grey[200],
                      borderRadius: BorderRadius.circular(50)
                    ),
                     child: ClipRRect(
                        borderRadius: BorderRadiusGeometry.circular(60),
                        child: Image.asset("images/logopic.jpg",
                        width: 120,
                        height: 120,),
                      ),
                   ),
                 );
  }
}