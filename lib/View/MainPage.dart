import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobitoon/Model/Component/MovieItem.dart';
import 'package:mobitoon/View/MainScreen.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget
{
  double w, h;
  List<MovieItem> movies = [];

  MainPage()
  {
    movies.add(new MovieItem(
      movieName: "Tom and Jerry, 33 Episode - The Invisible Mouse (1947)",
      movieUrl: "https://res.cloudinary.com/init-sol/video/upload/v1619343789/samples/Tom_and_Jerry_33_Episode_-_The_Invisible_Mouse_1947_vjfrai.mp4",
      posterUrl: "https://s3.amazonaws.com/intanibase/iad_screenshots/1947/3474/2.jpg",
      desc: "The short three-minute fragment from series is a 1947 American one-reel animated cartoon and is the 33rd Tom and Jerry short directed by William Hanna and Joseph Barbera and produced by Fred Quimby. The episode is a parody of The Invisible Man written by H. G. Wells."
    ));
    movies.add(new MovieItem(
        movieName: "Elephants (Documentary)",
        movieUrl: "https://res.cloudinary.com/init-sol/video/upload/v1609841125/samples/elephants.mp4",
        posterUrl: "https://i.natgeofe.com/k/e7ba8001-23ac-457f-aedb-abd5f2fdda62/moms5.png",
        desc: "African elephants are the largest land animals on Earth. They are slightly larger than their Asian cousins and can be identified by their larger ears that look somewhat like the continent of Africa. (Asian elephants have smaller, rounded ears.)"
    ));
    movies.add(new MovieItem(
        movieName: "Sea Turtle (Documentary)",
        movieUrl: "https://res.cloudinary.com/init-sol/video/upload/v1609841123/samples/sea-turtle.mp4",
        posterUrl: "https://i.pinimg.com/originals/74/38/53/74385390f3311f28f6e96546ef40b52c.jpg",
        desc: "The leatherback is the largest sea turtle and can weigh a whopping 2,000 pounds. It's also the only sea turtle that doesn't have a hard, bony shell. Its carapace is somewhat flexible and almost rubbery to the touch. The shells of other sea turtles are made of thick plates called scutes."
    ));
  }

  @override
  Widget build(BuildContext context)
  {
    w = MediaQuery.of(context).size.width / 50;
    h = MediaQuery.of(context).size.height / 50;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("MobiToon", style: TextStyle(fontSize: h*1.4, color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: movies.length,
        itemBuilder: (context, idx) {
          return Card(
            elevation: 4,
            child: Container(
              width: w*48,
              padding: EdgeInsets.all(w*1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Image.network(this.movies[idx].posterUrl),

                  SizedBox(height: h*0.5),

                  Text(this.movies[idx].movieName, style: TextStyle(fontSize: h*1.4, color: Colors.black, fontWeight: FontWeight.bold)),

                  SizedBox(height: h*1),

                  SizedBox(
                    width: w*48,
                    child: Text(this.movies[idx].desc, style: TextStyle(fontSize: h*1.1, color: Colors.black))
                  ),

                  SizedBox(height: h*1),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: InkWell(
                      onTap: (){

                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) => MainScreen(movieUrl: this.movies[idx].movieUrl)
                        ));

                      },
                      child: SizedBox(
                        width: w*7,
                        height: w*7,
                        child: CircleAvatar(
                          backgroundColor: Colors.green[500],
                          child: Icon(Icons.play_arrow, color: Colors.white, size: w*4),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        }
      ),
    );
  }

}
