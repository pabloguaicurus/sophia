import 'package:flutter/material.dart';
import 'estoque.dart';

class EstoqueLista extends StatelessWidget {
  final List<Estoque> estoque;
  final Function(int index) onDelete;
  final Function(int index) onEdit;

  EstoqueLista({
    required this.estoque,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Item')),
        DataColumn(label: Text('Quantidade')),
        DataColumn(label: Text('Valor Unitário')),
        DataColumn(label: Text('Valor Total')),
        DataColumn(label: Text('Ações')),
      ],
      rows: estoque.asMap().entries.map((entry) {
        int index = entry.key;
        Estoque est = entry.value;
        double valorTotal = est.quantidade * est.valor;

        return DataRow(cells: [
          DataCell(Text(est.item)),
          DataCell(Text(est.quantidade.toString())),
          DataCell(Text('\$${est.valor.toStringAsFixed(2)}')),
          DataCell(Text('\$${valorTotal.toStringAsFixed(2)}')),
          DataCell(
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => onEdit(index),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => onDelete(index),
                ),
              ],
            ),
          ),
        ]);
      }).toList(),
    );
  }
}
