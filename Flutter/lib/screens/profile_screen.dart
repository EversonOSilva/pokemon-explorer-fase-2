
import 'package:material_ui/material_ui.dart';

class ProfileScreen extends StatelessWidget {
  final String trainerName;
  final int favoritesCount;
  final int loadedPokemonCount;

  const ProfileScreen({
    super.key,
    this.trainerName = 'Treinador Pokémon',
    required this.favoritesCount,
    required this.loadedPokemonCount,
  });

  static const Color navy = Color(0xFF19365B);
  static const Color background = Color(0xFFF5F7FC);
  static const Color yellow = Color(0xFFFFC928);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Meu Perfil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            // AVATAR DO TREINADOR
            const SizedBox(height: 20),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: yellow,
                shape: BoxShape.circle,
                border: Border.all(
                  color: navy,
                  width: 3,
                ),
              ),
              child: const Icon(
                Icons.person,
                color: navy,
                size: 65,
              ),
            ),

            const SizedBox(height: 18),

            // NOME DO TREINADOR
            Text(
              trainerName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: navy,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Treinador Pokémon',
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 32),

            // TÍTULO DAS ESTATÍSTICAS
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Minhas estatísticas',
                style: TextStyle(
                  color: navy,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            // CARTÕES DE ESTATÍSTICAS
            Row(
              children: [
                Expanded(
                  child: statisticCard(
                    icon: Icons.favorite,
                    title: 'Favoritos',
                    value: favoritesCount.toString(),
                    color: Colors.red,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: statisticCard(
                    icon: Icons.catching_pokemon,
                    title: 'Carregados',
                    value: loadedPokemonCount.toString(),
                    color: navy,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // INFORMAÇÕES DO APLICATIVO
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sobre o aplicativo',
                style: TextStyle(
                  color: navy,
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFE3E6ED),
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.catching_pokemon,
                        color: Colors.red,
                        size: 28,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Pokémon Explorer',
                        style: TextStyle(
                          color: navy,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 15),

                  Text(
                    'Explore o universo Pokémon, '
                    'consulte informações, descubra movimentos '
                    'e organize seus Pokémon favoritos.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: 15),

                  Divider(),

                  SizedBox(height: 8),

                  Text(
                    'Dados fornecidos pela PokéAPI.',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 12,
                    ),
                  ),

                  SizedBox(height: 8),

                  Text(
                    'Versão 1.0.0',
                    style: TextStyle(
                      color: navy,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'Pokémon Explorer © 2026',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),

            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }

  // COMPONENTE DOS CARTÕES DE ESTATÍSTICAS
  Widget statisticCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFE3E6ED),
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),

          const SizedBox(height: 10),

          Text(
            value,
            style: const TextStyle(
              color: navy,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.blueGrey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
