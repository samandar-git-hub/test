import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:visual_buildify/common/hover/custom_hover.dart';
import 'package:visual_buildify/common/utils/input_formatters.dart';
import 'package:visual_buildify/core/utils/helpers.dart';

import '../../../core/theme/app_theme.dart';

class ColorPickerDropdown extends StatefulWidget {
  final String? label;
  final String selectedValue;
  final ValueChanged<String> onSelected;

  const ColorPickerDropdown({
    super.key,
    this.label,
    required this.selectedValue,
    required this.onSelected,
  });

  @override
  State<ColorPickerDropdown> createState() => _ColorPickerDropdownState();
}

class _ColorPickerDropdownState extends State<ColorPickerDropdown> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    _currentColor = _safeParseColor(widget.selectedValue);
  }

  @override
  void didUpdateWidget(covariant ColorPickerDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedValue != oldWidget.selectedValue) {
      setState(() {
        _currentColor = _safeParseColor(widget.selectedValue);
      });
    }
  }

  Color _safeParseColor(String hex) {
    try {
      return parseHexColor(hex);
    } catch (_) {
      return Colors.white;
    }
  }

  String _colorToHex(Color color) {
    final rgb = color.toARGB32() & 0xFFFFFF;
    return rgb.toRadixString(16).padLeft(6, '0').toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    return CustomHover(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: PopupMenuButton<String>(
        tooltip: '',
        offset: const Offset(0, 0),
        constraints: const BoxConstraints(maxWidth: 450),
        color: context.colors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(color: context.colors.borderDark, width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label ?? 'Color:',
              style: context.style.s12w500.copyWith(color: context.colors.textMuted),
            ),
            const Gap(6),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: _currentColor,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const Gap(6),
            Icon(Icons.keyboard_arrow_down, size: 16, color: context.colors.textMuted),
          ],
        ),
        itemBuilder: (context) {
          return [
            PopupMenuItem<String>(
              enabled: false,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: _ColorPickerContent(
                initialColor: _currentColor,
                onColorChanged: (color) {
                  setState(() {
                    _currentColor = color;
                  });
                  final hex = '#${_colorToHex(color)}';
                  widget.onSelected(hex);
                },
              ),
            ),
          ];
        },
      ),
    );
  }
}

class _ColorPickerContent extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  const _ColorPickerContent({required this.initialColor, required this.onColorChanged});

  @override
  State<_ColorPickerContent> createState() => _ColorPickerContentState();
}

class _ColorPickerContentState extends State<_ColorPickerContent> {
  late double _hue;
  late double _saturation;
  late double _value;
  late TextEditingController _hexController;
  late TextEditingController _rController;
  late TextEditingController _gController;
  late TextEditingController _bController;
  bool _isCopied = false;

  @override
  void initState() {
    super.initState();
    final hsv = HSVColor.fromColor(widget.initialColor);
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;

    final initialColorARGB = widget.initialColor.toARGB32();
    _hexController = TextEditingController(text: _colorToHex(widget.initialColor));
    _rController = TextEditingController(text: ((initialColorARGB >> 16) & 0xFF).toString());
    _gController = TextEditingController(text: ((initialColorARGB >> 8) & 0xFF).toString());
    _bController = TextEditingController(text: (initialColorARGB & 0xFF).toString());
  }

