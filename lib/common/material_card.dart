import 'package:flutter/material.dart';

enum Shadows { None, Outer, Inner, Custom }

///[shadows] defaults k4
class MaterialCard extends StatelessWidget {
  final Duration? animationDuration;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final AlignmentGeometry? alignment;
  final DecorationImage? backgroundImage;
  final void Function()? onTap;
  final void Function()? onLongPress;
  final void Function()? onDoubleTap;
  final void Function(bool)? onHighlightChanged;
  final void Function(bool isHovering)? onHover;
  final Color? shadowColor;
  final Offset? shadowOffset;
  final Gradient? gradient;
  final Shadows shadows;
  final List<BoxShadow>? customShadows;
  final double? height;
  final double? width;
  final Color? splashColor;
  final Color? highlightColor;
  final Color color;
  final String? heroTag;
  final Widget? child;
  final BoxBorder? border;
  final Clip? clipBehavior;

  const MaterialCard({
    super.key,
    this.animationDuration,
    this.borderRadius,
    this.customShadows,
    this.margin,
    this.border,
    this.shadowOffset,
    this.padding,
    this.alignment,
    this.splashColor,
    this.highlightColor,
    this.backgroundImage,
    this.onTap,
    this.onLongPress,
    this.onDoubleTap,
    this.onHighlightChanged,
    this.onHover,
    this.shadowColor,
    this.gradient,
    this.shadows = Shadows.Outer,
    this.height,
    this.width,
    this.color = Colors.white,
    this.heroTag,
    this.child,
    this.clipBehavior,
  });

  List<BoxShadow>? _shadows() {
    switch (shadows) {
      case Shadows.None:
        return null;
      case Shadows.Outer:
        return [
          BoxShadow(
              color: shadowColor ??
                  Color.alphaBlend(Color(0x4F393945), Colors.white),
              offset: shadowOffset ?? Offset(0, 1),
              blurRadius: 4,
              spreadRadius: 0),
        ];
      case Shadows.Inner:
        return [
          BoxShadow(
            color: shadowColor ??
                Color.alphaBlend(Color(0x4F393945), Colors.white),
          ),
          if (gradient != null)
            BoxShadow(
              color: (gradient!.colors).first,
              spreadRadius: -4,
              blurRadius: 0,
            )
          else
            BoxShadow(
              color: color,
              spreadRadius: -4,
              blurRadius: 0,
            ),
        ];
      case Shadows.Custom:
        return customShadows;
      default:
        return null;
    }
  }

  Widget _card(BuildContext context) => AnimatedContainer(
        duration: animationDuration ?? const Duration(milliseconds: 0),
        width: width,
        height: height,
        alignment: alignment,
        margin: margin ?? EdgeInsets.zero,
        decoration: BoxDecoration(
          border: border,
          gradient: shadows != Shadows.Inner ? gradient : null,
          boxShadow: _shadows(),
          image: backgroundImage,
          color: shadows != Shadows.Inner ? color : null,
          borderRadius: borderRadius ?? BorderRadius.zero,
        ),
        child: Material(
          clipBehavior: clipBehavior ?? Clip.none,
          color: shadows != Shadows.Inner &&
                  gradient == null &&
                  backgroundImage == null
              ? color
              : Colors.transparent,
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: InkWell(
            onTap: onTap != null
                ? () {
                    onTap!();
                  }
                : null,
            onDoubleTap: onDoubleTap != null ? () => onDoubleTap!() : null,
            onLongPress: onLongPress != null ? () => onLongPress!() : null,
            onHighlightChanged: onHighlightChanged != null
                ? (bool v) => onHighlightChanged!(v)
                : null,
            onHover: onHover != null
                ? (bool isHovering) => onHover!(isHovering)
                : null,
            borderRadius: borderRadius != null
                ? borderRadius!.resolve(Directionality.of(context))
                : null,
            splashColor: splashColor,
            highlightColor: highlightColor,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: child,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return heroTag != null
        ? Hero(tag: heroTag!, child: _card(context))
        : _card(context);
  }
}
