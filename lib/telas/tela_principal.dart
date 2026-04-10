import 'dart:ui';

import 'package:app_livros/models/livro.dart';
import 'package:app_livros/telas/tela_cadastro_livro.dart';
import 'package:app_livros/widgets/card_livros.dart';
import 'package:flutter/material.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  List<Livro> listaLivros = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Minha Biblioteca'),
        backgroundColor: const Color.fromARGB(255, 66, 13, 76),
        foregroundColor: Colors.white,

        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final retorno = await Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TelaCadastroLivro()),
              );
              if (retorno != null) {
                setState(() {
                  listaLivros.add(retorno);
                });
              }
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Bem-vindo à sua biblioteca!'),

              SizedBox(
                height: 250,
                child: PageView.builder(
                  scrollBehavior: const ScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: listaLivros.length,
                  itemBuilder: (context, index) {
                    return CardLivros(livro: listaLivros[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
