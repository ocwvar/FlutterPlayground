import 'package:flutter/cupertino.dart';

class SimpleClickEffect extends StatefulWidget {
  final Widget child;
  final Function() onPressed;

  const SimpleClickEffect({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SimpleClickEffectState();
}

class _SimpleClickEffectState extends State<SimpleClickEffect> {

  double _currentValue = 1.0;
  final double clickedValue = 0.3;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => _showPressedStyle(),
      onTapUp: (details) {
        _restoreIdleStyle();
        widget.onPressed.call();
      },
      onTapCancel: () => _restoreIdleStyle(),

      child: Opacity(
        opacity: _currentValue,
        child: widget.child,
      ),
    );
  }

  void _showPressedStyle() {
    setState(() {
      _currentValue = clickedValue;
    });
  }

  void _restoreIdleStyle() {
    setState(() {
      _currentValue = 1.0;
    });
  }

}