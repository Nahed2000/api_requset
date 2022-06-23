import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CodeTextField extends StatelessWidget {
  const CodeTextField(
      {Key? key,
      required TextEditingController textEditingController,
      required FocusNode focusNode,
      required void Function(String value) onChanged})
      : _textEditingController = textEditingController,
        _focusNode = focusNode,
       _onChanged = onChanged,
        super(key: key);

  final TextEditingController _textEditingController;
  final FocusNode _focusNode;
  final void Function(String value) _onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      focusNode: _focusNode,
      keyboardType:
          const TextInputType.numberWithOptions(decimal: false, signed: false),
      onChanged: _onChanged,
      textAlign: TextAlign.center,
      maxLength: 1,
      style: GoogleFonts.nunito(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey)),
        counterText: '',
      ),
    );
  }
}
