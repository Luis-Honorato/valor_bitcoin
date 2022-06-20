import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main(){

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  const Home({ Key? key }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  double _preco = 0;

  void _atualizarPreco() async {

    var url = Uri.parse('https://blockchain.info/ticker');
    http.Response response = await http.get(url);

    Map<String, dynamic> precos = jsonDecode(response.body);

  // o preço é atualizaado a cada 15 minutos!!!
    setState(() {
      _preco = precos['BRL']['buy'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: biuldLayout(),
      ),
    );
  }

  Widget biuldLayout() => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset('assets/images/bitcoin.png',width: 350,),

      Padding(
        padding: const EdgeInsets.all(32),
        child: Text(
          'R\$${_preco.toString()}',
          style: const TextStyle(
            fontSize: 35,
            color: Colors.black,
            decoration: TextDecoration.none
          ),
        ),
      ),

      ElevatedButton(
        onPressed: _atualizarPreco, 
        child: const Text('Atualizar',style: TextStyle(fontSize: 25),),
        style: ElevatedButton.styleFrom(
          primary: Colors.orangeAccent,
          minimumSize: const Size(100, 50)
        )
        )
    ],
  );
}