import 'package:flutter/material.dart';
import 'package:bareekmedia/core/common_helper.dart';

class CustomToggleSwitch extends StatefulWidget {
  final bool value;
  final void Function(bool)? onChanged;
  final double? scale;
  final Widget? handleWidget;
  final Widget? trackWidget;
  final Color? activeTrackColor;
  final Color? activeThumbColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Color? activeBorderColor;
  final Color? inactiveBorderColor;

  const CustomToggleSwitch({
    super.key,
    required this.value,
    this.scale,
    this.trackWidget,
    this.handleWidget,
    this.onChanged,
    this.activeTrackColor,
    this.activeThumbColor,
    this.inactiveThumbColor,
    this.inactiveTrackColor,
    this.activeBorderColor,
    this.inactiveBorderColor,
  });

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
  bool isMoving = false;
  double trackLength = 0;
  Size size = const Size(50, 25);
  double innerPadding = 2;
  double initial = 0, distance = 0;

  Color get activeTrackColor => widget.activeTrackColor != null
      ? widget.activeTrackColor!
      : Theme.of(context).primaryColor.withOpacity(0.5);

  Color get inactiveTrackColor => widget.inactiveTrackColor != null
      ? widget.inactiveTrackColor!
      : const Color(0xFFBFBFBF);

  Color get activeThumbColor => widget.activeThumbColor != null
      ? widget.activeThumbColor!
      : Theme.of(context).primaryColor;

  Color get inactiveThumbColor => widget.inactiveThumbColor != null
      ? widget.inactiveThumbColor!
      : const Color(0xFF404040);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: widget.onChanged != null
          ? (DragStartDetails details) {
              initial = details.globalPosition.dx;
            }
          : null,
      onPanUpdate: widget.onChanged != null
          ? (DragUpdateDetails details) {
              distance = details.globalPosition.dx - initial;
            }
          : null,
      onPanEnd: widget.onChanged != null
          ? (DragEndDetails details) {
              initial = 0.0;
              if (distance > 0 && !widget.value) {
                CommonHelper.vibrateSelection();
                widget.onChanged!(widget.value);
              }
              if (distance < 0 && widget.value) {
                CommonHelper.vibrateSelection();
                widget.onChanged!(widget.value);
              }
              isMoving = false;
            }
          : null,
      onTap: widget.onChanged != null
          ? () {
              widget.onChanged!(widget.value);
              CommonHelper.vibrateSelection();
            }
          : null,
      child: AnimatedContainer(
        curve: Curves.easeOut,
        padding: EdgeInsets.all(innerPadding),
        duration: const Duration(milliseconds: 300),
        alignment: widget.value ? Alignment.centerRight : Alignment.centerLeft,
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: widget.value ? activeTrackColor : inactiveTrackColor,
        ),
        child: Container(
          padding: widget.handleWidget == null
              ? null
              : const EdgeInsets.symmetric(horizontal: 2),
          height: widget.handleWidget == null ? size.height - 4 : null,
          width: widget.handleWidget == null ? size.height - 4 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: widget.value ? activeThumbColor : inactiveThumbColor,
          ),
          child: widget.handleWidget,
        ),
      ),
    );
  }
}
