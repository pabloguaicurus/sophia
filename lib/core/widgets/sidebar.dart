import 'package:flutter/material.dart';
import 'package:sophia/core/constans/colors%20and%20fonts.dart';

class CustomSidebar extends StatelessWidget {
  final Function(String) onMenuItemSelected;
  final String selectedPage; // Indica a página ativa

  const CustomSidebar({
    Key? key,
    required this.onMenuItemSelected,
    required this.selectedPage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250, // Largura fixa da barra lateral
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'MENU',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                _buildMenuItem(
                  icon: Icons.dashboard,
                  label: 'Dashboard',
                  isSelected: selectedPage == 'Dashboard',
                  onTap: () => onMenuItemSelected('Dashboard'),
                ),
                _buildMenuItem(
                  icon: Icons.swap_horiz,
                  label: 'Movimentações',
                  isSelected: selectedPage == 'Movimentações',
                  onTap: () => onMenuItemSelected('Movimentações'),
                ),
                _buildMenuItem(
                  icon: Icons.inventory,
                  label: 'Estoque',
                  isSelected: selectedPage == 'Estoque',
                  onTap: () => onMenuItemSelected('Estoque'),
                ),
                Spacer(), // Insere um espaço flexível para empurrar os itens seguintes para o final
                _buildMenuItem(
                  icon: Icons.settings,
                  label: 'Configurações',
                  isSelected: selectedPage == 'Configurações',
                  onTap: () => onMenuItemSelected('Configurações'),
                ),
                _buildMenuItem(
                  icon: Icons.logout,
                  label: 'Log out',
                  isSelected: selectedPage == 'Log out',
                  onTap: () => onMenuItemSelected('Log out'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      color: isSelected ? AppColors.secondary : AppColors.primary,
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
