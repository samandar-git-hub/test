import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pasteboard/pasteboard.dart';

class ClipboardPasteListener extends StatefulWidget {
  final Widget child;
  final ValueChanged<String> onPaste;

  const ClipboardPasteListener({
    super.key,
    required this.child,
    required this.onPaste,
  });

  @override
  State<ClipboardPasteListener> createState() => _ClipboardPasteListenerState();
}

class _ClipboardPasteListenerState extends State<ClipboardPasteListener> {
  bool _isHovered = false;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _pasteFromClipboard() async {
    try {
      // 1. Try pasting copied files from Pasteboard (e.g. from Finder/Explorer)
      try {
        final files = await Pasteboard.files();
        if (files.isNotEmpty) {
          final filePath = files.first;
          final extension = filePath.split('.').last.toLowerCase();
          final isImage = ['png', 'jpg', 'jpeg', 'gif', 'webp', 'bmp'].contains(extension);
          if (isImage) {
            widget.onPaste(filePath);
            return;
          }
        }
      } catch (e) {
        debugPrint('Pasteboard files read error: $e');
      }

      // 2. Try pasting image bytes from Pasteboard
      Uint8List? bytes;
      try {
        bytes = await Pasteboard.image;
      } catch (e) {
        debugPrint('Pasteboard image read error: $e');
      }

      if (bytes != null) {
        final base64String = base64Encode(bytes);
        final src = 'data:image/png;base64,$base64String';
        widget.onPaste(src);
        return;
      }

      // 2. Try pasting text (URL) from Clipboard
      final clipboardData = await Clipboard.getData(Clipboard.kTextPlain);
      if (clipboardData != null && clipboardData.text != null) {
        final text = clipboardData.text!.trim();
        if (text.isNotEmpty) {
          widget.onPaste(text);
        }
      }
    } catch (e) {
      debugPrint('Clipboard paste error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      onKeyEvent: (node, event) {
        // Only handle key event if this container itself has primary focus,
        // and NOT when its child text fields (like URL text field) are focused.
        if (!_isHovered || !_focusNode.hasPrimaryFocus) {
          return KeyEventResult.ignored;
        }

        final isControlPressed = HardwareKeyboard.instance.isControlPressed ||
            HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlLeft) ||
            HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.controlRight);

        final isMetaPressed = HardwareKeyboard.instance.isMetaPressed ||
            HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaLeft) ||
            HardwareKeyboard.instance.logicalKeysPressed.contains(LogicalKeyboardKey.metaRight);

        if ((isControlPressed || isMetaPressed) &&
            event is KeyDownEvent &&
            event.logicalKey == LogicalKeyboardKey.keyV) {
          _pasteFromClipboard();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        onEnter: (_) {
          _focusNode.requestFocus();
          setState(() => _isHovered = true);
        },
        onExit: (_) {
          setState(() => _isHovered = false);
        },
        child: widget.child,
      ),
    );
  }
}
