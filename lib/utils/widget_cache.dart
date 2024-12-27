import 'package:flutter/material.dart';
import 'layout_scope.dart';

class WidgetCache extends StatefulWidget {
  const WidgetCache({
    required this.value,
    required this.builder,
    super.key,
  });

  final Breakpoint value;

  final Widget Function(BuildContext context, Breakpoint value) builder;

  @override
  WidgetCacheState createState() => WidgetCacheState();
}

class WidgetCacheState extends State<WidgetCache> {
  late Widget cache;

  Breakpoint? previousValue;

  @override
  Widget build(BuildContext context) {
    if (widget.value.isL != previousValue?.isL ||
        widget.value.isM != previousValue?.isM ||
        widget.value.isS != previousValue?.isS ||
        previousValue == null) {
      previousValue = widget.value;
      cache = Builder(
        builder: (context) => widget.builder(context, widget.value),
      );
    }
    return cache;
  }
}
