import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nmeLbl: UILabel!
    @IBOutlet weak var cnfirm: UIButton!
    @IBOutlet weak var txtlbl: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtlbl.delegate = self
 
    }
    
    func textFieldShouldReturn(_ txtlbl: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    

    @IBAction func confirm(_ sender: Any) {
        if txtlbl.text != "" {
            cnfirm.isEnabled = true
            nmeLbl.text = "Hello, " + txtlbl.text! + " Welcome To SaveMyFilmz!"
            self.txtlbl.resignFirstResponder()
            let when = DispatchTime.now() + 3
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.performSegue(withIdentifier: "tab", sender: self)
            }


        } else {
            
           cnfirm.isEnabled = false
        }
        
    }
    @IBAction func fldAction(_ sender: Any) {

 
    }

}
