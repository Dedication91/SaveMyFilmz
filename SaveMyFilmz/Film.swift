
import Foundation
import SwiftyJSON



class Model {
    var filmTitle:String!
    var filmRlsDate:String!
    var filmCover:String!
    var averageVote:Double!
    var filmSummary:String!
    var savedBookmark: Bool!
    // bookmark
    
    func load(JSON:JSON){
        self.filmTitle = JSON["original_title"].string!
        self.filmRlsDate = JSON["release_date"].string!
        self.filmCover = JSON["poster_path"].string!
        self.averageVote = JSON["vote_average"].double!
        self.filmSummary = JSON["overview"].string!
        
    }

}
