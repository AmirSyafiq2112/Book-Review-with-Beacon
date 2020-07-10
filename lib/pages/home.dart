import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:book_beacon/services/books.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.orangeAccent[200],
      appBar: AppBar(
        title: Text(
            'Welcome to Book Fest',
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'Montserrat',
              //letterSpacing: 2.0,
            ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bookFest.jpg'),
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 80.0, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  RaisedButton.icon(
                    color: Colors.grey[300],
                    padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                    onPressed: () {
                      Navigator.pushNamed(context, '/nearby');
                    },
                    icon: Container(
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                    label: Text(
                      'Do you want to know \nabout nearby book?',
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 15.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 400.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                         Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: RaisedButton(
                            color: Colors.white,
                            onPressed: (){
                              Navigator.pushNamed(context, '/list');
                            },
                            child:Container(
                              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 40.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('assets/book 2.jpg'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                             child: Text(
                              'List of Books',
                              style: TextStyle(
                                fontFamily: 'Grenze',
                                fontSize: 40.0,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
    ) ,
    );
  }
}
