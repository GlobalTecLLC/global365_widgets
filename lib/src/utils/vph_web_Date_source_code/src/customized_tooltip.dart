import 'package:flutter/material.dart';

class GCustomizedTooltip extends StatefulWidget {
  final String message;
  final Widget child;
  final double maxWidth;
  final Color backgroundColor;
  final Color textColor;

  const GCustomizedTooltip({
    super.key,
    required this.message,
    required this.child,
    required this.maxWidth,
 this.backgroundColor = const Color(0xFF616161),
    this.textColor = Colors.white, 
  });

  @override
  State<GCustomizedTooltip> createState() => _GCustomizedTooltipState();
}

class _GCustomizedTooltipState extends State<GCustomizedTooltip> {
  OverlayEntry? _overlayEntry;

  void _showTooltip() {
    if (!mounted) return;

    final overlay = Overlay.of(context);

    final renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null || !renderBox.hasSize) return;

    final target = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: target.dx,
        top: target.dy + size.height + 4,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: widget.maxWidth),
              child: Text(
                widget.message,
                style: TextStyle(color: widget.textColor, fontSize: 13),
                softWrap: true,
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _hideTooltip() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _showTooltip(),
      onExit: (_) => _hideTooltip(),
      child: widget.child,
    );
  }
}
