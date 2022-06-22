import 'package:flutter/material.dart';
import '../palette.dart';
class profileCard extends StatelessWidget {
  const profileCard() : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 300,
      child: Card(
        child: Row(
          children: [
            Container(
              height: 150,
              width: 180,
              child: Center(
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70.0,
                  backgroundImage: AssetImage("assets/images/profileicon.png"),
                ),
              ),
            ),
            Container(
              height: 150,
              width: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("الاسم", style:Gparagraph),
                    Text("نوع السيارة", style:Gparagraph),
                    Text("رقم السيارة", style:Gparagraph),
                    Text("رقم الموبايل" , style: Gparagraph)               
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
