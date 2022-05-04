import 'dart:math';

import 'package:garagem_burger/models/cartao.dart';
import 'package:garagem_burger/models/localizacao.dart';
import 'package:garagem_burger/models/pedido.dart';
import 'package:garagem_burger/models/produto.dart';

final produtos = [
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Dodge Americano',
    preco: 25.00,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Opala',
    preco: 20.00,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Ford Maverick',
    preco: 20.00,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Petit Gâteau',
    preco: 12.00,
    tipo: Tipo.sobremesa,
  ),
];

final meusLanches = [
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'X-Infarto de Sara',
    preco: 24.90,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Morgana de Will',
    preco: 21.90,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Gulodice de João',
    preco: 24.90,
    tipo: Tipo.hamburguer,
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Big Tentação de Lara',
    preco: 32.90,
    tipo: Tipo.hamburguer,
  ),
];

final pedidos = [
  Pedido(
    id: Random().nextDouble().toString(),
    data: "24/04/2022",
    hora: "21:00",
    status: Status.pendente,
  ),
  Pedido(
    id: Random().nextDouble().toString(),
    data: "25/04/2022",
    hora: "21:00",
    status: Status.cancelado,
  ),
  Pedido(
    id: Random().nextDouble().toString(),
    data: "26/04/2022",
    hora: "21:00",
    status: Status.entregue,
  ),
];

final localizacoes = [
  Localizacao(
    id: Random().nextDouble().toString(),
    rua: 'Rua ABC',
    numero: 150,
    bairro: 'Jequiézinho',
    cidade: 'Jequié',
    estado: 'Bahia',
    favorite: true,
    descricao: 'Minha casa',
  ),
  Localizacao(
    id: Random().nextDouble().toString(),
    rua: 'Rua Bruno Neto',
    numero: 1587,
    bairro: 'Mandacaru',
    cidade: 'Jequié',
    estado: 'Bahia',
    favorite: false,
    descricao: 'Casa de Tia Mony',
  ),
];

final cartoes = [
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
];