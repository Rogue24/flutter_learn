import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:jp_flutter_demo/model/moguBanner_model.dart';

/* 学自：https://juejin.cn/post/6844903957739864078 */

// -------------------- 公开API --------------------
// 异步请求 本地 JSON
Future<List<MoguBanner>> loadLocalJSON() async {
  // 1.读取本地 json 文件
  String jsonStr = await rootBundle.loadString("assets/json/jpjson.json");

  // 2.解析，转成 List 或 Map 类型
  final jsonResult = json.decode(jsonStr);
  final maps = jsonResult["data"]["banner"]["list"];
  
  // 3.遍历并转成 MoguBanner 对象放到一个 List 中返回
  List<MoguBanner> banners = [];
  for (var map in maps) {
    MoguBanner banner = MoguBanner.fromMap(map);
    banners.add(banner);
  }
  
  return banners;
}

// 异步请求 网络 JSON
Future<List<MoguBanner>> loadNetworkJSON() async {
  // 1.请求 json 数据
  var jsonData = await http.get(Uri.parse("http://123.207.32.32:8000/home/multidata"));
  String jsonStr = jsonData.body;

  // 2.解析，转成 List 或 Map 类型
  final jsonResult = json.decode(jsonStr);
  final maps = jsonResult["data"]["banner"]["list"];
  
  // 3.遍历并转成 MoguBanner 对象放到一个 List 中返回
  List<MoguBanner> banners = [];
  for (var map in maps) {
    MoguBanner banner = MoguBanner.fromMap(map);
    banners.add(banner);
  }
  
  return banners;
}
// -------------------- 公开API --------------------

class JSONDecodeWidgetExample extends StatelessWidget {
  static String title = "JSON Decode";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(JSONDecodeWidgetExample.title, textAlign: TextAlign.center, maxLines: 2,),
      ),

      backgroundColor: Colors.green,

      body: _Content(),
      
    );
  }
}

class _Content extends StatefulWidget {
  @override
  __ContentState createState() => __ContentState();
}

class __ContentState extends State<_Content> {
  String localJsonStr = "loading...";
  String networkJsonStr = "loading...";

  // 在初始化状态的方法中加载数据
  @override
  void initState() {
    super.initState();
    // loadLocalJSON().then((value) => print("local ---- $value"));
    // loadNetworkJSON().then((value) => print("network ---- $value"));
    loadData();
  }

  loadData() {
    Future.delayed(Duration(seconds: 2), () {
      getLocalJSON().then((value) {
        setState(() {
          localJsonStr = value;
        });
      });
    });

    Future.delayed(Duration(seconds: 1), () {
      getNetworkJSON()
      .then((value) {
        print("获取成功");
        setState(() {
          networkJsonStr = value;
        });
      })
      .catchError((error) => print("获取失败 $error"));
    });
  }
  Future<String> getLocalJSON() async {
    String jsonStr = await rootBundle.loadString("assets/json/jpjson.json");
    return jsonStr;
  }
  Future<String> getNetworkJSON() async {
    var jsonData = await http.get(Uri.parse("http://123.207.32.32:8000/home/multidata"));
    String jsonStr = jsonData.body;
    return jsonStr;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: 
          Container(
            color: Colors.yellow,
            child: Center(
              child: Text(
                "$localJsonStr", 
                style: TextStyle(color: Colors.cyan),
                maxLines: 20,
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
        ),
        
        Expanded(child: 
          Container(
            color: Colors.red,
            child: Center(
              child: Text(
                "$networkJsonStr", 
                style: TextStyle(color: Colors.white), 
                maxLines: 20,
                overflow: TextOverflow.ellipsis
              ),
            ),
          ),
        ),
      ],
    );
  }
}