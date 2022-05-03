class Cartao {
  final String id;
  final String description;
  final String cardNumber;
  final String dueDate;
  bool favorite;

  Cartao({
    required this.id,
    required this.description,
    required this.cardNumber,
    required this.dueDate,
   this.favorite = false,
  });
}