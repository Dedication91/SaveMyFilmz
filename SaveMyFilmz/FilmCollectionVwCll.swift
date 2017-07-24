

import UIKit
import CoreData

class FilmCollectionVwCll: UICollectionViewCell {

    @IBOutlet weak var filmTitleLbl: UILabel!
    @IBOutlet weak var rlsDateLbl: UILabel!
    @IBOutlet weak var filmCoverImgVw: UIImageView!
    @IBOutlet weak var averageVoteLbl: UILabel!
    @IBOutlet weak var filmSummaryLbl: UILabel!
    @IBOutlet weak var bookmarkBtn: UIButton!
    
    
    let managedContext = (UIApplication.shared.delegate as? AppDelegate)!.persistentContainer.viewContext
    
    var posterUrl:URL?
    var film:Model!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    
    func doesBookmarkExist(filmTitle: String) -> Bool {
        
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Film")
        fetchRequest.predicate = NSPredicate(format: "filmTitle == %@", filmTitle)
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            if (results.count) > 0 {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
            return false
        }
        
     }
    
    func deleteBookmark(filmTitle:String) {
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Film")
        fetchRequest.predicate = NSPredicate(format: "filmTitle == %@", filmTitle)
        
        do {
            let results = try managedContext.fetch(fetchRequest) as! [Film]
            if (results.count) > 0 {
                for  film in results {
                    managedContext.delete(film)
                }
                do {
                    try managedContext.save()
                } catch let error {
                    print(error)
                }
                
            }
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
            
        }
        
    }
    


    
    var bookmarkBtnPrssd = true
    
    
    @IBAction func bookmarkBtnPrssd(_ sender: Any) {
    
        if !bookmarkBtnPrssd {
            let image = UIImage(named: "bookmarkOff") as UIImage!
            
            bookmarkBtn.setImage(image, for: .normal)
            bookmarkBtnPrssd = true
            
            deleteBookmark(filmTitle: self.film.filmTitle)
            
            return
        } else {
            
            let image = UIImage(named: "bookmarkOn") as UIImage!
            bookmarkBtn.setImage(image, for: .normal)
            bookmarkBtnPrssd = false
            
            
        }
        
        // Check if film is already bookmarked
        if doesBookmarkExist(filmTitle: self.film.filmTitle) {
            //file 
            // false
            self.film.savedBookmark = true
            //self.film.setValue(false, forKey: "savedBookmark")
            return
        }
        
       
        //let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Film", in: managedContext)
        let filmSummary = NSManagedObject(entity: entity!, insertInto: managedContext)
        filmSummary.setValue(self.film.filmTitle, forKey: "filmTitle")
        filmSummary.setValue(self.film.filmRlsDate, forKey: "filmReleaseDate")
        filmSummary.setValue(self.film.filmCover, forKey: "filmCover")
        filmSummary.setValue(self.film.averageVote, forKey: "averageVote")
        filmSummary.setValue(self.film.filmSummary, forKey: "filmSummary")
        filmSummary.setValue(true, forKey: "savedBookmark")
        do {
            try managedContext.save()
        } catch let error {
            print(error)
        }
    }
}
