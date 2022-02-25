import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'models/Comentarios.dart';

Future<List<Comentarios>> getHttp() async {
    var response = await Dio().get('https://jsonplaceholder.typicode.com/comments');
    List<dynamic> datab = response.data;
    List<Comentarios> comentarios = datab.map((x) => Comentarios.fromJson(x)).toList();
    return comentarios;
  }

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getHttp(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<Comentarios> listaComentarios = snapshot.data as List<Comentarios>;
          return ListView.separated(
            itemCount: listaComentarios.length,
            itemBuilder: (context, index) {
              return Text(listaComentarios[index].toJson().toString());
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10),
          );
        },
      ),
    );
  }
}
