import 'package:flutter/material.dart';
import 'package:sophia/core/widgets/sidebar.dart';
import 'estoque.dart';
import 'estoque_form.dart';
import 'estoque_lista.dart';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  final List<Estoque> _estoque = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedPage = 'Estoque';

  void _addEstoque(String item, int quantidade, double valor) {
    setState(() {
      _estoque.add(
        Estoque(
          item: item,
          quantidade: quantidade,
          valor: valor,
        ),
      );
    });

    // Resetar o formulário após adicionar
    _formKey.currentState?.reset();
  }

  void _deleteEstoque(int index) {
    setState(() {
      _estoque.removeAt(index);
    });
  }

  void _editEstoque(int index) {
    final estoque = _estoque[index];
    final GlobalKey<FormState> _editFormKey = GlobalKey<FormState>();
    String? item = estoque.item;
    int? quantidade = estoque.quantidade;
    double? valor = estoque.valor;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Estoque'),
          content: SingleChildScrollView(
            child: EstoqueForm(
              formKey: _editFormKey,
              onSubmit: (newItem, newQuantidade, newValor) {
                if (_editFormKey.currentState!.validate()) {
                  setState(() {
                    _estoque[index] = Estoque(
                      item: newItem,
                      quantidade: newQuantidade,
                      valor: newValor,
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              initialItem: item,
              initialQuantidade: quantidade,
              initialValor: valor,
            ),
          ),
        );
      },
    );
  }

  void _handleMenuSelection(String selectedPage) {
    setState(() {
      _selectedPage = selectedPage;
    });

    if (selectedPage == 'Dashboard') {
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (selectedPage == 'Movimentações') {
      Navigator.pushReplacementNamed(context, '/movimentacoes');
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
            child: _buildPageContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedPage == 'Estoque') {
      return Column(
        children: [
          AppBar(
            title: Text(
              'Estoque',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          EstoqueForm(
            formKey: _formKey,
            onSubmit: _addEstoque,
          ),
          Expanded(
            child: EstoqueLista(
              estoque: _estoque,
              onDelete: _deleteEstoque,
              onEdit: _editEstoque,
            ),
          ),
        ],
      );
    } else {
      return Center(
        child: Text('Página ainda não implementada'),
      );
    }
  }
}
