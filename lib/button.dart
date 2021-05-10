import 'package:flutter/material.dart';

class ThemeButton extends StatefulWidget {
  final String text;
  final Color color;
  final Function ontap;

  const ThemeButton(
      {Key key,
      @required this.text,
      @required this.ontap,
      @required this.color})
      : super(key: key);

  @override
  _ThemeButtonState createState() => _ThemeButtonState();
}

class _ThemeButtonState extends State<ThemeButton>
    with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
      lowerBound: 0.0,
      upperBound: 0.2,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
     _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child: Transform.scale(
        scale: _scale,
        child: _animatedButton(),
      ),
    );
  }

  Widget _animatedButton() {
    return RawButton(
      color: widget.color,
      text: Text(
        widget.text,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    widget.ontap();
    _controller.reverse();
  }
}

class RawButton extends StatefulWidget {
  final Text text;
  final Color color;
  // final Function ontap;

  const RawButton({
    Key key,
    this.text,
    this.color,
    // this.ontap,
  }) : super(key: key);

  @override
  _RawButtonState createState() => _RawButtonState();
}

class _RawButtonState extends State<RawButton> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CustomPaint(
          size: Size(250, 100),
          painter: RPSCustomPainter(widget.color),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: widget.text,
        ),
      ],
      // ),
    );
  }
}

class RPSCustomPainter extends CustomPainter {
  Path path_0 = Path();
  final Color color;

  RPSCustomPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    path_0.moveTo(size.width * 0.1450000, size.height * 0.9000000);
    path_0.cubicTo(
        size.width * 0.1193500,
        size.height * 0.8730000,
        size.width * -0.0571000,
        size.height * 0.4661000,
        size.width * 0.2056946,
        size.height * 0.1449236);
    path_0.cubicTo(
        size.width * 0.2306500,
        size.height * 0.1581000,
        size.width * 0.8383500,
        size.height * 0.3081000,
        size.width * 0.8084692,
        size.height * 0.3105566);
    path_0.cubicTo(
        size.width * 0.9440500,
        size.height * 0.4456000,
        size.width * 0.9611500,
        size.height * 0.7605000,
        size.width * 0.9000000,
        size.height * 0.8000000);
    path_0.cubicTo(
        size.width * 0.8873000,
        size.height * 0.8294000,
        size.width * 0.7257500,
        size.height * 0.8062000,
        size.width * 0.1450000,
        size.height * 0.9000000);
    path_0.close();

    canvas.drawShadow(path_0, color, 2.5, true);
    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool hitTest(Offset position) {
    bool hit = path_0.contains(position);
    return hit;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
