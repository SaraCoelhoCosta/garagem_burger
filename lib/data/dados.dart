import 'dart:math';
import 'package:garagem_burger/models/produto.dart';

final meusLanches = [
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'X-Infarto de Sara',
    preco: 24.90,
    tipo: Produto.hamburguerCasa,
    quantidade: 0,
    unidadeMedida: '',
    urlImage: '',
    recipiente: '',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Morgana de Will',
    preco: 21.90,
    tipo: Produto.hamburguerCasa,
    quantidade: 0,
    unidadeMedida: '',
    urlImage: '',
    recipiente: '',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Gulodice de João',
    preco: 24.90,
    tipo: Produto.hamburguerCasa,
    unidadeMedida: '',
    urlImage: '',
    quantidade: 0,
    recipiente: '',
  ),
  Produto(
    id: Random().nextDouble().toString(),
    nome: 'Big Tentação de Lara',
    preco: 32.90,
    tipo: Produto.hamburguerCasa,
    urlImage: '',
    unidadeMedida: '',
    quantidade: 0,
    recipiente: '',
  ),
];
