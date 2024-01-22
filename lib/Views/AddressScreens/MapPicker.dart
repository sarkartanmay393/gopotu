import 'package:flutter/material.dart';

class MapPickerController {
  Function? mapMoving;
  Function? mapFinishedMoving;
}

class MapPicker extends StatefulWidget {
  final Widget? child;
  final Widget? iconWidget;
  final bool? showDot;
  final MapPickerController? mapPickerController;

  MapPicker(
      {@required this.mapPickerController,
      @required this.iconWidget,
      this.showDot = true,
      @required this.child});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    if (widget.mapPickerController != null) {
      widget.mapPickerController!.mapMoving = mapMoving;
      widget.mapPickerController!.mapFinishedMoving = mapFinishedMoving;
    }
  }

  void mapMoving() {
    if (!animationController!.isCompleted ||
        !animationController!.isAnimating) {
      animationController!.forward();
    }
  }

  void mapFinishedMoving() {
    animationController!.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment(0, 0),
      children: [
        widget.child!,
        Positioned(
          top: (MediaQuery.of(context).size.height - 215 - 50) / 2,
          right: (MediaQuery.of(context).size.width - 50) / 2,
          child: AnimatedBuilder(
              animation: animationController!,
              builder: (context, snapshot) {
                return Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Transform.translate(
                        offset: Offset(0, -10 * animationController!.value),
                        child: widget.iconWidget,
                      ),
                      if (widget.showDot!)
                        Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(5)),
                        )
                    ],
                  ),
                );
              }),
        ),
      ],
    );
  }
}
