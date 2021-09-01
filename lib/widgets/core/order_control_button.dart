import 'package:flutter/material.dart';

class OrderControlButton extends StatelessWidget {
  final Color? color;
  final Widget? icon;
  final String? title;
  final VoidCallback? onclick;

  const OrderControlButton(
      {Key? key, this.color, this.icon, this.title, this.onclick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: MaterialButton(
        onPressed: onclick,
        child: Container(
          width: width * 0.4,
          height: height * 0.2,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon!,
              const SizedBox(
                height: 10,
              ),
              Text(
                title!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
        ),
      ),
    );
  }
}
