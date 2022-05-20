import 'dart:math';
import 'package:garagem_burger/models/produto.dart';

// final produtos = [
//   Produto(
//     id: Random().nextDouble().toString(),
//     nome: 'Dodge Americano',
//     preco: 25.00,
//     tipo: Produto.hamburguerCasa,
//   ),
//   Produto(
//     id: Random().nextDouble().toString(),
//     nome: 'Opala',
//     preco: 20.00,
//     tipo: Produto.hamburguerCasa,
//   ),
//   Produto(
//     id: Random().nextDouble().toString(),
//     nome: 'Ford Maverick',
//     preco: 20.00,
//     tipo: Produto.hamburguerCasa,
//   ),
//   Produto(
//     id: Random().nextDouble().toString(),
//     nome: 'Petit Gâteau',
//     preco: 12.00,
//     tipo: Produto.sobremesa,
//   ),
// ];

final meusLanches = [
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'X-Infarto de Sara',
    preco: 24.90,
    tipo: Produto.hamburguerCasa,
    quantidade: 0,
    unidadeMedida: '',
    urlImage: '',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Morgana de Will',
    preco: 21.90,
    tipo: Produto.hamburguerCasa,
    quantidade: 0,
    unidadeMedida: '',
    urlImage: '',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Gulodice de João',
    preco: 24.90,
    tipo: Produto.hamburguerCasa,
    unidadeMedida: '',
    urlImage: '',
    quantidade: 0,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Big Tentação de Lara',
    preco: 32.90,
    tipo: Produto.hamburguerCasa,
    urlImage: '',
    unidadeMedida: '',
    quantidade: 0,
  ),
];

/*
final pedidos = [
  Pedido(
    id: Random().nextDouble().toString(),
    data: DateTime.now(),
    status: Pedido.pendente,
  ),
  Pedido(
    id: Random().nextDouble().toString(),
    data: DateTime.now(),
    status: Pedido.cancelado,
  ),
  Pedido(
    id: Random().nextDouble().toString(),
    data: DateTime.now(),
    status: Pedido.entregue,
  ),
];
*/

/*final localizacoes = [
  Localizacao(
    id: Random().nextDouble().toString(),
    rua: 'Rua ABC',
    numero: 150,
    bairro: 'Jequiézinho',
    cidade: 'Jequié',
    estado: 'Bahia',
    favorite: true,
    description: 'Minha casa',
  ),
  Localizacao(
    id: Random().nextDouble().toString(),
    rua: 'Rua Bruno Neto',
    numero: 1587,
    bairro: 'Mandacaru',
    cidade: 'Jequié',
    estado: 'Bahia',
    favorite: false,
    description: 'Casa de Tia Mony',
  ),
];*/

/*final cartoes = [
  Cartao(
    id: Random().nextDouble().toString(),
    description: 'Meu cartão 1',
    cardNumber: '123456789',
    dueDate: '10/22',
    favorite: true,
  ),
  Cartao(
    id: Random().nextDouble().toString(),
    description: 'Meu cartão 2',
    cardNumber: '123450000',
    dueDate: '10/24',
    favorite: false,
  ),
  Cartao(
    id: Random().nextDouble().toString(),
    description: 'Meu cartão 3',
    cardNumber: '987654321',
    dueDate: '11/25',
    favorite: false,
  ),
  Cartao(
    id: Random().nextDouble().toString(),
    description: 'Meu cartão 4',
    cardNumber: '257849310',
    dueDate: '07/24',
    favorite: false,
  ),
  Cartao(
    id: Random().nextDouble().toString(),
    description: 'Meu cartão 5',
    cardNumber: '547891647',
    dueDate: '02/26',
    favorite: false,
  ),
];*/
