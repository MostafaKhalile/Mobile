import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtime/Helpers/localization/app_localizations_delegates.dart';

class PulsingFloatActionButton extends StatefulWidget {
  const PulsingFloatActionButton(
      {Key? key,
      required this.show,
      required this.onPressed,
      required this.rotatingController})
      : super(key: key);
  final bool show;
  final VoidCallback onPressed;
  final AnimationController rotatingController;

  @override
  _PulsingFloatActionButtonState createState() =>
      _PulsingFloatActionButtonState();
}

class _PulsingFloatActionButtonState extends State<PulsingFloatActionButton>
    with TickerProviderStateMixin {
  final Tween<double> doubleArrowRotatingController = Tween<double>(
    begin: 0,
    end: 0.5,
  );
  bool selected = false;
  late AnimationController _doubleArrowsModalAnimator;
  late AnimationController _pulsingAnimationController;
  late Animation _animation;

  @override
  void initState() {
    _pulsingAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _pulsingAnimationController.repeat(reverse: true);
    _animation =
        Tween(begin: 2.0, end: 10.0).animate(_pulsingAnimationController)
          ..addListener(() {
            setState(() {});
          });
    _doubleArrowsModalAnimator = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _pulsingAnimationController.dispose();
    _doubleArrowsModalAnimator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = Theme.of(context);
    return AnimatedOpacity(
        opacity: widget.show ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 500),
        child: Container(
            height: 80.0,
            width: 80.0,
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color.fromARGB(255, 27, 28, 30),
                border: Border.all(width: 5, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      color: const Color.fromARGB(130, 237, 125, 58),
                      blurRadius: _animation.value as double,
                      spreadRadius: _animation.value as double)
                ]),
            child: FittedBox(
                child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: widget.show ? widget.onPressed : null,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RotationTransition(
                            turns: doubleArrowRotatingController
                                .animate(widget.rotatingController),
                            child: SvgPicture.asset(
                              "assets/svg/double_arrow.svg",
                              height: 12,
                            )),
                        Text(
                          AppLocalizations.of(context)!
                              .translate("control_order")!,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _theme.accentColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    )))));
  }
}
