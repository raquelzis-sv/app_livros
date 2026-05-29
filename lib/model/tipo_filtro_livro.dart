enum TipoFiltroLivro {
  lidos,
  favoritos,
  naoCurtidos,
}

extension TipoFiltroLivroExt on TipoFiltroLivro {
  String get tituloRelatorio => switch (this) {
        TipoFiltroLivro.lidos => 'Livros lidos',
        TipoFiltroLivro.favoritos => 'Livros favoritos',
        TipoFiltroLivro.naoCurtidos => 'Livros não curtidos',
      };
}
