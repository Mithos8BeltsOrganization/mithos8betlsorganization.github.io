import 'package:flutter/widgets.dart';
import 'package:fpdart/fpdart.dart';

class LayoutScope extends InheritedWidget {
  const LayoutScope({
    required super.child,
    required this.constraints,
    super.key,
  });

  final BoxConstraints constraints;

  static LayoutScope of(BuildContext context) {
    final LayoutScope? layoutScope =
        context.dependOnInheritedWidgetOfExactType<LayoutScope>();

    if (layoutScope == null) {
      throw throw FlutterError('''
        LayoutScope.of() called with a context that does not contain a LayoutScope.
        
        The widget used was: LayoutScope.
        ''');
    }

    return layoutScope;
  }

  Breakpoint get breakpoint => Breakpoint(width: constraints.maxWidth);

  @override
  bool updateShouldNotify(LayoutScope oldWidget) => true;
}

enum BreakpointNames {
  xs,
  sm,
  md,
  lg,
  xl,
  ;

  bool operator <(BreakpointNames breakpoint) => index < breakpoint.index;
  bool operator >(BreakpointNames breakpoint) => index > breakpoint.index;
  bool operator <=(BreakpointNames breakpoint) => index <= breakpoint.index;
  bool operator >=(BreakpointNames breakpoint) => index >= breakpoint.index;
}

enum BreakpointBasicNames {
  s,
  m,
  l,
  ;

  bool operator <(BreakpointBasicNames breakpoint) => index < breakpoint.index;
  bool operator >(BreakpointBasicNames breakpoint) => index > breakpoint.index;
  bool operator <=(BreakpointBasicNames breakpoint) =>
      index <= breakpoint.index;
  bool operator >=(BreakpointBasicNames breakpoint) =>
      index >= breakpoint.index;
}

const _breakpoints = {
  BreakpointNames.xs: Range(minWidth: 0, maxWidth: 599),
  BreakpointNames.sm: Range(minWidth: 600, maxWidth: 899),
  BreakpointNames.md: Range(minWidth: 900, maxWidth: 1199),
  BreakpointNames.lg: Range(minWidth: 1200, maxWidth: 1535),
  BreakpointNames.xl: Range(minWidth: 1536, maxWidth: double.infinity),
};
const _basicBreakpoints = {
  BreakpointBasicNames.s: Range(minWidth: 0, maxWidth: 599),
  BreakpointBasicNames.m: Range(minWidth: 600, maxWidth: 1023),
  BreakpointBasicNames.l: Range(minWidth: 1024, maxWidth: double.infinity),
};

const _defaultBreakpoints = {
  ..._breakpoints,
  ..._basicBreakpoints,
};

class Range {
  const Range({required this.minWidth, required this.maxWidth});

  final double minWidth;
  final double maxWidth;

  bool contains(double width) => width >= minWidth && width <= maxWidth;
}

class Breakpoint {
  const Breakpoint({
    required this.width,
    this.breakpoints = _defaultBreakpoints,
  });

  final Map<Object, Range> breakpoints;
  final double width;

  T resolve<T>({
    required IO<T> onL,
    required IO<T> onM,
    required IO<T> onS,
  }) {
    if (isS) {
      return onS.run();
    }
    if (isM) {
      return onM.run();
    }

    return onL.run();
  }

  bool isInRange(Range? point) => point?.contains(width) ?? false;
  bool isByName(Object? point) => breakpoints[point]?.contains(width) ?? false;

  bool get isS => isByName(BreakpointBasicNames.s);

  bool get isM => isByName(BreakpointBasicNames.m);

  bool get isL => isByName(BreakpointBasicNames.l);
}
