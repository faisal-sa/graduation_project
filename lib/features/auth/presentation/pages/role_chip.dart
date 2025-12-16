import 'package:flutter/material.dart';

class RoleChip extends StatelessWidget {
  const RoleChip({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.selectedRole,
    required this.onSelected,
  });
  final String label;
  final IconData icon;
  final String value;
  final String selectedRole;
  final ValueChanged<String> onSelected;

  bool get isSelected => selectedRole == value;

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      showCheckmark: false,
      avatar: Icon(
        icon,
        size: 22,
        color: isSelected ? Colors.blue : Colors.grey.shade600,
      ),
      label: Text(label, style: const TextStyle(fontSize: 15)),
      selected: isSelected,
      onSelected: (_) => onSelected(value),
      selectedColor: Colors.blue.withAlpha(15),
      checkmarkColor: Colors.blue,
      backgroundColor: Colors.grey.shade50,
      elevation: isSelected ? 2 : 0,
      pressElevation: 4,
      labelStyle: TextStyle(
        color: isSelected ? Colors.blue.shade700 : Colors.grey.shade700,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
        letterSpacing: 0.2,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? Colors.blue : Colors.grey.shade300,
          width: isSelected ? 2 : 1.5,
        ),
      ),
    );
  }
}
