import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';

/* 学自：https://juejin.cn/post/6844903949271564302 */

class ProductList extends StatelessWidget {
  static const String routeName = "/product_list";

  static String title = "Product List";

  @override
  Widget build(BuildContext context) {
    // 获取路由参数
    var settings = ModalRoute.of(context).settings;
    if (settings.name != null) JPrint("settings.name --- ${settings.name}");
    if (settings.arguments != null) JPrint("settings.arguments --- ${settings.arguments}");

    return Scaffold(
      appBar: AppBar(
        title: Text(ProductList.title),
      ),
      body: _HomeContent(),
    );
  }
}

class _HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ListView(
        children: [
          ProductItem("Apple1", "Macbook Product1",
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g72j6nk1d4j30u00k0n0j.jpg"),
          ProductItem("Apple2", "Macbook Product2",
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imm9u5zj30u00k0adf.jpg"),
          ProductItem("Apple3", "Macbook Product3",
              "https://tva1.sinaimg.cn/large/006y8mN6gy1g72imqlouhj30u00k00v0.jpg")
        ],
      ),
    );
  }
}

class ProductItem extends StatelessWidget {
  final String title;
  final String desc;
  final String imageURL;

  ProductItem(this.title, this.desc, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
      // 边距
      padding: const EdgeInsets.all(20),
      // 边框线
      decoration: BoxDecoration(border: Border.all()),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 24),
          ),
          Text(
            desc,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ), // 设置文字和图片之间的间距
          Image.network(imageURL)
        ],
      ),
    );
  }
}
