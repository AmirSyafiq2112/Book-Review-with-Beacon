import 'package:flutter/material.dart';
import 'package:book_beacon/services/books.dart';

class Info extends StatefulWidget {
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  Map data = {};

  List<Book> booksInfo = [
    Book(
        name: 'Harry Potter',
        author: 'J.K. Rowling',
        publish: '2009',
        image: 'harry potter.jpg',
        synopsis: 'Harry Potter is a series of fantasy novels written by British author J. K. Rowling. '
                  '\nThe novels chronicle the lives of a young wizard, Harry Potter,'
                  '\nand his friends Hermione Granger and Ron Weasley, all of whom are '
                  '\nstudents at Hogwarts School of Witchcraft and Wizardry.',
        price: 15.0,
    ),
    Book(
        name: 'Takdir 1',
        author: 'Hilal Asyraf',
        publish: '2014',
        image: 'Takdir 1.jpg',
        synopsis: 'Takdir membawa pembaca jauh melangkau zaman. '
                  '\nKala kegelapan menguasai dunia, tika itu dunia telah hancur dek tangan-tangan manusia itu sendiri, '
                  '\nHilal mengajak pembaca kembali menghayati nilai-nilai suci perjuangan di jalan yang bertauhidkan Yang Maha Berkuasa '
                  '\nTakdir, sebuah kisah perjuangan mereka yang percaya kepada-Nya',
        price: 10.0,
    ),
    Book(
      name: 'The Maze Runner',
      author: 'James Dashner',
      publish: '2009',
      image: 'The Maze Runner.jpg',
      synopsis: 'Plot. Thomas wakes up in a metal elevator that brings him to a place called the Glade. '
                '\nHe has no memory of who he is or how he got there. He gradually discovers that the Glade is run by two boys: '
                '\nAlby, the leader, and Newt, the second-in-charge, '
                '\nwho both maintain order by enforcing simple but effective rules.',
      price: 20.0,
    ),
    Book(
      name: 'The Hunger Games',
      author: 'Suzane  Collins',
      publish: '2008',
      image: 'The Hunger Games.jpg',
      synopsis: 'The story is centered on a 16-year-old girl, Katniss Everdeen and her struggle for survival in dystopia. '
                '\nEach year, as a punishment for the failed rebellion by District 13, '
                '\nthe 12 Panem Districts are forced to pay tribute to the ruthless Capitol regime. '
                '\nThe story begins on the day of reaping at District 12.',
      price: 18.0,
    ),
    Book(
      name: 'Empayar',
      author: 'Teme Abdullah',
      publish: '2018',
      image: 'Empayar.jpg',
      synopsis: 'Ilmu agama ini umpama senjata yang boleh dimiliki sesiapa. '
          '\nJika senjata itu jatuh ke tangan yang baik, akan digunakan senjata itu untuk menyerang yang jahat.'
          '\nNamun, jika ia jatuh ke tangan yang jahat, akan digunakan senjata itu untuk memusnahkan yang baik.',
      price: 25.0,
    ),

  ];


  @override
  Widget build(BuildContext context) {

    int get(){

      String receive = data['name'];
      int counter = booksInfo.length;

      for(int i = 0 ; i <= counter ; i++ ){
        if( receive == booksInfo[i].name)
          return i;
      }
    }

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange,
        title: Text(
            booksInfo[get()].name,
          style: TextStyle(
            color: Colors.grey[200],
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  color: Colors.white,
                  child: Image.asset('assets/${booksInfo[get()].image}',),
                ),
              ),
            ),
            Container(
              child: Text(
                  'author:  ${booksInfo[get()].author}',
                  style: TextStyle(
                    fontFamily: 'Grenze',
                    fontSize: 20.0,
                  ),
              ),
            ),
            SizedBox(height: 20.0),
            Container(
                child: Text(
                  '${booksInfo[get()].synopsis}',
                ),
              ),
            SizedBox(height: 20.0),
            Container(
              child: Text(
                'RM${booksInfo[get()].price}0',
                style: TextStyle(
                  fontFamily: 'JosefinSemiBold',
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
