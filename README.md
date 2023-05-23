# Flutter Learn

- Flutter Demo
- Flutter Project
- Flutter Module by flutter_boost

## 对flutter_boost的二次封装
#### iOS (Swift)

- 路由（协议+枚举）

```swift
Flutter.Route.center_aleat(["title": "你好"]).jump()
```

- 事件监听/发送（协议+枚举）

```swift
// 监听
Flutter.Event.sendFrom_flutter().addListener { (name, arguments) in
    guard let obName = name, let obArguments = arguments else { return }
    print("接收到 Flutter 消息：\(obName) --- \(obArguments)")
}

// 发送
Flutter.Event.sendFrom_native(["message": "this is message from iOS"]).send()
```

- Flutter端调用原生方法

```swift
// 建立渠道
buildChannel("screen_info", screenInfoHandler, engine)

// 给Flutter调用的映射方法
static func screenInfoHandler(_ call: FlutterMethodCall, _ result: @escaping FlutterResult) {
    switch call.method {
    case "getScreenInfo":
        result(["screen_scale": UIScreen.mainScale,
                "screen_width": UIScreen.mainWidth,
                "screen_height": UIScreen.mainHeight])
    default:
        // FlutterMethodNotImplemented：目标方法没有实现
        result(FlutterMethodNotImplemented)
    }
}
```

#### Flutter

封装ing...

## Contact

	QQ: 184669029
	E-mail: zhoujianping24@hotmail.com

## Visitors

[![HitCount](http://hits.dwyl.com/Rogue24/Rogue24.svg)](http://hits.dwyl.com/Rogue24/Rogue24)
