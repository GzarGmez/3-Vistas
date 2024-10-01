import 'package:flutter/material.dart';

void main() => runApp(const ThirdPage());

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Usuario',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 39, 116, 164),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 48, 108, 164),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 24, 122, 183),
            foregroundColor: Colors.white,
          ),
        ),
      ),
      home: const PaginaComida(),
    );
  }
}

class PaginaComida extends StatefulWidget {
  const PaginaComida({super.key});

  @override
  _PaginaComidaState createState() => _PaginaComidaState();
}

class _PaginaComidaState extends State<PaginaComida>
    with SingleTickerProviderStateMixin {
  late TabController _controladorTab;
  final TextEditingController _controladorTexto = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controladorTab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _controladorTab.dispose();
    _controladorTexto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App de Libros aleatorios'),
        bottom: TabBar(
          controller: _controladorTab,
          tabs: const [
            Tab(icon: Icon(Icons.fastfood), text: 'Inicio'),
            Tab(icon: Icon(Icons.list), text: 'Categorías'),
            Tab(icon: Icon(Icons.settings), text: 'Configuración'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _controladorTab,
        children: [
          _construirPestanaInicio(),
          _construirPestanaCategorias(),
          _construirPestanaConfiguracion(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Buscar'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        ],
        selectedItemColor: const Color.fromARGB(255, 43, 140, 150),
        unselectedItemColor: const Color.fromARGB(255, 53, 111, 153),
      ),
    );
  }

  Widget _construirPestanaInicio() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '¡Bienvenido a la App de Libros Aleatorios!',
            style: TextStyle(
                fontSize: 24, color: const Color.fromARGB(255, 48, 117, 156)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            'Explora nuevos libros y mundos que descubrir',
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 54, 142, 164)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _construirPestanaCategorias() {
    final List<String> categorias = [
      'Acción',
      'Terror',
      'Amor',
      'Ciencia Ficción',
      'Los más famosos',
      'Anime',
    ];
    return ListView.builder(
      itemCount: categorias.length,
      itemBuilder: (context, index) {
        return Card(
          color: const Color.fromARGB(255, 23, 110, 144),
          child: ListTile(
            title: Text(categorias[index],
                style:
                    TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
            leading: Icon(Icons.category,
                color: const Color.fromARGB(255, 48, 114, 158)),
            trailing: Icon(Icons.arrow_forward_ios,
                color: const Color.fromARGB(255, 38, 83, 134)),
            onTap: () {
              // Acción cuando se toca una categoría
            },
          ),
        );
      },
    );
  }

  Widget _construirPestanaConfiguracion() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _controladorTexto,
            decoration: InputDecoration(
              labelText: 'Ingresa tu libro favorito',
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: const Color.fromARGB(255, 0, 0, 0)!),
              ),
              labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Acción para guardar el libro favorita
            },
            child: const Text('Guardar Favorito'),
          ),
        ],
      ),
    );
  }
}
