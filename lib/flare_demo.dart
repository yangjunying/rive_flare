// import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:rive_flare/smart_flare_animation.dart';
import 'package:smart_flare/smart_flare.dart';

class FareDemo extends StatefulWidget {
  @override
  _FareDemoState createState() => _FareDemoState();
}

class _FareDemoState extends State<FareDemo> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    var animationHeight = 251.0;
    var animationWidth = 295.0;

    var animationWithThirds = animationWidth / 3;
    var halfAnimationHeight = animationHeight / 2;

    var activateAreas = [
      ActiveArea(
        area: Rect.fromLTWH(0, 0, animationWithThirds, halfAnimationHeight),
        // debugArea: true,
        animationName: "camera_tapped",
        guardComingFrom: ['deactivate'],
        // animationsToCycle: ["camera_tapped"],
        onAreaTapped: (){
          print("camera_tapped");
        }
      ),
      ActiveArea(
        area: Rect.fromLTWH(animationWithThirds, 0, animationWithThirds, halfAnimationHeight),
        // debugArea: true,
        animationName: "pulse_tapped",
        guardComingFrom: ['deactivate'],
        // animationsToCycle: ["camera_tapped"],
        onAreaTapped: (){
          print("pulse_tapped");
        }
      ),
      ActiveArea(
        area: Rect.fromLTWH(animationWithThirds*2, 0, animationWithThirds, halfAnimationHeight),
        // debugArea: true,
        animationName: "image_tapped",
        guardComingFrom: ['deactivate'],
        // animationsToCycle: ["camera_tapped"],
        onAreaTapped: (){
          print("image_tapped");
        }
      ),
      ActiveArea(
          area: Rect.fromLTWH(
              0, animationHeight / 2, animationWidth, animationHeight / 2),
          // debugArea: true,
          animationsToCycle: ["activate", "deactivate"],
          onAreaTapped: () {
            print("Toggle animation!");
          }),
    ];
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 102, 18, 222),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: SmartFlareActor(
          width: animationWidth,
          height: animationHeight,
          filename: "assets/button-animation.flr",
          startingAnimation: "deactivate",
          activeAreas: activateAreas,
        ),
      ),
    );
  }
}
