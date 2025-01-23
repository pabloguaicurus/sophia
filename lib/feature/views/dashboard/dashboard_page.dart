import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:sophia/core/widgets/sidebar.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedPage = 'Dashboard';

  void _handleMenuSelection(String selectedPage) {
    setState(() {
      _selectedPage = selectedPage;
    });

    if (selectedPage == 'Movimentações') {
      Navigator.pushReplacementNamed(context, '/movimentacoes');
    } else if (selectedPage == 'Estoque') {
      Navigator.pushReplacementNamed(context, '/estoque');
    } else if (selectedPage == 'Configurações') {
      Navigator.pushReplacementNamed(context, '/configuracoes');
    } else if (selectedPage == 'Log out') {
      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          CustomSidebar(
            onMenuItemSelected: _handleMenuSelection,
            selectedPage: _selectedPage,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo no canto superior esquerdo
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.asset(
                    'assets/sophia.png',
                    height: 30, // Defina o tamanho desejado
                  ),
                ),
                Expanded(
                  child: _buildPageContent(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedPage == 'Dashboard') {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Quatro cards superiores maiores
            Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child:
                          InfoCard(title: "Total Balance", value: "\$632.000")),
                  const SizedBox(width: 16),
                  Expanded(
                      child: InfoCard(
                          title: "Total Entradas", value: "\$632.000")),
                  const SizedBox(width: 16),
                  Expanded(
                      child: InfoCard(
                          title: "Total Guardado", value: "\$632.000")),
                  const SizedBox(width: 16),
                  Expanded(
                      child:
                          InfoCard(title: "Total Saídas", value: "\$632.000")),
                ],
              ),
            ),
            const SizedBox(height: 24), // Espaçamento entre os blocos
            // Gráfico de pizza e lista de transações
            Expanded(
              flex: 4,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Gráfico de pizza e legenda
                  Expanded(
                    flex: 2,
                    child: InfoContainer(
                      title: "Despesas Mensais",
                      child: Row(
                        children: [
                          Expanded(
                            child: PieChart(
                              PieChartData(
                                sections: [
                                  PieChartSectionData(
                                    value: 40,
                                    title: "40%",
                                    color: Colors.blue,
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    value: 32,
                                    title: "32%",
                                    color: Colors.green,
                                    radius: 50,
                                  ),
                                  PieChartSectionData(
                                    value: 28,
                                    title: "28%",
                                    color: Colors.orange,
                                    radius: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Legenda do gráfico de pizza
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              LegendItem(color: Colors.blue, text: "Moradia"),
                              const SizedBox(height: 8),
                              LegendItem(
                                  color: Colors.green, text: "Alimentação"),
                              const SizedBox(height: 8),
                              LegendItem(
                                  color: Colors.orange, text: "Transporte"),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16), // Espaçamento entre os blocos
                  Expanded(
                    flex: 2,
                    child: InfoContainer(
                      title: "Últimas Transações",
                      child: ListView(
                        children: [
                          TransactionItem(
                              name: "Pinceis",
                              value: "\$632.000",
                              date: "20/11"),
                          TransactionItem(
                              name: "Salário",
                              value: "\$632.000",
                              date: "20/11"),
                          TransactionItem(
                              name: "Reserva",
                              value: "\$632.000",
                              date: "20/11"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24), // Espaçamento entre os blocos
            // Gráfico de barras
            Expanded(
              flex: 5,
              child: InfoContainer(
                title: "Entradas x Saídas",
                child: BarChart(
                  BarChartData(
                    barGroups: [
                      makeBarGroup(1, 200, 150),
                      makeBarGroup(2, 180, 160),
                      makeBarGroup(3, 220, 170),
                      makeBarGroup(4, 250, 190),
                      makeBarGroup(5, 200, 150),
                      makeBarGroup(6, 180, 160),
                      makeBarGroup(7, 220, 170),
                      makeBarGroup(8, 850, 190),
                      makeBarGroup(9, 200, 150),
                      makeBarGroup(10, 180, 160),
                      makeBarGroup(11, 220, 170),
                      makeBarGroup(12, 250, 190),
                    ],
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          reservedSize:
                              22, // Deixa espaço suficiente para o eixo X
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles:
                              false, // Remover os valores de Y do lado esquerdo
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles:
                              false, // Remover os valores de Y do lado direito
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Text('Página ainda não implementada'),
      );
    }
  }

  BarChartGroupData makeBarGroup(int x, double entradas, double saidas) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: entradas,
          color: Colors.blue,
          width: 10,
        ),
        BarChartRodData(
          toY: saidas,
          color: Colors.red,
          width: 10,
        ),
      ],
    );
  }
}

// Outras classes permanecem iguais

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String title;
  final Widget child;

  InfoContainer({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(child: child),
        ],
      ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  final String name;
  final String value;
  final String date;

  TransactionItem(
      {required this.name, required this.value, required this.date});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(fontSize: 14)),
          Text(value,
              style:
                  const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          Text(date, style: const TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;

  LegendItem({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
