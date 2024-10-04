import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Formulário para adicionar uma nova transação
class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime)
      onSubmit; // Função callback para enviar dados do formulário

  const TransactionForm(this.onSubmit, {super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  // Controladores dos campos de texto
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  DateTime? _selectedDate = DateTime.now(); // Data selecionada para a transação

  // Envia o formulário
  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return; // Valida se o formulário está corretamente preenchido
    }

    widget.onSubmit(
        title, value, _selectedDate!); // Passa os dados para a função callback
  }

  // Abre o seletor de datas
  _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2022), // Primeira data disponível
      lastDate: DateTime.now(), // Última data permitida é o dia atual
    ).then((pickedDate) {
      if (pickedDate == null) {
        return; // Se o usuário cancelar a seleção, retorna sem alterar a data
      }
      setState(() {
        _selectedDate = pickedDate; // Atualiza a data selecionada
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5, // Define a sombra do Card
      child: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: 8.0, horizontal: 20), // Espaçamento interno do Card
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                  labelText: "Título"), // Campo para o título da transação
            ),
            TextField(
              controller: _valueController,
              keyboardType: TextInputType.number, // Teclado numérico
              onSubmitted: (_) => _submitForm(),
              decoration: const InputDecoration(
                  labelText: "Valor (R\$)"), // Campo para o valor da transação
            ),
            SizedBox(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate != null
                          ? DateFormat("dd/MM/y").format(_selectedDate!)
                          : "Nenhuma data selecionada!", // Exibe a data selecionada ou um texto padrão
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor:
                          Theme.of(context).primaryColor, // Cor do botão
                    ),
                    onPressed: _showDatePicker, // Abre o seletor de data
                    child: const Text(
                      "Selecionar Data",
                      style: TextStyle(
                          fontWeight: FontWeight
                              .bold), // Texto do botão de seleção de data
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.end, // Alinha o botão à direita
              children: <Widget>[
                ElevatedButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white, // Cor do texto do botão
                    backgroundColor: Colors.deepPurple, // Cor de fundo do botão
                  ),
                  onPressed:
                      _submitForm, // Chama a função de envio do formulário
                  child: const Text(
                    "Nova Transação",
                    style: TextStyle(
                        fontWeight: FontWeight.bold), // Texto do botão de envio
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
