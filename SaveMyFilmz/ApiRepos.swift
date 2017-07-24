

import Foundation
import Alamofire

class ApiRepos: NSObject {
    static var featuredFilmLink = FilmLinks.faturedFlim.rawValue
    static var upratedFilmLink = FilmLinks.upratedFilm.rawValue
    static var loomingReleaseFilmLink = FilmLinks.loomingReleaseFilm.rawValue
}

enum FilmLinks: String {
    case faturedFlim = "http://api.themoviedb.org/3/movie/popular"
    case upratedFilm = "http://api.themoviedb.org/3/movie/top_rated"
    case loomingReleaseFilm = "http://api.themoviedb.org/3/movie/upcoming"
}
