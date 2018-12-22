import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

void main() {
  runApp(new MaterialApp(
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() =>
      // TODO: implement createState
      new _State();
}

class _State extends State<MyApp> with TickerProviderStateMixin {
  Animation animation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2000));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeIn);
    animation.addStatusListener(listener);
    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
    print("Animation Disploce");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter APP'),
      ),
      body: new Container(
          padding: new EdgeInsets.all(21.0),
          child: new Center(child: new AnimationLogo(animation: animation))),
    );
  }

  void listener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      animationController.reverse(from: 2.0);
    } else if (status == AnimationStatus.dismissed) {
      animationController.forward();
    }
  }
}

class AnimationLogo extends AnimatedWidget {
  final _size = new Tween<double>(begin: 0.0, end: 300.0);
  final _opacity = new Tween(begin: 0.2, end: 1.0);
  final _rotate = new Tween<double>(begin: 0.0, end: 12.0);

  AnimationLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double> animation = listenable;
    // TODO: implement build
    return new Container(
      child: new Transform.rotate(
        angle: _rotate.evaluate(animation),
        child: new Opacity(
          opacity: _opacity.evaluate(animation),
          child: new Container(
            height: _size.evaluate(animation),
            width: _size.evaluate(animation),
            child: new FlutterLogo(),
          ),
        ),
      ),
    );
  }
}
