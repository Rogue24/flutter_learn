import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jp_flutter_demo/JPLog.dart';
import 'package:jp_flutter_demo/shared/JPSizeFit.dart';

class JPAnimatedSwitcherExample extends StatelessWidget {
  static String title = "14.AnimatedSwitcher Example";
  
  final GlobalKey<_JPAnimatedSwitcherDemoState> gbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          JPAnimatedSwitcherExample.title,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),

      backgroundColor: JPRandomColor(),

      body: JPAnimatedSwitcherDemo(gbKey),

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

class JPAnimatedSwitcherDemo extends StatefulWidget {
  @override
  _JPAnimatedSwitcherDemoState createState() => _JPAnimatedSwitcherDemoState();

  JPAnimatedSwitcherDemo(Key key) : super(key: key);
}

class _JPAnimatedSwitcherDemoState extends State<JPAnimatedSwitcherDemo> with SingleTickerProviderStateMixin {

  int currentImageIndex = 0;

  List<String> imagePaths = [
    'assets/images/Girl1.jpg',
    'assets/images/Girl2.jpg',
    'assets/images/Girl3.jpg',
    'assets/images/Girl4.jpg',
    'assets/images/Girl5.jpg',
    'assets/images/Girl6.jpg',
    'assets/images/Girl7.jpg',
    'assets/images/Girl8.jpg',
  ];
  
  @override
  Widget build(BuildContext context) {
    // return Carousel(
    //   items: [
    //     Container(color: Colors.red),
    //     Container(color: Colors.green),
    //     Container(color: Colors.blue),
    //   ],
    // );

    // return InfiniteBanner();

    // return InfiniteCarousel(
    //   items: [
    //     "第1页",
    //     "第2页",
    //     "第3页",
    //   ],
    // );

    // return TableExample();

    return Center(
      child: Container(
        width: JPSizeFit.screenWidth - 20,
        height: JPSizeFit.screenHeight * 0.5,
        color: Colors.black,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 500),
          child: Image.asset(
            imagePaths[currentImageIndex],
            key: ValueKey<String>(imagePaths[currentImageIndex]),
          ),
        ),
      ),
    );
  }

  void doSomeThing() {
    setState(() {
      currentImageIndex = (currentImageIndex + 1) % imagePaths.length;
    });
  }
}

// --------------------------- Other Test ---------------------------

class Carousel extends StatefulWidget {
  final List<Widget> items;

  Carousel({required this.items});

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late PageController _controller;
  int currentPage = 0;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      viewportFraction: 0.8,
      initialPage: currentPage,
    );
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_controller.page! >= (widget.items.length - 1)) {
        _controller.jumpToPage(0);
      } else {
        _controller.nextPage(
            duration: Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: PageView.builder(
        controller: _controller,
        itemCount: widget.items.length,
        onPageChanged: (int index) {
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          return widget.items[index];
        },
      ),
    );
  }
}

class InfiniteBanner extends StatefulWidget {
  @override
  _InfiniteBannerState createState() => _InfiniteBannerState();
}

class _InfiniteBannerState extends State<InfiniteBanner> {
  late PageController _controller;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: _currentPage,
    );
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      _controller.animateToPage(++_currentPage % 3,
          duration: Duration(milliseconds: 300), curve: Curves.linear);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          color: index % 2 == 0 ? Colors.red : Colors.green,
          child: Center(
            child: Text(
              'Page $index',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        );
      },
      onPageChanged: (index) {
        setState(() {
          _currentPage = index;
        });
      },
    );
  }
}

class InfiniteCarousel extends StatelessWidget {
  final List<String> items;

  InfiniteCarousel({required this.items});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      itemCount: items.length * 5,
      itemBuilder: (context, index) => Container(
        alignment: Alignment.center,
        child: Text(
          items[index % items.length],
          style: TextStyle(fontSize: 36.0),
        ),
      ),
      controller: PageController(
        viewportFraction: 1.0,
        initialPage: items.length * 5,
      ),
    );
  }
}


class TableExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('Name'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Age'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Gender'),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('John Doe'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('30'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Male'),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Center(
                child: Text('Jane Smith'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('25'),
              ),
            ),
            TableCell(
              child: Center(
                child: Text('Female'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}