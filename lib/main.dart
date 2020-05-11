import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NavigationRail Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'NavigationRail Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   int _index = 0;/*PageView   NavigationRail 公用一个索引 这样可以相互改变彼此的选中状态 */
   Color _color = Colors.amber;
   PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Row(
        children: <Widget>[
          Container(
            color: _color,
            width: screenWidth*0.8,
            child: PageView(
              scrollDirection:Axis.vertical,
                controller:_pageController,
                onPageChanged:(index){
                  setState(() {
                    _index = index;
                  });
                },
              children: <Widget>[
                   Center(child: Text('第1页',style: TextStyle(color: Colors.white))),
                   Center(child: Text('第2页',style: TextStyle(color: Colors.white))),
                   Center(child: Text('第3页',style: TextStyle(color: Colors.white))),
            ],),
          ),
          NavigationRail(
            minWidth: screenWidth*0.2,
            labelType: NavigationRailLabelType.selected,
            destinations: [
              NavigationRailDestination(icon: Icon(Icons.ac_unit),selectedIcon: Icon(Icons.ac_unit,color: Colors.amber),label: Text('选项1')),
              NavigationRailDestination(icon: Icon(Icons.access_alarm),selectedIcon: Icon(Icons.access_alarm,color: Colors.blue),label: Text('选项2')),
              NavigationRailDestination(icon: Icon(Icons.favorite),selectedIcon: Icon(Icons.favorite,color: Colors.red),label: Text('选项3')),
            ], selectedIndex: _index,
            onDestinationSelected:(index){
              setState(() {
                _index = index;
                if(_index == 0){
                  _color = Colors.blueAccent;
                  _pageController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                }else if(_index == 1){
                  _color = Colors.purpleAccent;
                  _pageController.animateToPage(1, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                }else if(_index == 2){
                  _color = Colors.red;
                  _pageController.animateToPage(2, duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
                }
              });
            },
            backgroundColor: Colors.blueGrey,
            selectedIconTheme: IconThemeData(color: Colors.yellow),
            selectedLabelTextStyle: TextStyle(color: Colors.yellow),
          )
        ],
      )
    );
  }
}
