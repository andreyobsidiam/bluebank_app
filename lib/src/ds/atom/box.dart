import 'package:flutter/material.dart';

class DsBox extends StatelessWidget {
  const DsBox({super.key, required this.size, this.isVertical = false});

  final double size;
  final bool isVertical;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isVertical ? 1 : size,
      height: isVertical ? size : 1,
    );
  }

  static const vsm = DsBox(size: 8, isVertical: true);
  static const vsl = DsBox(size: 12, isVertical: true);
  static const vmd = DsBox(size: 16, isVertical: true);
  static const vlg = DsBox(size: 24, isVertical: true);
  static const vxl = DsBox(size: 32, isVertical: true);
  static const vxxl = DsBox(size: 48, isVertical: true);
  static const v2xl = DsBox(size: 64, isVertical: true);
  static const v3xl = DsBox(size: 96, isVertical: true);

  static const hsm = DsBox(size: 8, isVertical: false);
  static const hsl = DsBox(size: 12, isVertical: false);
  static const hmd = DsBox(size: 16, isVertical: false);
  static const hlg = DsBox(size: 24, isVertical: false);
  static const hxl = DsBox(size: 32, isVertical: false);
  static const hxxl = DsBox(size: 48, isVertical: false);
  static const h2xl = DsBox(size: 64, isVertical: false);
  static const h3xl = DsBox(size: 96, isVertical: false);
}
