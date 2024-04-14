import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String textHint;
  final int value;
  final VoidCallback onTap;
  const CustomTextFormField({
    super.key,
    required TextEditingController anyName,
    required this.textHint,
    required this.value,
    required this.onTap,
  }) : _anyName = anyName;

  final TextEditingController _anyName;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: true,
      maxLines: value,
      style: const TextStyle(color: Colors.white),
      cursorColor: Colors.white,
      controller: _anyName,
      decoration: InputDecoration(
          fillColor: const Color.fromARGB(255, 1, 105, 91).withOpacity(0.4),
          filled: true,
          hintText: textHint,
          hintStyle: const TextStyle(color: Colors.white),
          contentPadding: const EdgeInsets.only(left: 15, top: 5, bottom: 5),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1)),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(5))),
          border: const UnderlineInputBorder(borderSide: BorderSide.none)),
      onTap: onTap,
    );
  }
}
