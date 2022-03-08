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
      debugShowCheckedModeBanner: false,
      title: 'Consumir API',
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
          return Column(
            children: [
              Container(
                height: 100,
                color: Colors.blue,
                margin: const EdgeInsets.all(5),
                child: const Center(
                  child: Text(
                    'Comentarios',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.vertical,
                  itemCount: listaComentarios.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: 'Nome: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: listaComentarios[index].name + '\n',
                            ),
                            const TextSpan(
                              text: 'E-mail: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: listaComentarios[index].email + '\n',
                            ),
                            const TextSpan(
                              text: 'Comentario: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: listaComentarios[index].body + '\n',
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: 20),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
