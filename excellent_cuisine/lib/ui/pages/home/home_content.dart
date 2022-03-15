import 'package:flutter/material.dart';

import 'package:excellent_cuisine/JPLog.dart';
import 'package:excellent_cuisine/core/model/category_model.dart';
import 'package:excellent_cuisine/ui/extension/int_extension.dart';
// import 'package:excellent_cuisine/core/services/json_parse.dart';
import 'package:excellent_cuisine/core/services/category_request.dart';
import 'home_category_item.dart';

class JPHomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // FutureBuilder：未来构建
    return FutureBuilder<List<JPCategoryModel>>(
      // future：根据这个 future 决定 builder 返回什么widget来展示
      // future: JPJsonParse.loadCategoryData(isThrow: false), // 本地加载
      future: JPCategoryRequest.requestCategoryData(), // 网络请求

      // builder：返回一个<<返回值是Widget类型的函数>>
      // AsyncWidgetBuilder<T> = Widget Function(BuildContext context, AsyncSnapshot<T> snapshot);
      // 上面传入的 future 刚执行时调用一次 builder，然后 future 结束（成功或失败）时再调用一次 builder
      builder: (ctx, snapshot) {
        JPrint("FutureBuilder.builder.hasData --- ${snapshot.hasData}");

        // 判断是否获取到数据
        if (!snapshot.hasData) {
          // 当前没有数据，判断是否因为抛出异常
          if (snapshot.hasError) {
            // String errorStr = snapshot.error;
            // return Center(child: Text(errorStr, style: Theme.of(context).textTheme.headline2));

            JPrint(snapshot.error ?? "");
            return Center(child: Text("Get category data failed.", style: Theme.of(context).textTheme.headline2));
          }
          // 不是异常，那就是加载ing，返回菊花
          return Center(child: CircularProgressIndicator());
        }

        // 有数据了
        List<JPCategoryModel> categories = snapshot.data ?? [];
        return GridView.builder(
          padding: EdgeInsets.all(10.px),

          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 交叉轴的 item 个数
            mainAxisSpacing: 10.px, // 主轴的间距
            crossAxisSpacing: 10.px, // 交叉轴的间距
            childAspectRatio: 1.5 // 子 Widget 的宽高比
          ),

          itemCount: categories.length,
          itemBuilder: (ctx, i) => JPHomeCategoryItem(categories[i]),
        );
      },
    );
  }
}