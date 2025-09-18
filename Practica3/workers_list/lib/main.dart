import 'package:flutter/material.dart';
import 'package:workers_list/worker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  List<Worker> trabajadores = [];

  TextEditingController _idCtrl = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _apellidos = TextEditingController();
  TextEditingController _edad = TextEditingController();

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _addWorker() {
    final id = _idCtrl.text.trim();
    final nombre = _name.text.trim();
    final apellidos = _apellidos.text.trim();
    final edadStr = _edad.text.trim();

    if (id.isEmpty || nombre.isEmpty || apellidos.isEmpty || edadStr.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Porfavor completa todos los datos")),
      );
      return;
    }

    final edad = int.tryParse(edadStr);
    if (edad == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Edad no válida")));
      return;
    }

    setState(() {
      trabajadores.add(
        Worker(id: id, nombre: nombre, apellidos: apellidos, edad: edad),
      );
    });

    _idCtrl.clear();
    _name.clear();
    _apellidos.clear();
    _edad.clear();
  }

  void _removeLastWorker() {
    if (trabajadores.isNotEmpty) {
      setState(() {
        trabajadores.removeLast();
      });
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No hay trabajadores")));
    }
  }

  Widget getWorkerList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        const Text(
          "Lista de trabajadores: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...trabajadores.map(
          (w) => Text("- ${w.id} ${w.nombre} ${w.apellidos}, edad: ${w.edad},"),
        ),
      ],
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label,
    TextInputType keyboardType,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),

            _buildTextField(_idCtrl, "ID", TextInputType.text),
            _buildTextField(_name, "Nombre", TextInputType.text),
            _buildTextField(_apellidos, "Apellidos", TextInputType.text),
            _buildTextField(_edad, "Edad", TextInputType.number),

            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addWorker,
              child: const Text("Agregar Trabajador"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _removeLastWorker,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Eliminar Último Trabajador"),
            ),

            getWorkerList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
