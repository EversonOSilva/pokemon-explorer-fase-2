
import 'package:material_ui/material_ui.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  static const Color navy = Color(0xFF19365B);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.catching_pokemon,
          color: Color(0xFFE53935),
          size: 29,
        ),
        const SizedBox(width: 7),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pokémon',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: navy,
              ),
            ),
            Text(
              'EXPLORER',
              style: TextStyle(
                fontSize: 8,
                letterSpacing: 1,
                color: Colors.grey,
              ),
            ),
          ],
        ),
        const Spacer(),
        Container(
          width: 29,
          height: 29,
          decoration: const BoxDecoration(
            color: navy,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text(
            'BR',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
