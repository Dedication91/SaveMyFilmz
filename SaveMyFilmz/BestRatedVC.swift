

import UIKit
import CoreData
class BestRatedVC: UIViewController {

    
    @IBOutlet weak var activityIndicatir: UIActivityIndicatorView!
    @IBOutlet weak var bestRtedCllctionVwCntrllr: UICollectionView!
    
    
    var films = [Model]()
    var film:Model?
    var bookmarkedFilms = [Film]()
    
    override func viewWillAppear(_ animated: Bool) {
        refreshDataSource()

        createUI()
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        refreshDataSource()

        createUI()
        

    }
    

    
    fileprivate func refreshDataSource(){
        // Films from the JSON
        activityIndicatir.startAnimating()

        FilmRepo.showBestRated{ (films, error) in
    self.activityIndicatir.stopAnimating()

            if let error = error {

                self.displayPromptAlert("Error", mssg: error.localizedDescription, killActnTitle: "Ok", destructHandlerr: nil)
                return
            }
            self.films = films!
            self.bestRtedCllctionVwCntrllr.reloadData()
        }

        // Get array of all bookmarked films
        //  fetch bookmarks  in bookmarkedFilms
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let context =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<Film>(entityName: "Film")
        //   fetchRequest.predicate = NSPredicate(format: "savedBookmark == %@", true as CVarArg)
        
        do {
            bookmarkedFilms = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
        
    }
    
    fileprivate func createUI(){

        createCell()
    }
    
    fileprivate func createCell(){
        let nibFile = UINib(nibName: "FilmCollectionVwCll", bundle: nil)
        self.bestRtedCllctionVwCntrllr.register(nibFile, forCellWithReuseIdentifier: "Cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc  = segue.destination as? DetailsVC
        vc?.film = self.film
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

extension BestRatedVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.films.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bestRtedCllctionVwCntrllr.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! FilmCollectionVwCll
        cell.filmTitleLbl.text = films[indexPath.row].filmTitle
        cell.rlsDateLbl.text = films[indexPath.row].filmRlsDate
        cell.averageVoteLbl.text = String(films[indexPath.row].averageVote)
        if let link = URL(string: "http://image.tmdb.org/t/p/w500\(films[indexPath.row].filmCover!)"){
            cell.filmCoverImgVw.kf.setImage(with: link)
        }
        cell.filmSummaryLbl.text = films[indexPath.row].filmSummary
        cell.film = films[indexPath.row]
        
        // Need to set correct image for button
        // Check if looming filmTitle is in bookmarkedFilms
        for bookmarked in bookmarkedFilms {
            if bookmarked.filmTitle  ?? "" == films[indexPath.row].filmTitle {
                
                let image = UIImage(named: "bookmarkOn") as UIImage!
                cell.bookmarkBtn.setImage(image, for: .normal)
                cell.bookmarkBtnPrssd = false
                
                // make the star gold
                
                //make if else to turn off
                break
            }
            else {
                let image = UIImage(named: "bookmarkOff") as UIImage!
                cell.bookmarkBtn.setImage(image, for: .normal)
                cell.bookmarkBtnPrssd = true
            }
            
        }
        
        return cell
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            self.film = films[indexPath.row]
            performSegue(withIdentifier: "toDetails", sender: DetailsVC.self)
        }
        
        func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
            
        }
        
}
