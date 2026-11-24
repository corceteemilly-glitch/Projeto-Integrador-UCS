import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Banco {
  static final Banco instancia = Banco();
  Database? _db;
  static String hash(String senha) => sha256.convert(utf8.encode(senha)).toString();
  Future<Database> get db async => _db ??= await openDatabase(
    p.join(await getDatabasesPath(), 'agrovende.db'), version: 1,
    onConfigure: (d) async => d.execute('PRAGMA foreign_keys = ON'),
    onCreate: (d, v) async {
      await d.execute('CREATE TABLE usuario (id_usuario INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, login TEXT NOT NULL UNIQUE, senha TEXT NOT NULL)');
      await d.execute('CREATE TABLE cliente (id_cliente INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL, telefone TEXT NOT NULL, email TEXT, endereco TEXT)');
      await d.execute('CREATE TABLE produto (id_produto INTEGER PRIMARY KEY AUTOINCREMENT, nome TEXT NOT NULL UNIQUE, descricao TEXT, valor_unitario REAL NOT NULL CHECK(valor_unitario >= 0), unidade_medida TEXT NOT NULL)');
      await d.execute('CREATE TABLE venda (id_venda INTEGER PRIMARY KEY AUTOINCREMENT, id_cliente INTEGER NOT NULL REFERENCES cliente(id_cliente), id_produto INTEGER NOT NULL REFERENCES produto(id_produto), id_usuario INTEGER NOT NULL REFERENCES usuario(id_usuario), quantidade REAL NOT NULL CHECK(quantidade > 0), valor_unitario REAL NOT NULL CHECK(valor_unitario >= 0), valor_total REAL NOT NULL CHECK(valor_total >= 0), data_venda TEXT NOT NULL)');
      await d.insert('usuario', {'nome':'Administrador', 'login':'admin', 'senha':hash('123456')});
    });
  Future<int?> entrar(String login, String senha) async {
    final r = await (await db).query('usuario', where:'login = ? AND senha = ?', whereArgs:[login.trim(),hash(senha)]);
    return r.isEmpty ? null : r.first['id_usuario'] as int;
  }
  Future<List<Map<String,Object?>>> listar(String tabela) async => (await db).query(tabela, orderBy:'nome COLLATE NOCASE');
  Future<List<Map<String,Object?>>> vendas() async => (await db).rawQuery('SELECT v.*, c.nome AS cliente, p.nome AS produto, p.unidade_medida AS unidade, u.nome AS vendedor FROM venda v JOIN cliente c ON c.id_cliente=v.id_cliente JOIN produto p ON p.id_produto=v.id_produto JOIN usuario u ON u.id_usuario=v.id_usuario ORDER BY v.data_venda DESC, v.id_venda DESC');
  Future<void> salvar(String tabela, Map<String,Object?> dados, [int? id]) async {
    final d = await db;
    if(id==null) { await d.insert(tabela,dados); } else { await d.update(tabela,dados,where:'id_$tabela = ?',whereArgs:[id]); }
  }
  Future<void> excluir(String tabela,int id) async { await (await db).delete(tabela,where:'id_$tabela = ?',whereArgs:[id]); }
}
