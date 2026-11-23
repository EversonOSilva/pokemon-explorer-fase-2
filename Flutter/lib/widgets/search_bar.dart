
import 'package:material_ui/material_ui.dart';

class PokemonSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String searchText;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const PokemonSearchField({
    super.key,
    required this.controller,
    required this.searchText,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      style: const TextStyle(fontSize: 12),
      decoration: InputDecoration(
        hintText: 'Nome ou número do Pokémon',
        hintStyle: const TextStyle(
          fontSize: 11,
          color: Colors.blueGrey,
        ),
        prefixIcon: const Icon(
          Icons.search,
          size: 19,
          color: Colors.blueGrey,
        ),
        suffixIcon: searchText.isNotEmpty
            ? IconButton(
                onPressed: onClear,
                icon: const Icon(
                  Icons.close,
                  size: 18,
                ),
              )
            : null,
        border: InputBorder.none,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
      ),
    );
  }
}
