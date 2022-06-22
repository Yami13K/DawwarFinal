import 'package:flutter/material.dart';
import '../palette.dart';
import '../widgets/cluster_slider.dart';
import 'map_view.dart';
class suggestionList extends StatefulWidget {
  const suggestionList({Key key}) : super(key: key);

  @override
  State<suggestionList> createState() => _suggestionListState();
}

class _suggestionListState extends State<suggestionList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "اشخاص على طريقك",
          textAlign: TextAlign.center,
        ),
        backgroundColor: secondary,
      ),
      backgroundColor: third,
      drawer: Drawer(
          child: ListView(
          
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: third,
            ),
            child: SizedBox(
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
          ),
          ListTile(
            title: const Text('اطلب رحلة خارج الروتين' ,style: Gparagraph,),
            onTap: () {

              Navigator.push(context, MaterialPageRoute(builder: (context)=>  MapView()));
            },
          ),
        ],
      ) // Populate the Drawer in the next step.
          ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: const [
              ClusterSlider(),
              SizedBox(
                height: 30,
              ),
              ClusterSlider()
            ],
          ),
        ),
      ),
    );
  }
}
