import 'package:flutter/material.dart';
import 'package:sophia/core/constans/colors%20and%20fonts.dart';

class EstoqueForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final Function(String item, int quantidade, double valor) onSubmit;
  final String? initialItem;
  final int? initialQuantidade;
  final double? initialValor;

  EstoqueForm({
    required this.formKey,
    required this.onSubmit,
    this.initialItem,
    this.initialQuantidade,
    this.initialValor,
  });

  @override
  _EstoqueFormState createState() => _EstoqueFormState();
}

class _EstoqueFormState extends State<EstoqueForm> {
  late TextEditingController _itemController;
  late TextEditingController _quantidadeController;
  late TextEditingController _valorController;

  String? item;
  int? quantidade;
  double? valor;

  @override
  void initState() {
    super.initState();
    _itemController = TextEditingController(text: widget.initialItem);
    _quantidadeController =
        TextEditingController(text: widget.initialQuantidade?.toString());
    _valorController =
        TextEditingController(text: widget.initialValor?.toString());

    item = widget.initialItem;
    quantidade = widget.initialQuantidade;
    valor = widget.initialValor;
  }

  void resetForm() {
    _itemController.clear();
    _quantidadeController.clear();
    _valorController.clear();
    setState(() {
      item = null;
      quantidade = null;
      valor = null;
    });
  }

  @override
  void dispose() {
    _itemController.dispose();
    _quantidadeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23.0),
      child: Form(
        key: widget.formKey,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: TextFormField(
                          controller: _itemController,
                          decoration: const InputDecoration(
                            labelText: 'Item',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) => item = value,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _quantidadeController,
                          decoration: const InputDecoration(
                            labelText: 'Quantidade',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) =>
                              quantidade = int.tryParse(value),
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
                ],
              ),
            ),
            const SizedBox(width: 16), // Espaço entre o formulário e o botão
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
                    widget.onSubmit(item!, quantidade!, valor!);
                    resetForm(); // Reseta o formulário após salvar
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
