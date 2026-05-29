import 'package:app_livros/model/livro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LivroService {
  final SupabaseClient _client;

  LivroService([SupabaseClient? client])
      : _client = client ?? Supabase.instance.client;

  String get _userId {
    final id = _client.auth.currentUser?.id;
    if (id == null) {
      throw Exception('Usuário não autenticado.');
    }
    return id;
  }

  Future<List<Livro>> getLivros() async {
    final response = await _client
        .from('Livros')
        .select()
        .eq('user_id', _userId)
        .order('id', ascending: true);

    return response.map((item) => Livro.fromMap(item)).toList();
  }

  Future<void> salvarLivro(Livro livro) async {
    final dados = livro.toMap();
    dados['user_id'] = _userId;
    await _client.from('Livros').insert(dados);
  }

  Future<void> atualizarLivro(Livro livro) async {
    if (livro.id == null) {
      throw Exception('Não é possível atualizar um livro sem ID.');
    }

    await _client
        .from('Livros')
        .update(livro.toMap())
        .eq('id', livro.id!)
        .eq('user_id', _userId);
  }

  Future<void> deletarLivro(int id) async {
    await _client.from('Livros').delete().eq('id', id).eq('user_id', _userId);
  }
}
