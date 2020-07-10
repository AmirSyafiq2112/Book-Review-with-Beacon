import 'package:flutter/material.dart';
import 'package:book_beacon/services/books.dart';

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {


  List<Book> booksList = [
    Book(name: 'Harry Potter', image: 'harry potter.jpg'),
    Book(name: 'Takdir 1', image: 'Takdir 1.jpg'),
    Book(name: 'The Maze Runner', image: 'The Maze Runner.jpg'),
    Book(name: 'The Hunger Games', image: 'The Hunger Games.jpg'),
    Book(name: 'Empayar', image: 'Empayar.jpg'),
    Book(name: 'Kacau', image: 'Kacau.png'),
    Book(name: 'Mutiara Jasa Ayah', image: 'Mutiara Jasa Ayah.jpg'),
    Book(name: 'Everything id Fucked', image: 'Everything is Fucked.jpg'),
    Book(name: 'Unshakeable', image: 'Unshakeable.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[300],
        centerTitle: true,
        title: Text(
          'List of Books',
            style: TextStyle(
              fontFamily: 'Roboto',
            fontSize: 20.0,
            color: Colors.orange,
            fontWeight: FontWeight.bold,
        ),
        ),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: booksList.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                child: SizedBox(
                  height: 90.0,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            booksList[index].name,
                            style: TextStyle(
                              fontFamily: 'Bangers',
                              fontSize: 25.0,
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundImage: AssetImage('assets/${booksList[index].image}'),
                            radius: 30.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
        ),
      ),
    );
  }
}
