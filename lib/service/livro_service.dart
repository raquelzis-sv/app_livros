import 'package:app_livros/model/livro.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LivroService {
  final _client = Supabase.instance.client;
  // Busca todas os livros da tabela remota
  Future<List<Livro>> getLivros() async {
    final response = await _client
        .from('Livros')
        .select()
        .order('id', ascending: true); // Ordena de forma crescente
    return response.map((item) => Livro.fromMap(item)).toList();
  }

  // Insere um novo livro
  Future<void> salvarLivro(Livro livro) async {
    await _client.from('Livros').insert(livro.toMap());
  }

  // Atualiza os dados gerais do livro (título, autor, gênero, cor, etc.)
  Future<void> atualizarLivro(Livro livro) async {
    if (livro.id == null) {
      throw Exception('Não é possível atualizar um livro sem ID.');
    }

    await _client
        .from('Livros')
        .update(livro.toMap())
        .eq(
          'id',
          livro.id!,
        ); // Filtra pelo ID para atualizar o registro correto
  }

  // Remove o registro da tabela em nuvem através do ID correspondente
  Future<void> deletarLivro(int id) async {
    await _client.from('Livros').delete().eq('id', id);
  }
}
