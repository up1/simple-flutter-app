import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'beer.dart';

Future<List<Beer>> getBeers() async {
  String url = 'https://api.punkapi.com/v2/beers?per_page=10';
  http.Response response = await http.get(url);

  // Try to convert json to dart object
  List<Beer> allBeers = new List();
  List<dynamic> beers = json.decode(response.body);
  for (var beerJson in beers) {
    var beer = Beer.fromJson(beerJson);
    allBeers.add(beer);
  }
  return allBeers;
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstPage(title: 'My Beers'),
    );
  }
}

class FirstPage extends StatelessWidget {
  final String title;

  FirstPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: FutureBuilder<List<Beer>>(
        future: getBeers(),
        builder: (context, result) {
          if (result.hasError) print(result.error);
          return result.hasData
              ? BeerList(beers: result.data)
              : Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class BeerList extends StatelessWidget {
  final List<Beer> beers;

  BeerList({Key key, this.beers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemCount: beers.length,
      itemBuilder: (context, index) {
        return Image.network(beers[index].imageUrl);
      },
    );
  }
}
