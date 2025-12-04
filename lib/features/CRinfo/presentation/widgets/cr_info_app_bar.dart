import 'package:flutter/material.dart';

class CrInfoAppBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSearch;

  const CrInfoAppBar({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      style: const TextStyle(color: Colors.white),
      onSubmitted: (_) => onSearch(),
      decoration: InputDecoration(
        labelText: "رقم السجل التجاري",
        labelStyle: TextStyle(
          color: Colors.blueAccent.shade100,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent.shade100),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent.shade100, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        suffixIcon: IconButton(
          color: Colors.transparent,
          onPressed: onSearch,
          icon: Icon(Icons.search, color: Colors.blueAccent.shade100, size: 28),
        ),
      ),
      cursorColor: Colors.blueAccent.shade100,
    );
  }
}

