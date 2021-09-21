import 'package:flutter/material.dart';

class screen extends StatefulWidget {
  const screen({Key? key}) : super(key: key);

  @override
  _AnimatedContainerAppState createState() => _AnimatedContainerAppState();
}

class _AnimatedContainerAppState extends State<screen> {
  get ItemCount => 3;

   int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    var toggle;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(_backIcon(),
          //     color: Colors.black,
          //   ),
          //   alignment: Alignment.centerLeft,
          //   tooltip: 'Back',
          //   onPressed: () {
          //
          //   },
          // ),
          title: Text(
            "Tasks",
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.white,
          actions: <Widget>[
            IconButton(
              tooltip: 'Search',
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
              onPressed: () => toggle,
            ),
            IconButton(
              tooltip: 'Search',
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              onPressed: () => toggle,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: new Container(
                height: 100.0,
                width: 30.0,
                child: new GestureDetector(
                  onTap: () {
                  },
                  child: Stack(
                    children: <Widget>[
                      new IconButton(
                          icon: new Icon(
                            Icons.notification_important,
                            color: Colors.black,
                          ),
                          onPressed: () {
                          }),
                      ItemCount == 0
                          ? new Container()
                          : new Positioned(
                          child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.orange.shade500),
                              new Positioned(
                                  top: 4.0,
                                  right: 5.0,
                                  child: new Center(
                                    child: new Text(
                                      ItemCount.toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 11.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),



          body: Container(
            margin: EdgeInsets.all(10),
            child: new Column(
              children: <Widget>[
                new Card(
                  child: new Column(
                    children: <Widget>[


                       new Row(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Text('Active',style: new TextStyle(fontSize: 18.0,color:Colors.green),),
                          ),
                          new Padding(
                            padding: new EdgeInsets.only(left: 127.0),

                              child: new Text('21 sep 2021,08:00 pm',style: new TextStyle(fontSize: 18.0)),
                          )

                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text('General Electric'
                                ,style: new TextStyle(fontSize: 18.0),),
                          ),
                          new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text('Gaming chair,local pickup only'
                                ,style: new TextStyle(fontSize: 18.0),),
                          )
                        ],
                      ),

                      new Column(
                        children: <Widget>[
                          new Padding(
                            padding: new EdgeInsets.all(10.0),
                            child: new Text('Esther Howerd',style: new TextStyle(fontSize: 18.0),),
                          )
                        ],
                      ),

                      new Padding(
                          padding: new EdgeInsets.all(7.0),
                          child: new Row(
                            children: <Widget>[

                              CircleAvatar(
                                backgroundImage: NetworkImage("https://i.imgur.com/BoN9kdC.png"),
                              ),
                              new Padding(
                                padding: new EdgeInsets.only(left: 180.0),
                                child: new Icon(Icons.thumb_up),
                              ),

                              new Padding(
                                padding: new EdgeInsets.only(left: 20.0),
                                child: new Icon(Icons.comment),
                              ),
                              new Padding(
                                padding: new EdgeInsets.only(left: 20.0),
                                child: new Icon(Icons.share),
                              ),


                            ],
                          )
                      )
                    ],
                  ),
                )

              ],
            ),
          ),



          //Bottm navigation bar
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Business',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'School',
            ),
            // BottomNavigationBarItem(
            //   icon: Icon(Icons.school),
            //   label: 'School',
            // ),
          ],
          currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}