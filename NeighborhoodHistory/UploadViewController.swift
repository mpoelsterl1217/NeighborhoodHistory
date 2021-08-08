//
//  UploadViewController.swift
//  NeighborhoodHistory
//
//  Created by Kelly Mei on 8/8/21.
//

import UIKit

class UploadViewController: UIViewController {
    
    @IBOutlet weak var displayLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // label reflects user actions
        displayLbl.text = " "

    }

    @IBAction func uploadPressed(_ sender: UIButton) {
        
        // creating popup alert view with 3 options
        let alertView = UIAlertController(title: nil, message: "How would you like to upload?", preferredStyle: .actionSheet)
        
        // pressing cancel will collapse the alertView
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in self.displayLbl.text = "Upload Canceled"
        }
        
        let photo = UIAlertAction(title: "Import from Library", style: .default) { (action) in self.displayLbl.text = "Upload Successful!"
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in self.displayLbl.text = "Upload Successful!"
        }
    
        // adding each option to the alertView
        alertView.addAction(cancel)
        alertView.addAction(photo)
        alertView.addAction(camera)

        present(alertView, animated: true, completion: nil)
}

    }

