import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String selectedMonth;
  final Function(String) onMonthChanged;

  const CustomAppBar({
    Key? key,
    required this.selectedMonth,
    required this.onMonthChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white, // Cor de fundo branca
      elevation: 2, // Elevação para criar uma sombra leve
      title: Row(
        children: [
          // Logo da aplicação
          Image.asset(
            'assets/images/logo.png', // Caminho da sua logo
            height: 40, // Altura da logo
          ),
          const SizedBox(width: 8), // Espaço entre a logo e o texto
          const Text(
            'SOPHIA',
            style: TextStyle(
              color: Colors.black, // Cor do texto
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        // Dropdown para seleção de mês
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: DropdownButton<String>(
            value: selectedMonth,
            icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
            underline: Container(),
            style: const TextStyle(color: Colors.black, fontSize: 16),
            onChanged: (String? newValue) {
              if (newValue != null) {
                onMonthChanged(newValue);
              }
            },
            items: <String>[
              'Janeiro 2024',
              'Fevereiro 2024',
              'Março 2024',
              'Abril 2024',
              'Maio 2024',
              'Junho 2024',
              'Julho 2024',
              'Agosto 2024',
              'Setembro 2024',
              'Outubro 2024',
              'Novembro 2024',
              'Dezembro 2024',
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(56.0); // Altura padrão do AppBar
}
