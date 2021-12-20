import 'package:flutter/widgets.dart';

class Countup extends StatefulWidget {
  final double begin;
  final double end;
  final int precision;
  final Curve curve;
  final Duration duration;
  final TextStyle style;
  final TextOverflow overflow;
  final int maxLines;
  final String semanticsLabel;
  final String separator;
  final String prefix;
  final String suffix;

  Countup({
    required Key key,
    required this.begin,
    required this.end,
    this.precision = 0,
    this.curve = Curves.linear,
    this.duration = const Duration(milliseconds: 250),
    required this.style,
    required this.overflow,
    required this.maxLines,
    required this.semanticsLabel,
    required this.separator,
    this.prefix = '',
    this.suffix = '',
  }) : super(key: key);

  @override
  _CountupState createState() => _CountupState();
}

class _CountupState extends State<Countup> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double _latestBegin;
  late double _latestEnd;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this);
    _latestBegin = widget.begin;
    _latestEnd = widget.end;
  }

  @override
  Widget build(BuildContext context) {
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _controller, curve: widget.curve);
    _animation = Tween<double>(begin: widget.begin, end: widget.end)
        .animate(curvedAnimation);

    if (widget.begin != _latestBegin || widget.end != _latestEnd) {
      _controller.reset();
    }

    _latestBegin = widget.begin;
    _latestEnd = widget.end;
    _controller.forward();

    return _CountupAnimatedText(
      key: UniqueKey(),
      animation: _animation,
      precision: widget.precision,
      style: widget.style,
      overflow: widget.overflow,
      maxLines: widget.maxLines,
      semanticsLabel: widget.semanticsLabel,
      separator: widget.separator,
      prefix: widget.prefix,
      suffix: widget.suffix,
    );
  }
}

class _CountupAnimatedText extends AnimatedWidget {
  final RegExp reg = new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');

  final Animation<double> animation;
  final int precision;
  final TextStyle style;
  final TextOverflow overflow;
  final int maxLines;
  final String semanticsLabel;
  final String separator;
  final String prefix;
  final String suffix;

  _CountupAnimatedText({
    required Key key,
    required this.animation,
    required this.precision,
    required this.style,
    required this.overflow,
    required this.maxLines,
    required this.semanticsLabel,
    required this.separator,
    required this.prefix,
    required this.suffix,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) => Text(
        separator != null
            ? '$prefix' +
                this
                    .animation
                    .value
                    .toStringAsFixed(precision)
                    .replaceAllMapped(
                        reg, (Match match) => '${match[1]}$separator') +
                '$suffix'
            : '$prefix' +
                this.animation.value.toStringAsFixed(precision) +
                '$suffix',
        style: this.style,
        overflow: this.overflow,
        maxLines: this.maxLines,
        semanticsLabel: this.semanticsLabel,
      );
}
