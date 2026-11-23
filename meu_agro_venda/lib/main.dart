
import 'package:flutter/material.dart';

const Color verdePrincipal = Color(0xFF006332);
const Color verdeEscuro = Color(0xFF145D35);
const Color verdeClaro = Color(0xFFF0F7EF);
const Color bordaVerde = Color(0xFFE1EAE1);
const Color amareloPrincipal = Color(0xFFFFC629);

void main() {
  runApp(const AplicativoAgroVende());
}

class AplicativoAgroVende extends StatelessWidget {
  const AplicativoAgroVende({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AgroVende',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: verdePrincipal,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const TelaInicial(),
    );
  }
}

// LOGO DO AGROVENDE

class LogoAgroVende extends StatelessWidget {
  final double tamanho;

  const LogoAgroVende({
    super.key,
    required this.tamanho,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: tamanho,
      height: tamanho,
      decoration: const BoxDecoration(
        color: verdePrincipal,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.eco,
        color: Colors.white,
        size: tamanho * 0.65,
      ),
    );
  }
}

// TELA 1 - LOGIN

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final TextEditingController controladorUsuario =
      TextEditingController();

  final TextEditingController controladorSenha =
      TextEditingController();

  bool lembrarMe = true;
  bool mostrarSenha = false;

  @override
  void dispose() {
    controladorUsuario.dispose();
    controladorSenha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (contexto, restricoes) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: restricoes.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 340,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                        ),
                        child: Column(
                          children: [
                            const SizedBox(height: 40),

                            const LogoAgroVende(
                              tamanho: 58,
                            ),

                            const SizedBox(height: 12),

                            const Text(
                              'AgroVende',
                              style: TextStyle(
                                color: verdeEscuro,
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 2),

                            const Text(
                              'Gestão de vendas do campo',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                              ),
                            ),

                            const SizedBox(height: 40),

                            // CAMPO USUÁRIO

                            _campoTexto(
                              controlador: controladorUsuario,
                              texto: 'Usuário',
                            ),

                            const SizedBox(height: 11),

                            // CAMPO SENHA

                            _campoTexto(
                              controlador: controladorSenha,
                              texto: 'Senha',
                              senha: true,
                            ),

                            const SizedBox(height: 8),

                            // LEMBRAR-ME E ESQUECI MINHA SENHA

                            Row(
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: Checkbox(
                                    value: lembrarMe,
                                    activeColor: verdePrincipal,
                                    visualDensity:
                                        VisualDensity.compact,
                                    onChanged: (valor) {
                                      setState(() {
                                        lembrarMe = valor ?? false;
                                      });
                                    },
                                  ),
                                ),
                                const Text(
                                  'Lembrar-me',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.black87,
                                  ),
                                ),
                                const Spacer(),
                                TextButton(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Entre em contato com o administrador para recuperar sua senha.',
                                        ),
                                      ),
                                    );
                                  },
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                  child: const Text(
                                    'Esqueci minha senha',
                                    style: TextStyle(
                                      color: verdeEscuro,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 22),

                            // BOTÃO ENTRAR

                            SizedBox(
                              width: double.infinity,
                              height: 37,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const TelaIntegrantes(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: verdePrincipal,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(25),
                                  ),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // RODAPÉ

                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const TelaIntegrantes(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Integrantes do Projeto',
                                style: TextStyle(
                                  color: verdeEscuro,
                                  fontSize: 10,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            Container(
                              width: 30,
                              height: 3,
                              decoration: BoxDecoration(
                                color: amareloPrincipal,
                                borderRadius:
                                    BorderRadius.circular(5),
                              ),
                            ),

                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _campoTexto({
    required TextEditingController controlador,
    required String texto,
    bool senha = false,
  }) {
    return SizedBox(
      height: 36,
      child: TextField(
        controller: controlador,
        obscureText: senha && !mostrarSenha,
        style: const TextStyle(
          fontSize: 11,
          color: Colors.black87,
        ),
        decoration: InputDecoration(
          hintText: texto,
          hintStyle: const TextStyle(
            fontSize: 11,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: bordaVerde,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: verdePrincipal,
              width: 1,
            ),
          ),
          suffixIcon: senha
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      mostrarSenha = !mostrarSenha;
                    });
                  },
                  icon: Icon(
                    mostrarSenha
                        ? Icons.visibility_off
                        : Icons.visibility,
                    size: 16,
                    color: Colors.grey,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

// TELA 2 - INTEGRANTES DO PROJETO

class TelaIntegrantes extends StatelessWidget {
  const TelaIntegrantes({super.key});

  static const List<String> integrantes = [
    'ANDERSON VANZETTO',
    'EMILLY CORCETE DOS SANTOS',
    'FRANCIELE TERNES KUSSLER',
    'MONIQUE CRISTINA LEÃO ALVES',
    'LUCCAS FAGUNDES DE SOUZA',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (contexto, restricoes) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: restricoes.maxHeight,
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: 340,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(height: 28),

                          const LogoAgroVende(
                            tamanho: 40,
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'AgroVende',
                            style: TextStyle(
                              color: verdeEscuro,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 32),

                          const Text(
                            'Integrantes do Projeto:',
                            style: TextStyle(
                              color: verdeEscuro,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 18),

                          // CARTÕES DOS INTEGRANTES

                          ...List.generate(
                            integrantes.length,
                            (indice) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  bottom: 8,
                                ),
                                child: Container(
                                  width: 230,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: verdeClaro,
                                    border: Border.all(
                                      color: bordaVerde,
                                      width: 1,
                                    ),
                                    borderRadius:
                                        BorderRadius.circular(7),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 9),

                                      Container(
                                        width: 25,
                                        height: 25,
                                        decoration:
                                            const BoxDecoration(
                                          color: Color(0xFFE8F4E3),
                                          shape: BoxShape.circle,
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          '${indice + 1}',
                                          style: const TextStyle(
                                            color: verdePrincipal,
                                            fontSize: 10,
                                            fontWeight:
                                                FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(width: 9),

                                      Expanded(
                                        child: Text(
                                          integrantes[indice],
                                          style: const TextStyle(
                                            color: verdeEscuro,
                                            fontSize: 9,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                          maxLines: 1,
                                          overflow:
                                              TextOverflow.ellipsis,
                                        ),
                                      ),

                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),

                          const SizedBox(height: 18),

                          // BOTÃO CONTINUAR

                          SizedBox(
                            width: 230,
                            height: 34,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: verdePrincipal,
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(25),
                                ),
                              ),
                              child: const Text(
                                'Continuar',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 21),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
