import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

enum AnimationToPlay {
  Activate,
  Deactivate,
  CameraTapped,
  PulseTapped,
  ImageTapped
}

class SmartFlareAnimation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _SmartFlareAnimationState();
  }
}

class _SmartFlareAnimationState extends State<SmartFlareAnimation> {
  static const double AnimationWidth = 295.0;
  static const double AnimationHeight = 251.0;

  final FlareControls animationControls = FlareControls();

  AnimationToPlay _animationToPlay = AnimationToPlay.Deactivate;
  AnimationToPlay _lastPlayedAnimation;
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: AnimationWidth,
      height: AnimationHeight,
      child: GestureDetector(
        onTapUp: (tapInfo) {
          var localouchPosition = (context.findRenderObject() as RenderBox)
              .globalToLocal(tapInfo.globalPosition);
          // 点击位置
          var topHalfTouched = localouchPosition.dy < AnimationHeight / 2;
          var leftSideTouched = localouchPosition.dx < AnimationWidth / 3;
          var rightSideTouched =
              localouchPosition.dx > (AnimationWidth / 3) * 2;
          var middleTouched = !leftSideTouched && !rightSideTouched;

          // if (topHalfTouched) {}
          if (leftSideTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.CameraTapped);
          } else if (middleTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.PulseTapped);
          } else if (rightSideTouched && topHalfTouched) {
            _setAnimationToPlay(AnimationToPlay.ImageTapped);
          } else {
            if (isOpen) {
              _setAnimationToPlay(AnimationToPlay.Deactivate);
            } else {
              _setAnimationToPlay(AnimationToPlay.Activate);
            }
            isOpen = !isOpen;
          }
        },
        child: FlareActor(
          "assets/button-animation.flr",
          controller: animationControls,
          animation: _getAnimationName(_animationToPlay),
        ),
      ),
    );
  }

  String _getAnimationName(AnimationToPlay animationToPlay) {
    switch (animationToPlay) {
      case AnimationToPlay.Activate:
        return "activate";
      case AnimationToPlay.Deactivate:
        return "deactivate";
      case AnimationToPlay.CameraTapped:
        return "camera_tapped";
      case AnimationToPlay.PulseTapped:
        return "pulse_tapped";
      case AnimationToPlay.ImageTapped:
        return "image_tapped";
      default:
        return "deactivate";
    }
  }

  void _setAnimationToPlay(AnimationToPlay animationToPlay){
    var isTappedAnimation = _getAnimationName(animationToPlay).contains("_tapped");
    if(isTappedAnimation && _lastPlayedAnimation == AnimationToPlay.Deactivate){
      return ;
    }
    animationControls.play(_getAnimationName(animationToPlay));
    _lastPlayedAnimation = animationToPlay;
  }
}
