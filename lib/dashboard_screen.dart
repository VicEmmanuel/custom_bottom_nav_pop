import 'dart:math';

import 'package:bottom_nav_001/home_screen.dart';
import 'package:bottom_nav_001/profile_screen.dart';
import 'package:flutter/material.dart';

import 'component/add_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;
  bool toggle = true;
  AnimationController? controller;
  Animation? animation;


  Alignment alignmentOne = Alignment(0.0, 0.0);
  Alignment alignmentTwo = Alignment(0.0, 0.0);
  Alignment alignmentThree = Alignment(0.0, 0.0);

  double sizeOne = 100.0;
  double sizeTwo = 100.0;
  double sizeThree = 50.0;

  void onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 350),
        reverseDuration: Duration(milliseconds: 275));

    animation = CurvedAnimation(
        parent: controller!,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeIn);

    controller?.addListener(() {
      setState(() {});
    });
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController!.dispose();
  }

  // int currentTab = 0;
  final List<Widget> screens = const [HomeScreen(), ProfileScreen()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: screens
      ),
      bottomNavigationBar:
      BottomNavigationBar(

        // backgroundColor: bottomNavColor,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "",
          ),
        ],
        unselectedItemColor: Colors.black12.withOpacity(0.7),
        selectedItemColor: Colors.deepOrangeAccent,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        // selectedLabelStyle: TextStyle(fontSize: 12),
        // unselectedFontSize: 9,
        showUnselectedLabels: false,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),

      floatingActionButton:  toggleButton(),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,//
    );
  }

  itemsDisplay({
    required Alignment alignment,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child:  AnimatedAlign(
        duration:
        toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 400),
        alignment: alignment,
        child: toggle? Container(): AnimatedContainer(
          duration:
          toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 400),
          curve: toggle ? Curves.easeIn : Curves.easeOut,
          height: sizeOne,
          width: sizeOne,
          decoration: BoxDecoration(
            color: Colors.black87,
            borderRadius: BorderRadius.circular(40),
          ),
          child: Icon(
            Icons.message,
            color: Colors.white,
          ),
        ),
      ),
    );
  }


  toggleButton(){
    return  Container(
      // color: Colors.red,
      height: 250,
      width: 250,
      child: Stack(
        children: [
          ///Display Contents
          ///

          itemsDisplay(alignment: alignmentOne),
          itemsDisplay(alignment: alignmentTwo),
          itemsDisplay(alignment: alignmentThree),

          /// ButtonSection
          Align(
            alignment: Alignment.bottomCenter,
            child: Transform.rotate(
              angle: animation!.value * pi * (3 / 4),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 375),
                margin: EdgeInsets.symmetric(vertical: 3),
                height: toggle ? 50 : 45,
                width: toggle ? 50 : 45,
                decoration: BoxDecoration(
                    color: Colors.deepOrangeAccent,
                    borderRadius: BorderRadius.circular(60)),
                child: Material(
                  color: Colors.transparent,
                  child: IconButton(
                    splashColor: Colors.black54,
                    splashRadius: 31,
                    onPressed: () {
                      setState(() {
                        if (toggle) {
                          toggle = !toggle;
                          controller!.forward();
                          Future.delayed(Duration(milliseconds: 50), () {
                            alignmentOne = Alignment(-0.7, 0.30);
                          });
                          Future.delayed(Duration(milliseconds: 100), () {
                            alignmentTwo = Alignment(0.0, -0.2);
                          });

                          Future.delayed(Duration(milliseconds: 200), () {
                            alignmentThree = Alignment(0.7, 0.30);
                          });
                        } else {
                          toggle = !toggle;
                          controller!.reverse();
                          alignmentOne = Alignment(0.0, 1);
                          alignmentTwo = Alignment(0.0,  1);
                          alignmentThree = Alignment(0.0,  1);
                        }
                      });
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
