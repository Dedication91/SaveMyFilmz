
import Foundation
import CoreData


extension Film {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Film> {
        return NSFetchRequest<Film>(entityName: "Film")
    }

    @NSManaged public var averageVote: Double
    @NSManaged public var filmCover: String?
    @NSManaged public var filmReleaseDate: String?
    @NSManaged public var filmSummary: String?
    @NSManaged public var filmTitle: String?
    @NSManaged public var savedBookmark: Bool

}
