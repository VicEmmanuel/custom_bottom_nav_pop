import 'dart:math';

import 'package:flutter/material.dart';

class AddButton extends StatefulWidget  {
  const AddButton({super.key});

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton>  with SingleTickerProviderStateMixin{

  bool toggle = true;
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Alignment alignmentOne = Alignment(0.0, 0.0);
  Alignment alignmentTwo = Alignment(0.0, 0.0);
  Alignment alignmentThree = Alignment(0.0, 0.0);

  double sizeOne = 50.0;
  double sizeTwo = 50.0;
  double sizeThree = 50.0;
  @override
  Widget build(BuildContext context) {
    return  Container(
        // height: 250,
        // width: 250,
        // color: Colors.red,
        child:
        Stack(
          children: [
            ///Display Contents
            itemsDisplay(alignment: alignmentOne),
            itemsDisplay(alignment: alignmentTwo),
            itemsDisplay(alignment: alignmentThree),

            /// ButtonSection
            Align(
              alignment: Alignment.center,
              child: Transform.rotate(
                angle: animation!.value * pi * (3 / 4),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 375),
                  height: toggle ? 70 : 60,
                  width: toggle ? 70 : 60,
                  decoration: BoxDecoration(
                      color: Colors.yellow[600],
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
                              alignmentOne = Alignment(-0.7, -0.4);
                            });
                            Future.delayed(Duration(milliseconds: 100), () {
                              alignmentTwo = Alignment(0.0, -0.8);
                            });

                            Future.delayed(Duration(milliseconds: 200), () {
                              alignmentThree = Alignment(0.7, -0.4);
                            });
                          } else {
                            toggle = !toggle;
                            controller!.reverse();
                            alignmentOne = Alignment(0.0, 0.0);
                            alignmentTwo = Alignment(0.0, 0.0);
                            alignmentThree = Alignment(0.0, 0.0);
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





  itemsDisplay({
    required Alignment alignment,
  }) {
    return AnimatedAlign(
      duration:
      toggle ? Duration(milliseconds: 275) : Duration(milliseconds: 400),
      alignment: alignment,
      child: AnimatedContainer(
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
    );
  }
}
