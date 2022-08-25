import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(homepage());
}
class random_words extends StatefulWidget {


  @override
  State<random_words> createState() => _random_wordsState();
}

class _random_wordsState extends State<random_words> with SingleTickerProviderStateMixin {
  final _suggestions = <WordPair>[];
  final _saved = <WordPair>{};
  final _biggerfornts = TextStyle(fontSize: 18);
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Name generator"),
        actions: [
          IconButton(
            tooltip: "saved name",
              onPressed: _pushsaved,
              icon: Icon(Icons.list))
        ],
      ),




      body : ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) return Divider();
        _suggestions.addAll(generateWordPairs().take(10));
        final _alreadysaved = _saved.contains(_suggestions[i]);


        return ListTile(
          title: Padding(
            padding: EdgeInsets.only(top: 10,bottom: 10),
            child: Text(
              _suggestions[i].asPascalCase,
              style: _biggerfornts ,
            ),

          ),
          trailing: Icon(
            _alreadysaved ? Icons.favorite : Icons.favorite_border,
            color: _alreadysaved ? Colors.red : Colors.black,
            semanticLabel: _alreadysaved ? "remove from favourite" : "saved",
          ),
          onTap: (){
            setState((){
              if(_alreadysaved){
                _saved.remove(_suggestions[i]);
              }
              else{
                _saved.add(_suggestions[i]);
              }
            });
          },
        );
      },
    ));
  }

  void _pushsaved() {
    Navigator.of(context).push(
      // Add lines from here...
      MaterialPageRoute<void>(
        builder: (context) {
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerfornts,
                ),
              );
            },
          );
          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: const Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ), // ...to here.
    );

  }
}

class homepage extends StatelessWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
     title: "Name generator",
      home: random_words(),
    );
  }
}
