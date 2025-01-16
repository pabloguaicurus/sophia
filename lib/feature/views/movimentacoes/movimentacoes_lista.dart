import 'package:flutter/material.dart';
import 'movimentacao.dart';

class MovimentacoesLista extends StatelessWidget {
  final List<Movimentacao> movimentacoes;
  final Function(int index) onDelete;
  final Function(int index) onEdit;

  MovimentacoesLista({
    required this.movimentacoes,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(label: Text('Tipo')),
        DataColumn(label: Text('Data')),
        DataColumn(label: Text('Descrição')),
        DataColumn(label: Text('Valor')),
        DataColumn(label: Text('Categoria')),
        DataColumn(label: Text('Ações')),
      ],
      rows: movimentacoes.asMap().entries.map((entry) {
        int index = entry.key;
        Movimentacao mov = entry.value;

        return DataRow(cells: [
          DataCell(Text(mov.tipo)),
          DataCell(Text('${mov.data.day}/${mov.data.month}')),
          DataCell(Text(mov.descricao)),
          DataCell(Text('\$${mov.valor.toStringAsFixed(2)}')),
          DataCell(Text(mov.categoria)),
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
