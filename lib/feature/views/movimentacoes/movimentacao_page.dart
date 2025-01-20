import 'package:flutter/material.dart';
import 'package:sophia/core/widgets/sidebar.dart';
import 'movimentacao.dart';
import 'movimentacao_form.dart';
import 'movimentacoes_lista.dart';

class MovimentacaoPage extends StatefulWidget {
  @override
  _MovimentacaoPageState createState() => _MovimentacaoPageState();
}

class _MovimentacaoPageState extends State<MovimentacaoPage> {
  final List<Movimentacao> _movimentacoes = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _selectedPage = 'Movimentações';

  void _addMovimentacao(String tipo, DateTime data, String descricao,
      double valor, String categoria) {
    setState(() {
      _movimentacoes.add(
        Movimentacao(
          tipo: tipo,
          data: data,
          descricao: descricao,
          valor: valor,
          categoria: categoria,
        ),
      );
    });

    // Resetar o formulário após adicionar
    _formKey.currentState?.reset();
  }

  void _deleteMovimentacao(int index) {
    setState(() {
      _movimentacoes.removeAt(index);
    });
  }

  void _editMovimentacao(int index) {
    final movimentacao = _movimentacoes[index];
    final GlobalKey<FormState> _editFormKey =
        GlobalKey<FormState>(); // Formulário de edição
    String? tipo = movimentacao.tipo;
    DateTime? data = movimentacao.data;
    String? descricao = movimentacao.descricao;
    double? valor = movimentacao.valor;
    String? categoria = movimentacao.categoria;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Movimentação'),
          content: SingleChildScrollView(
            child: MovimentacaoForm(
              formKey: _editFormKey,
              onSubmit:
                  (newTipo, newData, newDescricao, newValor, newCategoria) {
                if (_editFormKey.currentState!.validate()) {
                  setState(() {
                    _movimentacoes[index] = Movimentacao(
                      tipo: newTipo,
                      data: newData,
                      descricao: newDescricao,
                      valor: newValor,
                      categoria: newCategoria,
                    );
                  });
                  Navigator.of(context).pop();
                }
              },
              initialTipo: tipo,
              initialData: data,
              initialDescricao: descricao,
              initialValor: valor,
              initialCategoria: categoria,
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
            child: _buildPageContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent() {
    if (_selectedPage == 'Movimentações') {
      return Column(
        children: [
          AppBar(
            title: const Text('Movimentações'),
          ),
          MovimentacaoForm(
            formKey: _formKey,
            onSubmit: _addMovimentacao,
          ),
          Expanded(
            child: MovimentacoesLista(
              movimentacoes: _movimentacoes,
              onDelete: _deleteMovimentacao,
              onEdit: _editMovimentacao,
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
