

import UIKit
import CoreData
import SwiftyJSON
import Kingfisher
class BookmarkVC: UIViewController {
 
    
    
    @IBOutlet weak var nmeLbll: UILabel!
    
    @IBOutlet weak var savedbmarkedFilmCV: UICollectionView!
    
    @IBOutlet weak var enterNme: UITextField!
    var filmss: [NSManagedObject] = []
    var film:Model?
    var names: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshDataSource()
        createUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshDataSource()
        createUI()
    }
    
    fileprivate func refreshDataSource(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Film")
     //   fetchRequest.predicate = NSPredicate(format: "savedBookmark == %@", true as CVarArg)
        
        do {
            filmss = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        self.savedbmarkedFilmCV.reloadData()
    }
    
    fileprivate func createUI(){
        createCell()
    }
    
    fileprivate func createCollectionview(){
        
    }
    
    fileprivate func createCell(){
        let nib = UINib(nibName: "FilmCollectionVwCll", bundle: nil)
        self.savedbmarkedFilmCV.register(nib, forCellWithReuseIdentifier: "Cell")
    }
    
    @IBAction func nmeAction(_ sender: Any) {

    
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc  = segue.destination as? DetailsVC
        vc?.film = self.film
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

extension BookmarkVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.filmss.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        let cell = savedbmarkedFilmCV.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilmCollectionVwCll
        cell.filmTitleLbl.text = filmss[indexPath.row].value(forKey: "filmTitle")! as? String
        cell.rlsDateLbl.text = filmss[indexPath.row].value(forKey: "filmReleaseDate")! as? String
        cell.averageVoteLbl.text = filmss[indexPath.row].value(forKey: "averageVote")! as? String
        if let link = URL(string: "http://image.tmdb.org/t/p/w500\(filmss[indexPath.row].value(forKey: "filmCover")! as! String)"){
            cell.filmCoverImgVw.kf.setImage(with: link)
        }
        cell.filmSummaryLbl.text = filmss[indexPath.row].value(forKey: "filmSummary")! as? String
        cell.bookmarkBtn.isHidden = true
        return cell
    }
    

        
}
