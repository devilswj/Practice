import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main()=> runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'welcome to flutter',
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget{
  @override
  createState() => RandomWordsState();
}
class RandomWordsState extends State<RandomWords>{
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = TextStyle(fontSize: 18.0);
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: _buildSuggestions(),
    );
  }
  Widget _buildSuggestions(){
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context,i){
        if(i.isOdd) return Divider();
        final index = i~/2;
        if(index>=_suggestions.length){
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }
  Widget _buildRow(WordPair pair){
    final aleradySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing:  Icon(
        aleradySaved?Icons.favorite:Icons.favorite_border,
        color: aleradySaved?Colors.red:null,
      ),
      onTap: (){
        setState(() {
          if(aleradySaved){
            _saved.remove(pair);
          }else{
            _saved.add(pair);
          }
        });
      },
    );
  }
}