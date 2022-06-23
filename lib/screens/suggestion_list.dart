import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../constants.dart';





class suggestions extends StatefulWidget {
  @override
  _suggestionsState createState() => _suggestionsState();
}

class _suggestionsState extends State<suggestions> {
  final CategoriesScroller categoriesScroller = const CategoriesScroller();
  ScrollController controller = ScrollController();
  bool closeTopContainer = false;
  double topContainer = 0;

  List<Widget> itemsData = [];

  void getPostsData() {
    List<dynamic> responseList = Dummy;
    List<Widget> cluster_1 = [];
    List<Widget> cluster_2 = [];
    List<Widget> cluster_3 = [];
    List<Widget> cluster_4 = [];
    List<Widget> cluster_5 = [];

    responseList.forEach((post) {
      cluster_1.add(container(post));
    });
    setState(() {
      responseList = Dummy;
    });

  }

  Container container(post) {
    return Container(
        height: 160,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
        decoration: BoxDecoration(borderRadius: const BorderRadius.all(const Radius.circular(20.0)), color: Colors.white, boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(100), blurRadius: 10.0),
        ]),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 10, 10 ,10),
          child: Row(
            textDirection: TextDirection.rtl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        post["name"],
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                      const Text(
                        "    :الاسم",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),

                    ],
                  ),

                  Row(
                    children: [
                      Text(
                        "${post["plate"]}",

                        style: const TextStyle(fontSize: 17, color: Colors.green ),
                                                  textAlign: TextAlign.end,

                      ),
                      const Text(
                        "  :اللوحة",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                    ],
                  ),

                  Row(
                    children: [

                      Text(
                        post["brand"],
                        style: const TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                      const Text(
                        "  :الموديل",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,0, 22, 0),
                    child: Row(

                      children: [
                        Text(
                          "${post["phone"]}",

                          style: const TextStyle(fontSize: 17, color: Colors.green ),
                                                    textAlign: TextAlign.end,

                        ),
                        const Text(
                          "  :الجوال",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.end,

                        ),
                      ],
                    ),
                  ),

                ],
              ),
              SizedBox(
                width: 150,
                child: Image.asset(
                  "assets/faces/${post["image"]}",
                  height: double.infinity,
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    super.initState();
    getPostsData();
    controller.addListener(() {

      double value = controller.offset/119;

      setState(() {

        topContainer = value;
        closeTopContainer = controller.offset > 50;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double categoryHeight = size.height*0.30;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          leading: const Icon(
            Icons.menu,
            color: Colors.black,
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.person, color: Colors.black),
              onPressed: () {},
            )
          ],
        ),
        body: SizedBox(
          height: size.height,
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const <Widget>[
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: closeTopContainer?0:1,
                child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: size.width,
                    alignment: Alignment.topCenter,
                    height: closeTopContainer?0:categoryHeight,
                    child: categoriesScroller),
              ),
              Expanded(
                  child: ListView.builder(
                      controller: controller,
                      itemCount: itemsData.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        double scale = 1.0;
                        if (topContainer > 0.5) {
                          scale = index + 0.5 - topContainer;
                          if (scale < 0) {
                            scale = 0;
                          } else if (scale > 1) {
                            scale = 1;
                          }
                        }
                        return Opacity(
                          opacity: scale,
                          child: Transform(
                            transform:  Matrix4.identity()..scale(scale,scale),
                            alignment: Alignment.bottomCenter,
                            child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,
                                child: itemsData[index]),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesScroller extends StatelessWidget {
   const CategoriesScroller();

  @override
  Widget build(BuildContext context) {
    final double categoryHeight = MediaQuery.of(context).size.height * 0.30 - 50;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      scrollDirection: Axis.horizontal,
      child: Container(

        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: FittedBox(
          fit: BoxFit.fill,
          alignment: Alignment.topCenter,
          child: Row(
            textDirection: TextDirection.ltr,
            children: <Widget>[
              Container(
                width: 150,
                margin: const EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.blue.shade400, borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const <Widget>[
                      Text(
                        "انماط يوم السبت\nمن ابو رمانة الى المهاجرين",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 شخص مشترك",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                                                  textAlign: TextAlign.end,

                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.lightBlueAccent.shade400, borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      textDirection: TextDirection.rtl,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "انماط يوم الاحد\nمن المهاجرين الى مشروع دمر",
                          style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.start,

                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "20 شخص مشترك",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                                                    textAlign: TextAlign.start,

                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.teal.shade400, borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textDirection: TextDirection.rtl,
                    children: const <Widget>[
                      Text(
                        "انماط يوم الاثنين\nمن المالكي الى المزة",
                        style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 شخص مشترك",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        textAlign: TextAlign.end,

                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 20),
                  height: categoryHeight,
                  decoration: BoxDecoration(color: Colors.purple.shade400, borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const <Widget>[
                        Text(
                          "انماط يوم الثلاثاء\n من المزة الى حسر السيد الرئيس",
                          style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.end,

                        ),
                        SizedBox(
                          height: 11,
                        ),
                        Text(
                          "20 شخص مشترك",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: (){},
              ),
              Container(
                width: 150,
                margin: const EdgeInsets.only(right: 20),
                height: categoryHeight,
                decoration: BoxDecoration(color: Colors.deepPurple.shade400, borderRadius: const BorderRadius.all(const Radius.circular(20.0))),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        "انماط يوم الاربعاء\n من المزة الى جسر السيد الرئيس",
                        style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
                                                  textAlign: TextAlign.end,

                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "20 شخص مشترك",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                                                  textAlign: TextAlign.end,

                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
