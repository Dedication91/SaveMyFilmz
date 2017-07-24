import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var filmCoverImgVw: UIImageView!
    @IBOutlet weak var filmTitleLbl: UILabel!
    @IBOutlet weak var filmReleaseDateLbl: UILabel!
    @IBOutlet weak var filmSummaryLbl: UILabel!
    @IBOutlet weak var averageVoteLbl: UILabel!
    
    var film:Model?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createUI()
        ProgressHUD.dismiss()
    }
    
    fileprivate func createUI(){
        if let film = self.film {
            self.filmTitleLbl.text = film.filmTitle
            self.averageVoteLbl.text =  "\(film.averageVote!)"
            self.filmSummaryLbl.text = film.filmSummary
            self.filmReleaseDateLbl.text = film.filmRlsDate
            if let link = URL(string: "http://image.tmdb.org/t/p/w500\(film.filmCover!)"){
                self.filmCoverImgVw.kf.setImage(with: link)
            }
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func closeBtnPrssd(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