  @override
  void didUpdateWidget(covariant _ColorPickerContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialColor != oldWidget.initialColor) {
      final hsv = HSVColor.fromColor(widget.initialColor);
      setState(() {
        _hue = hsv.hue;
        _saturation = hsv.saturation;
        _value = hsv.value;
      });
      final newHex = _colorToHex(widget.initialColor);
      if (_hexController.text.toUpperCase() != newHex.toUpperCase()) {
        _hexController.text = newHex;
      }
      _updateRGBControllers(widget.initialColor);
    }
  }

  @override
  void dispose() {
    _hexController.dispose();
    _rController.dispose();
    _gController.dispose();
    _bController.dispose();
    super.dispose();
  }

  String _colorToHex(Color color) {
    final rgb = color.toARGB32() & 0xFFFFFF;
    return rgb.toRadixString(16).padLeft(6, '0').toUpperCase();
  }

  void _updateRGBControllers(Color color) {
    final argb = color.toARGB32();
    final r = (argb >> 16) & 0xFF;
    final g = (argb >> 8) & 0xFF;
    final b = argb & 0xFF;

    if (int.tryParse(_rController.text) != r) {
      _rController.text = r.toString();
    }
    if (int.tryParse(_gController.text) != g) {
      _gController.text = g.toString();
    }
    if (int.tryParse(_bController.text) != b) {
      _bController.text = b.toString();
    }
  }

  void _updateColorFromHSV() {
    final color = HSVColor.fromAHSV(1.0, _hue, _saturation, _value).toColor();
    final hex = _colorToHex(color);
    if (_hexController.text.toUpperCase() != hex.toUpperCase()) {
      _hexController.text = hex;
    }
    _updateRGBControllers(color);
    widget.onColorChanged(color);
  }

  void _onHexChanged(String hex) {
    String cleanHex = hex.trim();
    if (cleanHex.isEmpty) return;

    if (cleanHex.length == 3) {
      cleanHex = cleanHex.split('').map((char) => char + char).join();
    } else if (cleanHex.length < 6) {
      cleanHex = cleanHex.padRight(6, '0');
    }

    if (cleanHex.length == 6) {
      try {
        final color = parseHexColor('#$cleanHex');
        final hsv = HSVColor.fromColor(color);
        setState(() {
          _hue = hsv.hue;
          _saturation = hsv.saturation;
          _value = hsv.value;
        });
        _updateRGBControllers(color);
        widget.onColorChanged(color);
      } catch (_) {}
    }
  }

  void _onRGBChanged() {
    final r = (int.tryParse(_rController.text) ?? 0).clamp(0, 255);
    final g = (int.tryParse(_gController.text) ?? 0).clamp(0, 255);
    final b = (int.tryParse(_bController.text) ?? 0).clamp(0, 255);

    final color = Color.fromARGB(255, r, g, b);
    final hsv = HSVColor.fromColor(color);

    setState(() {
      _hue = hsv.hue;
      _saturation = hsv.saturation;
      _value = hsv.value;
    });

    final hex = _colorToHex(color);
    if (_hexController.text.toUpperCase() != hex.toUpperCase()) {
      _hexController.text = hex;
    }

    widget.onColorChanged(color);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onPanUpdate: (details) {
                final localPos = details.localPosition;
                double sat = localPos.dx / 300.0;
                double val = 1.0 - (localPos.dy / 200.0);
                setState(() {
                  _saturation = sat.clamp(0.0, 1.0);
                  _value = val.clamp(0.0, 1.0);
                  _updateColorFromHSV();
                });
              },
              onPanDown: (details) {
                final localPos = details.localPosition;
                double sat = localPos.dx / 300.0;
                double val = 1.0 - (localPos.dy / 200.0);
                setState(() {
                  _saturation = sat.clamp(0.0, 1.0);
                  _value = val.clamp(0.0, 1.0);
                  _updateColorFromHSV();
                });
              },
              child: CustomPaint(
                size: const Size(300, 200),
                painter: _SaturationValuePainter(hue: _hue, saturation: _saturation, value: _value),
              ),
            ),
            const Gap(25),

            GestureDetector(
              onPanUpdate: (details) {
                double hue = (details.localPosition.dy / 200.0) * 360.0;
                setState(() {
                  _hue = hue.clamp(0.0, 360.0);
                  _updateColorFromHSV();
                });
              },
              onPanDown: (details) {
                double hue = (details.localPosition.dy / 200.0) * 360.0;
                setState(() {
                  _hue = hue.clamp(0.0, 360.0);
                  _updateColorFromHSV();
                });
              },
              child: CustomPaint(
                size: const Size(30, 200),
                painter: _HuePainter(hue: _hue),
              ),
            ),
          ],
        ),
        const Gap(20),

        Row(
          children: [
            _RGBField(label: 'R', controller: _rController, onChanged: (_) => _onRGBChanged()),
            const Gap(6),
            _RGBField(label: 'G', controller: _gController, onChanged: (_) => _onRGBChanged()),
            const Gap(6),
            _RGBField(label: 'B', controller: _bController, onChanged: (_) => _onRGBChanged()),
            const Spacer(),
            Text('HEX:', style: context.style.s10w600.copyWith(color: context.colors.textMuted)),
            const Gap(6),
            Container(
              width: 120,
              decoration: BoxDecoration(
                border: Border.all(color: context.colors.borderDark),
                borderRadius: BorderRadius.circular(6),
                color: context.colors.surface,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _hexController,
                      style: context.style.s12w500,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9a-fA-F]')),
                        LengthLimitingTextInputFormatter(6),
                        UpperCaseTextFormatter(),
                      ],
                      decoration: InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                        prefixText: '#',
                        prefixStyle: context.style.s12w500.copyWith(
                          color: context.colors.textMuted,
                        ),
                      ),
                      onChanged: _onHexChanged,
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      final fullHex = '#${_hexController.text}';
                      Clipboard.setData(ClipboardData(text: fullHex));
                      setState(() {
                        _isCopied = true;
                      });
                      Future.delayed(const Duration(seconds: 1), () {
                        if (mounted) {
                          setState(() {
                            _isCopied = false;
                          });
                        }
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      alignment: Alignment.center,
                      child: Icon(
                        _isCopied ? Icons.check_rounded : Icons.copy_all_rounded,
                        size: 16,
                        color: _isCopied ? Colors.green : context.colors.textMuted,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _RGBField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _RGBField({required this.label, required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('$label:', style: context.style.s10w600.copyWith(color: context.colors.textMuted)),
        const Gap(6),
        Container(
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: context.colors.borderDark),
            borderRadius: BorderRadius.circular(6),
            color: context.colors.surface,
          ),
          child: TextField(
            controller: controller,
            style: context.style.s12w500,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
              isDense: true,
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 8),
            ),
            onChanged: (val) {
              final numVal = int.tryParse(val);
              if (numVal != null && numVal > 255) {
                controller.text = '255';
                controller.selection = const TextSelection.collapsed(offset: 3);
              }
              onChanged(val);
            },
          ),
        ),
      ],
    );
  }
}

