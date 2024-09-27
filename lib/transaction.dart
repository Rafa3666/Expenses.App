class Transaction {
  final String id; // Identificador único da transação.
  final String title; // Título da transação.
  final double value; // Valor da transação.
  final DateTime date; // Data da transação.

  Transaction({
    required this.id,
    required this.title,
    required this.value,
    required this.date,
  });
}
