import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

class JPStreamBuilderExample extends StatelessWidget {
  static String title = "15.StreamBuilder Example";
  
  final GlobalKey<_JPStreamBuilderDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPStreamBuilderExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: Colors.white,

      body: JPStreamBuilderDemo(gbKey),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.ac_unit),
        onPressed: () {
          var state = gbKey.currentState;
          state?.doSomeThing();
        },
      ),
    );
  }
}

class JPStreamBuilderDemo extends StatefulWidget {
  @override
  _JPStreamBuilderDemoState createState() => _JPStreamBuilderDemoState();
  JPStreamBuilderDemo(Key key) : super(key: key);
}

class _JPStreamBuilderDemoState extends State<JPStreamBuilderDemo> {
  final apiKey = "Your OpenAI API Key";
  final apiURL = "https://api.openai.com/v1/chat/completions";
  final apiModel = "gpt-3.5-turbo";

  StreamController<String> _streamController = StreamController<String>();

  String myProblem = "请帮我用Dart写一个快速排序算法";
  bool isAsking = false;

  @override
  void initState() {
    super.initState();
    _streamController.add("点击右下角按钮开始发问：$myProblem");
  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: StreamBuilder(
            stream: _streamController.stream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (snapshot.hasError) return Text("发生错误: ${snapshot.error}");
              if (snapshot.hasData) {
                String content = snapshot.data ?? "";
                if (content.length > 0) {
                  return Text(content);
                }
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }

  void doSomeThing() async {
    if (isAsking) return;
    isAsking = true;

    _streamController.add("");

    askGPT(myProblem);
    // reqGPT(myProblem);
  }

  /// 流式请求
  void askGPT(String problem) {
    final messages = [
      {
        "role": "user",
        "content": problem,
      },
    ];

    final requestBody = {
      "model": apiModel,
      "messages": messages,
      "temperature": 0.5,
      "stream": true
    };
    
    var request = http.Request("POST", Uri.parse(apiURL));
    request.headers["Authorization"] = "Bearer $apiKey";
    request.headers["Content-Type"] = "application/json; charset=UTF-8";
    request.body = jsonEncode(requestBody);

    JPrint("开始请求");
    http.Client().send(request).then((response) {
      String showContent = "";
      final stream = response.stream.transform(utf8.decoder);
      stream.listen((data) {
          final dataLines = data.split("\n").where((element) => element.isNotEmpty).toList();
          // JPrint("dataLines ${dataLines.length}");
          for (String line in dataLines) {
            if (!line.startsWith("data: ")) continue;
            final data = line.substring(6);

            // JPrint("data $data");
            if (data == "[DONE]") break;

            Map<String, dynamic> responseData = json.decode(data);
            // JPrint("responseData $responseData");
            List<dynamic> choices = responseData["choices"];
            Map<String, dynamic> choice = choices[0];
            Map<String, dynamic> delta = choice["delta"];
            String content = delta["content"] ?? "";

            showContent += content;
            _streamController.add(showContent);

            String finishReason = choice["finish_reason"] ?? "";
            if (finishReason.length > 0) {
              JPrint("finish_reason：$finishReason");
              break;
            }
          }
        }, 
        onDone: () {
          _streamController.add(showContent);
          isAsking = false;
        },  
        onError: (error) {
          _streamController.addError(error);
          isAsking = false;
        },
      );
    });
  }

  /// 一次性请求
  Future<void> reqGPT(String problem) async {
    final headers = {
      "Authorization": "Bearer $apiKey",
      "Content-Type": "application/json; charset=UTF-8",
    };

    final messages = [
      {
        "role": "user",
        "content": problem,
      },
    ];

    final requestBody = {
      "model": apiModel,
      "messages": messages,
    };

    JPrint("开始请求");
    final response = await http.post(
      Uri.parse(apiURL),
      headers: headers,
      body: jsonEncode(requestBody),
    );
    
    Map<String, dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
    
    if (response.statusCode == 200) {
      JPrint("请求成功");
      List<dynamic> choices = responseData["choices"];
      Map<String, dynamic> choice = choices[0];
      Map<String, dynamic> message = choice["message"];
      String content = message["content"];
      // 将数据添加到流中
      _streamController.add(content);
    } else {
      _streamController.addError("请求失败");
    }

    isAsking = false;
  }
}