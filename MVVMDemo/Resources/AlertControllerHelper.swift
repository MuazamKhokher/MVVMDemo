//
//  AlertControllerHelper.swift
//  Moment
//
//  Created by Muazam on 20/02/2022.
//

import UIKit

///:- AlertControllerHelper is general class for shwoing alert to users.
class AlertControllerHelper {
    
    class func showAlert(message:String , vc : UIViewController) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default ,handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        vc.present(alert, animated: true, completion: nil)
    }
    
}
