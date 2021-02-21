import 'dart:async';

import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://flutterchina.club/get-started/codelab/ */

class RandomWords extends StatefulWidget {
  static const String routeName = "/random_words";
  
  static String title = "Startup Name Generator";

  @override
  createState() => RandomWordsState();
}
class RandomWordsState extends State<RandomWords> {
  final _biggerFont = const TextStyle(fontSize: 18.0);

  final _suggestions = <WordPair>[];

  final _saved = Set<WordPair>();

  @override
  void initState() {
    super.initState();
    
    // 不能在 initState 获取路由参数，会报错。
    // var settings = ModalRoute.of(context).settings;
    // if (settings.name != null) JPrint("initState settings.name --- ${settings.name}");
    // if (settings.arguments != null) JPrint("initState settings.arguments --- ${settings.arguments}");

    // Flutter 不能在 initState 中调用 BuildContext.dependOnInheritedWidgetOfExactType 方法
    // ModalRoute.of(context) 内部就是调用 context 的 dependOnInheritedWidgetOfExactType 方法
    // 应该是此时的 context 还没准备好，查找不到祖先的 InheritedWidget（_ModalScopeStatus），所以报错了。

    // 可以通过 Timer.run，把【要执行的代码块】放入到<<事件队列>>的后面
    // 此时放入的将会在 build 之后才会执行（build方法本来已经放入到事件队列的了），到那时候 context 是已经准备好了
    Timer.run(() {
      var settings = ModalRoute.of(context).settings;
      if (settings.name != null) JPrint("Timer.run --- settings.name --- ${settings.name}");
      if (settings.arguments != null) JPrint("Timer.run --- settings.arguments --- ${settings.arguments}");
    });
  }

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var settings = ModalRoute.of(context).settings;
    if (settings.name != null) JPrint("settings.name --- ${settings.name}");
    if (settings.arguments != null) JPrint("settings.arguments --- ${settings.arguments}");

    // final wordPair = WordPair.random();
    // return Text(wordPair.asPascalCase);
    return Scaffold(
      appBar: AppBar(
        title: Text(RandomWords.title),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _saved.map(
            (pair) {
              return ListTile(
                title: Text(
                  pair.asPascalCase,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();
          return Scaffold(
            appBar: AppBar(
              title: Text('Saved Suggestions'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildSuggestions() {
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        // 对于每个建议的单词对都会调用一次itemBuilder，然后将单词对添加到ListTile行中
        // 在偶数行，该函数会为单词对添加一个ListTile row.
        // 在奇数行，该函数会添加一个分割线widget，来分隔相邻的词对。
        // 注意，在小屏幕上，分割线看起来可能比较吃力。
        itemBuilder: (context, i) {
          // 在每一列之前，添加一个1像素高的分隔线widget
          if (i.isOdd) return Divider();

          // 语法 "i ~/ 2" 表示i除以2，但返回值是整形（向下取整），比如i为：1, 2, 3, 4, 5
          // 时，结果为0, 1, 1, 2, 2， 这可以计算出ListView中减去分隔线后的实际单词对数量
          final index = i ~/ 2;
          // 如果是建议列表中最后一个单词对
          if (index >= _suggestions.length) {
            // ...接着再生成10个单词对，然后添加到建议列表
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);

    return ListTile(
      title: Text(
        pair.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }
}
