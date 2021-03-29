//
//  UserViewController.swift
//  Magic Weather
//
//  Created by Cody Kerns on 12/14/20.
//

import UIKit
import Purchases

/*
 View controller to display user's details like subscription status and ID's.
 Configured in /Resources/UI/Main.storyboard
 */

class UserViewController: UIViewController {

    @IBOutlet var userIdLabel: UILabel!
    @IBOutlet var statusLabel: UILabel!

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// - Refresh details when the User tab is viewed
        refreshUserDetails()
    }

    func refreshUserDetails() {
        self.userIdLabel.text = Purchases.shared.appUserID

        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if purchaserInfo?.entitlements[Constants.entitlementID]?.isActive == true {
                self.statusLabel.text = "Active"
                self.statusLabel.textColor = .green
            } else {
                self.statusLabel.text = "Not Active"
                self.statusLabel.textColor = .red
            }
        }
    }
}
/*
 How to restore purchases using the Purchases SDK. Read more about restoring purchases here: https://docs.revenuecat.com/docs/making-purchases#restoring-purchases
 */
extension UserViewController {
    
    /// - Restore purchases method
    @IBAction
    func restorePurchases() {
        Purchases.shared.restoreTransactions { (purchaserInfo, error) in
            if let error = error {
                self.present(UIAlertController.errorAlert(message: error.localizedDescription), animated: true, completion: nil)
            }
            
            self.refreshUserDetails()
        }
    }
}
