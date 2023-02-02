import 'package:flutter/material.dart';

class Switcher extends StatefulWidget {
  final bool isOn;
  final Duration duration;
  final void Function() onChangeState;

  const Switcher(
      {super.key,
      required this.isOn,
      required this.duration,
      required this.onChangeState});

  @override
  State<Switcher> createState() => _SwitcherState();
}

class _SwitcherState extends State<Switcher>
    with SingleTickerProviderStateMixin {
  final double size = 80;

  late Animation<double> _sizeAnimation;
  late AnimationController _controller;

  final TweenSequence<double> _scaleTween =
      TweenSequence(<TweenSequenceItem<double>>[
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 80, end: 80 * 2.5), weight: 50.0),
    TweenSequenceItem<double>(
        tween: Tween<double>(begin: 80 * 2.5, end: 80), weight: 50.0)
  ]);

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _sizeAnimation = _scaleTween.animate(_controller);
  }

  // dismiss the animation when widget exits screen
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        widget.onChangeState();
        widget.isOn ? _controller.reverse() : _controller.forward();
      },
      child: AnimatedContainer(
        height: (size + 12),
        width: size * 2.5,
        duration: widget.duration,
        curve: Curves.easeInOutExpo,
        alignment: widget.isOn ? Alignment.topRight : Alignment.topLeft,
        decoration: BoxDecoration(
          color: widget.isOn
              ? Theme.of(context).primaryColor
              : const Color(0xFF848484),
          borderRadius: BorderRadius.circular((size + 12) / 2),
          boxShadow: [
            !widget.isOn
                ? BoxShadow(
                    color: const Color(0xFF828282).withOpacity(.8),
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                    offset: const Offset(5.0, 5.0))
                : const BoxShadow(),
          ],
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (BuildContext context, _) {
            return Container(
              height: size,
              width: _sizeAnimation.value,
              margin: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  color: const Color(0xFFE5E5E5),
                  borderRadius: BorderRadius.circular(size / 2)),
            );
          },
        ),
      ),
    );
  }
}
