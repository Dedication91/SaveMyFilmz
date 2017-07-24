

import Foundation
import UIKit


extension UIViewController {
    
    func displayPromptAlert(_ title: String, mssg: String, killActnTitle: String, destructHandlerr: ((UIAlertAction) -> Void)?) {
        let alertControllerr = UIAlertController(title: title, message: mssg, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertControllerr.addAction(cancel)
        let kill = UIAlertAction(title: killActnTitle, style: .destructive, handler: destructHandlerr)
        
        alertControllerr.addAction(kill)
        
        present(alertControllerr, animated: true, completion: nil)
    }
}
