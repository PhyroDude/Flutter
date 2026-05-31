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
      title: 'Catálogo de Fotografías',
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
      'autor': 'Carlos Méndez',
      'anio': '2023',
      'descripcion': 'Paisaje urbano capturado al atardecer.',
      'imagen': 'https://picsum.photos/600?1',
    },
    {
      'nombre': 'Fotografía 2',
      'precio': '\$450',
      'autor': 'Laura Gómez',
      'anio': '2022',
      'descripcion': 'Retrato artístico en blanco y negro.',
      'imagen': 'https://picsum.photos/600?2',
    },
    {
      'nombre': 'Fotografía 3',
      'precio': '\$300',
      'autor': 'Miguel Ruiz',
      'anio': '2021',
      'descripcion': 'Naturaleza y montañas en temporada invernal.',
      'imagen': 'https://picsum.photos/600?3',
    },
    {
      'nombre': 'Fotografía 4',
      'precio': '\$220',
      'autor': 'Ana Torres',
      'anio': '2024',
      'descripcion': 'Fotografía documental de la vida cotidiana.',
      'imagen': 'https://picsum.photos/600?4',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Fotografías'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar fotografía...',
                prefixIcon: const Icon(Icons.search),
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
                                child: Hero(
                                  tag: producto['imagen']!,
                                  child: Image.network(
                                    producto['imagen']!,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
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
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) =>
                                              DetalleFotoPage(
                                            producto: producto,
                                          ),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      'Ver detalles',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DetalleFotoPage extends StatefulWidget {
  final Map<String, String> producto;

  const DetalleFotoPage({
    super.key,
    required this.producto,
  });

  @override
  State<DetalleFotoPage> createState() =>
      _DetalleFotoPageState();
}

class _DetalleFotoPageState
    extends State<DetalleFotoPage> {

  final _formKey = GlobalKey<FormState>();

  final nombreController =
      TextEditingController();

  final correoController =
      TextEditingController();

  String? categoriaSeleccionada;

  final List<String> categorias = [
    'Paisaje',
    'Retrato',
    'Documental',
    'Artística',
  ];

  @override
  void dispose() {
    nombreController.dispose();
    correoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final producto = widget.producto;

    return Scaffold(
      appBar: AppBar(
        title: Text(producto['nombre']!),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [

            Hero(
              tag: producto['imagen']!,
              child: Image.network(
                producto['imagen']!,
                height: 350,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start,
                children: [

                  Text(
                    producto['nombre']!,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 20),

                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Autor'),
                    subtitle:
                        Text(producto['autor']!),
                  ),

                  ListTile(
                    leading:
                        const Icon(Icons.calendar_month),
                    title:
                        const Text('Año de publicación'),
                    subtitle:
                        Text(producto['anio']!),
                  ),

                  ListTile(
                    leading:
                        const Icon(Icons.attach_money),
                    title: const Text('Precio'),
                    subtitle:
                        Text(producto['precio']!),
                  ),

                  

                  const Divider(height: 40),

                  const Text(
                    'Solicitar información',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        TextFormField(
                          controller:
                              nombreController,
                          autovalidateMode:
                              AutovalidateMode
                                  .onUserInteraction,
                          decoration:
                              const InputDecoration(
                            labelText: 'Nombre',
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty) {
                              return 'Ingrese su nombre';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        TextFormField(
                          controller:
                              correoController,
                          autovalidateMode:
                              AutovalidateMode
                                  .onUserInteraction,
                          decoration:
                              const InputDecoration(
                            labelText:
                                'Correo electrónico',
                            border:
                                OutlineInputBorder(),
                          ),
                          validator: (value) {

                            if (value == null ||
                                value.isEmpty) {
                              return 'Ingrese un correo';
                            }

                            final regex = RegExp(
                              r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );

                            if (!regex.hasMatch(value)) {
                              return 'Correo inválido';
                            }

                            return null;
                          },
                        ),

                        const SizedBox(height: 15),

                        DropdownButtonFormField<
                            String>(
                          value:
                              categoriaSeleccionada,
                          decoration:
                              const InputDecoration(
                            labelText:
                                'Categoría de interés',
                            border:
                                OutlineInputBorder(),
                          ),
                          items: categorias
                              .map((categoria) {
                            return DropdownMenuItem(
                              value: categoria,
                              child:
                                  Text(categoria),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              categoriaSeleccionada =
                                  value;
                            });
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Seleccione una categoría';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        ElevatedButton.icon(
                          icon: const Icon(
                            Icons.send,
                          ),
                          label:
                              const Text('Enviar'),
                          onPressed: () {

                            if (_formKey
                                .currentState!
                                .validate()) {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Colors.green,
                                  content: Text(
                                    'Solicitud enviada correctamente',
                                  ),
                                ),
                              );

                            } else {

                              ScaffoldMessenger.of(
                                      context)
                                  .showSnackBar(
                                const SnackBar(
                                  backgroundColor:
                                      Colors.red,
                                  content: Text(
                                    'Corrija los errores del formulario',
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}