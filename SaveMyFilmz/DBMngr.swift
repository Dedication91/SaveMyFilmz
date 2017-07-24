

import Foundation
import CoreData

class DBMngr {
    
     static let disributedInstance = DBMngr()
    
    let container:NSPersistentContainer!
    
    init() {
        container = NSPersistentContainer(name: "SaveMyFilms")
    }
    
    class func Distribute() -> DBMngr {
        return disributedInstance
    }
}
