
import 'package:material_ui/material_ui.dart';

class ActiveTypeFilters extends StatelessWidget {
  final Set<String> selectedTypes;
  final String Function(String) translateType;
  final ValueChanged<String> onRemove;

  const ActiveTypeFilters({
    super.key,
    required this.selectedTypes,
    required this.translateType,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Wrap(
        spacing: 6,
        runSpacing: 5,
        children: selectedTypes.map((type) {
          return Chip(
            label: Text(
              translateType(type),
              style: const TextStyle(fontSize: 11),
            ),
            deleteIcon: const Icon(
              Icons.close,
              size: 15,
            ),
            onDeleted: () => onRemove(type),
          );
        }).toList(),
      ),
    );
  }
}
