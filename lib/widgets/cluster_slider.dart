import 'package:flutter/material.dart';
import 'package:untitled/screens/CreatProfile.dart';
import '../palette.dart';
import 'package:carousel_slider/carousel_slider.dart';
import './profile_card.dart';

class ClusterSlider extends StatefulWidget {
  const ClusterSlider({Key key}) : super(key: key);

  @override
  State<ClusterSlider> createState() => _ClusterSliderState();
}

class _ClusterSliderState extends State<ClusterSlider> {
  List<int> list = [1, 2, 3, 4, 5];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('اشخاص يذهبون من المهاجرين الى كندا بشكل يومي',style: Wparagraph,),
        CarouselSlider(
          options: CarouselOptions(
            autoPlay: true,
            enlargeCenterPage: true,
          ),
          items: list
                .map((item) => profileCard())
                .toList(),
        ),
      ],
    );
  }
}
