
import 'package:material_ui/material_ui.dart';

class BottomMenu extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const BottomMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 69,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFE3E6ED),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          _menuItem(
            icon: Icons.explore_outlined,
            label: 'Explorar',
            index: 0,
          ),
          _menuItem(
            icon: Icons.favorite_border,
            label: 'Favoritos',
            index: 1,
          ),
          _menuItem(
            icon: Icons.person_outline,
            label: 'Perfil',
            index: 2,
          ),
        ],
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required int index,
  }) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: InkWell(
        onTap: () => onItemSelected(index),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? const Color(0xFF172B4D)
                  : Colors.blueGrey,
              size: 23,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF172B4D)
                    : Colors.blueGrey,
                fontSize: 11,
                fontWeight: isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
