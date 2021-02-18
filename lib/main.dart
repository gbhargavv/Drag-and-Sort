import 'package:drag_and_sort/drag_sort_view.dart';
import 'package:drag_and_sort/models.dart';
import 'package:drag_and_sort/utils.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Drag and Sort View',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ImageBean> imageList = List();
  int moveAction = MotionEvent.actionUp;
  bool _canDelete = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }

  void _init() {
    imageList = getImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Sort View'),
        actions: [
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.refresh),
            onPressed: () {
              _init();
              setState(() {});
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          DragSortView(
            imageList,
            space: 5,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext context, int index) {
              ImageBean bean = imageList[index];
              return Utils.getWidget(bean.thumbPath);
            },
            initBuilder: (BuildContext context) {
              return InkWell(
                onTap: () {
                  // _loadAssets(context);
                },
                child: Container(
                  color: Color(0XFFCCCCCC),
                  child: Center(
                    child: Icon(
                      Icons.add,
                    ),
                  ),
                ),
              );
            },
            onDragListener: (MotionEvent event, double itemWidth) {
              switch (event.action) {
                case MotionEvent.actionDown:
                  moveAction = event.action;
                  setState(() {});
                  break;
                case MotionEvent.actionMove:
                  double x = event.globalX + itemWidth;
                  double y = event.globalY + itemWidth;
                  double maxX = MediaQuery.of(context).size.width - 1 * 100;
                  double maxY = MediaQuery.of(context).size.height - 1 * 100;
                  print('Sky24n maxX: $maxX, maxY: $maxY, x: $x, y: $y');
                  if (_canDelete && (x < maxX || y < maxY)) {
                    setState(() {
                      _canDelete = false;
                    });
                  } else if (!_canDelete && x > maxX && y > maxY) {
                    setState(() {
                      _canDelete = true;
                    });
                  }
                  break;
                case MotionEvent.actionUp:
                  moveAction = event.action;
                  if (_canDelete) {
                    setState(() {
                      _canDelete = false;
                    });
                    return true;
                  } else {
                    setState(() {});
                  }
                  break;
              }
              return false;
            },
          ),
        ],
      ),
      floatingActionButton: moveAction == MotionEvent.actionUp
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: Icon(_canDelete ? Icons.delete : Icons.delete_outline),
            ),
    );
  }

  static List<ImageBean> getImages() {
    List<String> urlList = [
      '1',
      '2',
      '3',
      '4',
      '5',
      '6',
      '7',
      '8',
      '9',
    ];
    List<ImageBean> list = List();
    for (int i = 0; i < urlList.length; i++) {
      String url = urlList[i];
      list.add(ImageBean(
        originPath: url,
        middlePath: url,
        thumbPath: url,
        originalWidth: 250,
        originalHeight: 250,
      ));
    }
    return list;
  }
}