class _SaturationValuePainter extends CustomPainter {
  final double hue;
  final double saturation;
  final double value;

  _SaturationValuePainter({required this.hue, required this.saturation, required this.value});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

    final huePaint = Paint()
      ..color = HSVColor.fromAHSV(1.0, hue, 1.0, 1.0).toColor()
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rRect, huePaint);

    final satGradient = LinearGradient(
      colors: [Colors.white, const Color(0x00FFFFFF)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
    final satPaint = Paint()
      ..shader = satGradient.createShader(rect)
      ..blendMode = BlendMode.srcOver;
    canvas.drawRRect(rRect, satPaint);

    final valGradient = LinearGradient(
      colors: [Colors.transparent, Colors.black],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final valPaint = Paint()
      ..shader = valGradient.createShader(rect)
      ..blendMode = BlendMode.multiply;
    canvas.drawRRect(rRect, valPaint);

    final pointX = saturation * size.width;
    final pointY = (1.0 - value) * size.height;

    canvas.drawCircle(
      Offset(pointX, pointY),
      7.0,
      Paint()
        ..color = const Color(0x4D000000)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.5,
    );

    canvas.drawCircle(
      Offset(pointX, pointY),
      6.0,
      Paint()
        ..color = Colors.white
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0,
    );
  }

  @override
  bool shouldRepaint(covariant _SaturationValuePainter oldDelegate) {
    return oldDelegate.hue != hue ||
        oldDelegate.saturation != saturation ||
        oldDelegate.value != value;
  }
}

class _HuePainter extends CustomPainter {
  final double hue;

  _HuePainter({required this.hue});

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rRect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

    final List<Color> colors = [
      const Color(0xFFFF0000),
      const Color(0xFFFFFF00),
      const Color(0xFF00FF00),
      const Color(0xFF00FFFF),
      const Color(0xFF0000FF),
      const Color(0xFFFF00FF),
      const Color(0xFFFF0000),
    ];

    final gradient = LinearGradient(
      colors: colors,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );

    final paint = Paint()..shader = gradient.createShader(rect);
    canvas.drawRRect(rRect, paint);

    final indicatorY = (hue / 360.0) * size.height;

    final shadowPaint = Paint()
      ..color = const Color(0x80000000)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawLine(Offset(-2, indicatorY), Offset(size.width + 2, indicatorY), shadowPaint);

    final indicatorPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawLine(Offset(-2, indicatorY), Offset(size.width + 2, indicatorY), indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant _HuePainter oldDelegate) {
    return oldDelegate.hue != hue;
  }
}
