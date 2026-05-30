import 'package:flutter/material.dart';

void main() {
  runApp(const CatalogoApp());
}

class CatalogoApp extends StatelessWidget {
  const CatalogoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Catálogo',
      home: CatalogoPage(),
    );
  }
}

class CatalogoPage extends StatelessWidget {
  CatalogoPage({super.key});

  final List<Map<String, String>> productos = [
    {
      'nombre': 'Fotografía 1',
      'precio': '\$850',
      'imagen': 'https://picsum.photos/300?1'
    },
    {
      'nombre': 'Fotografía 2',
      'precio': '\$450',
      'imagen': 'https://picsum.photos/300?2'
    },
    {
      'nombre': 'Fotografía 3',
      'precio': '\$300',
      'imagen': 'https://picsum.photos/300?3'
    },
    {
      'nombre': 'Fotografía 4',
      'precio': '\$220',
      'imagen': 'https://picsum.photos/300?4'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Fotografías '),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Campo de búsqueda
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar producto...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {

                  int columnas = constraints.maxWidth > 900
                      ? 4
                      : constraints.maxWidth > 600
                          ? 3
                          : 2;

                  return GridView.builder(
                    itemCount: productos.length,
                    gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: columnas,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.70,
                    ),
                    itemBuilder: (context, index) {

                      final producto = productos[index];

                      return Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius:
                                    const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.network(
                                  producto['imagen']!,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                children: [
                                  Text(
                                    producto['nombre']!,
                                    style: const TextStyle(
                                      fontWeight:
                                          FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),

                                  const SizedBox(height: 4),

                                  Text(
                                    producto['precio']!,
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 15,
                                    ),
                                  ),

                                  const SizedBox(height: 8),

                                  ElevatedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Ver detalles',
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}