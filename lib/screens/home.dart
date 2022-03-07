import 'package:bookmyshowcloneapp/models/movies.dart';
import 'package:bookmyshowcloneapp/repo/movie_operations.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class home extends StatelessWidget {
  
  late List<Movies> movieList;

  home(){
    MovieOperations movieOprerations = MovieOperations.getMovieOperationInstance();
    movieList = movieOprerations.getMovies();
  }


  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      drawer: Drawer(),
      appBar: _getAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getTopBar(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: 
              _getMovieContainer(deviceSize)
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _getBottomNavigationBar()
    );
  }

  _getStyle({double size = 15,FontWeight fontWeight = FontWeight.w500,Color color = Colors.black }){
    return TextStyle(fontSize: size,fontWeight: fontWeight,color: color);
  }

  List<Widget> _getMovieContainer(deviceSize){
    
    List<Widget> list = movieList.map((movie){
      return Stack(
        children: [
          Card(
            child: SizedBox(
              height: 250,
              child: Column(
                children: [
                  Image.asset(movie.imageURL,height:180,fit: BoxFit.cover,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children : [
                            Text(movie.name,style : _getStyle(color:Colors.black,size: 20,fontWeight: FontWeight.w500)),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Text(movie.language,style : _getStyle(fontWeight: FontWeight.w400)),
                              SizedBox(width: 5,),
                              Container(
                                width: 30,height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  border: Border.all(
                                    color: Colors.grey,
                                    width: 1
                                  )
                                ),
                                child: Center(child: Text(movie.type,style:_getStyle(fontWeight: FontWeight.w600))),)
                            ],)
                          ]
                        ),
                        Container(
                          width: 100,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.red.shade600,
                            borderRadius: BorderRadius.circular(8)
                          ),
                          child: Center(child: Text('Book'.toUpperCase(),style: GoogleFonts.lato(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold,letterSpacing: 1),
                          )
                        )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
          Positioned(
            top: 4,
            left: 4,
            child: Container(
              color: Colors.green.shade500,
              width: 60,
              height: 25,
              child: Center(
                child: Text('New',style: _getStyle(color: Colors.white),),
              ),
            ),
          ),
          Positioned(
            width: deviceSize.width-30,
            bottom: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                width:80,
                height:40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black54,
                  border: Border.all(
                    color: Colors.white,
                    width: 2
                  )
                ),
                child: Center(child: Text(movie.certificateType,style: _getStyle(color: Colors.white,size: 22),)),
              ),
              Container(
                width: 110,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(5)
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.favorite_outlined,color: Colors.pink.shade300,),
                          SizedBox(width: 5,),
                          Text(movie.likesPercent.toString()+"%",style: _getStyle(color: Colors.white,fontWeight: FontWeight.bold,size: 20),
                        )],
                      ),
                      Text(movie.votes.toString()+' votes',style: _getStyle(color: Colors.white,fontWeight: FontWeight.bold,size: 18))
                    ],
                  ))
                ),
            ]
            )
          ),
        ],
      );
    }).toList();
    return list;
  }
  
  // App bar container  
  _getAppContainer({required Color color,required String text,double width = 130,double height = 50,required BorderRadius br}){
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: br,
      ),
      child: Center(
        child: Text(text,style: GoogleFonts.lato(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700),
      )),
    );
  }

  // border radius for App bar container
  _getBorderRadius({required double topleft,required double topright,required double bottomleft,required double bottomright}){
    return BorderRadius.only(
      topLeft: Radius.circular(topleft),
      topRight: Radius.circular(topright),
      bottomLeft: Radius.circular(bottomleft),
      bottomRight:Radius.circular(bottomright),
    );
  }

  // custom Bottom bar
  _getBottomBarItem({required Icon icon,required String text}){
    return BottomNavigationBarItem(
      icon: icon,
      label: text
    );
  }

  // App bar 
  _getAppBar(){
    return PreferredSize(
        preferredSize: Size.fromHeight(65.0),
        child: AppBar(
          actions: [Padding(padding:EdgeInsets.only(right: 15,),child:Icon(Icons.location_on_sharp,size: 25,))],
          backgroundColor: Colors.blueGrey.shade800,
          title: Padding(
            padding: EdgeInsets.only(top: 10),
            child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _getAppContainer(color:Colors.pinkAccent,text: "now showing".toUpperCase(),br: _getBorderRadius(topleft: 8, topright: 5, bottomleft: 8, bottomright: 5)),
                    _getAppContainer(color:Colors.grey.shade700,text : "coming soon".toUpperCase(),br: _getBorderRadius(topleft: 0, topright: 8, bottomleft: 0, bottomright: 8)),
                  ],
                ),
            ),
          )
        ),
      );
  }

  // Bottom Navigation Bar
  _getBottomNavigationBar(){
    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        iconSize: 25,
        items: [
          _getBottomBarItem(icon: Icon(Icons.home_outlined), text: 'Home'),
          _getBottomBarItem(icon: Icon(Icons.search), text: 'Search'),
          _getBottomBarItem(icon: Icon(Icons.favorite_border_outlined), text: 'Just For You'),
          _getBottomBarItem(icon: Icon(Icons.person_outline), text: 'My Profile')
        ],
      );
  }

  // top bar navigation options 
  _createNavOption(Icon icon,String text){
    return Row(
      children: [
        icon,
        SizedBox(width: 10,),
        Text(text,style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black87)),
      ],
    );
  }

  // top bar : All Languages and cinemas section
  _getTopBar(){
    return Container(
      color: Colors.white,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Container(
          height: 25,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              _createNavOption(Icon(Icons.language_outlined,color: Colors.blue,size: 28,), 'All Languages'),
              VerticalDivider(
                color: Colors.grey.shade300,
                thickness: 2,
              ),
              _createNavOption(Icon(Icons.chair,color: Colors.red,size: 28,), 'Cinemas'),
            ]
          ),
        ),
      ),
    );
  }

}