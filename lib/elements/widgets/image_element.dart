import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ImageElement extends StatelessWidget {
  final Map<String, String> properties;

  const ImageElement({super.key, required this.properties});

  Widget _buildErrorWidget(BorderRadius borderRadius) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F0F0),
        borderRadius: borderRadius,
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('🖼️', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              'Rasm yuklanmadi',
              style: GoogleFonts.inter(color: const Color(0xFFAAAAAA), fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = properties;
    final src = p['src'] ?? '';
    final tl = double.tryParse(p['radiusTopLeft'] ?? p['borderRadius'] ?? '12') ?? 12;
    final tr = double.tryParse(p['radiusTopRight'] ?? p['borderRadius'] ?? '12') ?? 12;
    final bl = double.tryParse(p['radiusBottomLeft'] ?? p['borderRadius'] ?? '12') ?? 12;
    final br = double.tryParse(p['radiusBottomRight'] ?? p['borderRadius'] ?? '12') ?? 12;

    final brOnly = BorderRadius.only(
      topLeft: Radius.circular(tl),
      topRight: Radius.circular(tr),
      bottomLeft: Radius.circular(bl),
      bottomRight: Radius.circular(br),
    );

    final fitVal = p['fit'] ?? 'cover';
    BoxFit boxFit = BoxFit.cover;
    switch (fitVal) {
      case 'cover':
        boxFit = BoxFit.cover;
        break;
      case 'contain':
        boxFit = BoxFit.contain;
        break;
      case 'fill':
        boxFit = BoxFit.fill;
        break;
      case 'fitWidth':
        boxFit = BoxFit.fitWidth;
        break;
      case 'fitHeight':
        boxFit = BoxFit.fitHeight;
        break;
      case 'none':
        boxFit = BoxFit.none;
        break;
      case 'scaleDown':
        boxFit = BoxFit.scaleDown;
        break;
    }

    Widget imageWidget;
    if (src.startsWith('data:image')) {
      try {
        final base64Content = src.split(',').last;
        final bytes = base64Decode(base64Content);
        imageWidget = Image.memory(
          bytes,
          width: double.infinity,
          height: double.infinity,
          fit: boxFit,
          errorBuilder: (context, error, stackTrace) => _buildErrorWidget(brOnly),
        );
      } catch (_) {
        imageWidget = _buildErrorWidget(brOnly);
      }
    } else if (src.startsWith('http') || src.startsWith('https')) {
      imageWidget = Image.network(
        src,
        width: double.infinity,
        height: double.infinity,
        fit: boxFit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(brOnly),
      );
    } else if (!kIsWeb && src.isNotEmpty) {
      imageWidget = Image.file(
        io.File(src),
        width: double.infinity,
        height: double.infinity,
        fit: boxFit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(brOnly),
      );
    } else {
      imageWidget = Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFFF0F0F0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('🖼️', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 4),
              Text(
                'Rasm kiritilmagan',
                style: GoogleFonts.inter(color: const Color(0xFFAAAAAA), fontSize: 12),
              ),
            ],
          ),
        ),
      );
    }

    return ClipRRect(
      borderRadius: brOnly,
      child: imageWidget,
    );
  }
}
