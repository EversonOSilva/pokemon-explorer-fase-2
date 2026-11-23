
import 'package:material_ui/material_ui.dart';

class TypeFilterSheet extends StatefulWidget {
  final Set<String> selectedTypes;
  final Map<String, String> pokemonTypes;

  const TypeFilterSheet({
    super.key,
    required this.selectedTypes,
    required this.pokemonTypes,
  });

  @override
  State<TypeFilterSheet> createState() =>
      _TypeFilterSheetState();
}

class _TypeFilterSheetState extends State<TypeFilterSheet> {
  static const Color navy = Color(0xFF19365B);
  static const Color yellow = Color(0xFFFFC928);

  late Set<String> temporaryTypes;

  @override
  void initState() {
    super.initState();
    temporaryTypes = Set.from(widget.selectedTypes);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Filtrar por tipo',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: navy,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Selecione um ou mais tipos de Pokémon.',
              style: TextStyle(color: Colors.blueGrey),
            ),
            const SizedBox(height: 18),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: widget.pokemonTypes.entries.map((entry) {
                final selected =
                    temporaryTypes.contains(entry.key);

                return FilterChip(
                  label: Text(entry.value),
                  selected: selected,
                  selectedColor: yellow,
                  checkmarkColor: navy,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        temporaryTypes.add(entry.key);
                      } else {
                        temporaryTypes.remove(entry.key);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        temporaryTypes.clear();
                      });
                    },
                    child: const Text('Limpar'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: navy,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pop(context, temporaryTypes);
                    },
                    child: const Text('Aplicar filtros'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
