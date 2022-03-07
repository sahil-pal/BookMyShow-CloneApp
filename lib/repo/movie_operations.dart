import '../models/movies.dart';

class MovieOperations{

  static MovieOperations movieOperations = MovieOperations();

  _MoviesOperations(){}
  
  static MovieOperations getMovieOperationInstance(){
    return movieOperations;
  }

  List<Movies> getMovies(){
    return <Movies>[
      Movies(name: 'Hindi Medium', language: 'Hindi', type: '2D', certificateType: 'U', imageURL: 'images/hindimedium-poster.jpeg', likesPercent: 87, votes: 7809),
      Movies(name: 'Kashmiri Files',language: 'Hindi',type: '2D',certificateType: 'U', imageURL: 'images/kashmirifiles-poster.jpeg', likesPercent: 90, votes: 54211),
      Movies(name: 'Avatar', language: 'English', type: '3D', certificateType: 'UA', imageURL: 'images/avatar-poster.jpeg', likesPercent: 95, votes: 19322),
    ];
  }
}