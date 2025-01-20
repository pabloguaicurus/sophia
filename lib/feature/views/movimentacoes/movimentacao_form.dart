import 'package:flutter/material.dart';
import 'package:sophia/core/constans/colors%20and%20fonts.dart';

class MovimentacaoForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String tipo, DateTime data, String descricao, double valor,
      String categoria) onSubmit;
  final String? initialTipo;
  final DateTime? initialData;
  final String? initialDescricao;
  final double? initialValor;
  final String? initialCategoria;

  MovimentacaoForm({
    required this.formKey,
    required this.onSubmit,
    this.initialTipo,
    this.initialData,
    this.initialDescricao,
    this.initialValor,
    this.initialCategoria,
  });

  @override
  _MovimentacaoFormState createState() => _MovimentacaoFormState();
}

class _MovimentacaoFormState extends State<MovimentacaoForm> {
  late TextEditingController _descricaoController;
  late TextEditingController _valorController;
  late TextEditingController _dataController;

  String? tipo;
  DateTime? data;
  String? descricao;
  double? valor;
  String? categoria;

  @override
  void initState() {
    super.initState();
    _descricaoController = TextEditingController(text: widget.initialDescricao);
    _valorController =
        TextEditingController(text: widget.initialValor?.toString());
    _dataController = TextEditingController(
        text: widget.initialData?.toString().split(' ')[0]);

    tipo = widget.initialTipo;
    data = widget.initialData;
    descricao = widget.initialDescricao;
    valor = widget.initialValor;
    categoria = widget.initialCategoria;
  }

  void resetForm() {
    _descricaoController.clear();
    _valorController.clear();
    _dataController.clear();
    setState(() {
      tipo = null;
      data = null;
      descricao = null;
      valor = null;
      categoria = null;
    });
  }

  @override
  void dispose() {
    _descricaoController.dispose();
    _valorController.dispose();
    _dataController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Form(
        key: widget.formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: tipo,
                    items: ['Entrada', 'Saída']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() => tipo = value),
                    decoration: const InputDecoration(
                      labelText: 'Tipo de movimentação',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _dataController,
                    decoration: const InputDecoration(
                      labelText: 'Data',
                      border: OutlineInputBorder(),
                    ),
                    readOnly: true,
                    onTap: () async {
                      data = await showDatePicker(
                        context: context,
                        initialDate: data ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (data != null) {
                        _dataController.text = data.toString().split(' ')[0];
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _valorController,
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => valor = double.tryParse(value),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _descricaoController,
                    decoration: const InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => descricao = value,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: categoria,
                    items: ['Material', 'Serviço']
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (value) => setState(() => categoria = value),
                    decoration: const InputDecoration(
                      labelText: 'Categoria',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.save, color: Colors.white),
                    onPressed: () {
                      if (widget.formKey.currentState!.validate()) {
                        widget.onSubmit(
                            tipo!, data!, descricao!, valor!, categoria!);
                        resetForm(); // Reseta o formulário após salvar
                      }
                    },
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
