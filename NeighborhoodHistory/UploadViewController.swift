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
        
        displayLbl.text = " "

    }

    @IBAction func uploadPressed(_ sender: UIButton) {
        let alertView = UIAlertController(title: nil, message: "how would you like to upload?", preferredStyle: .actionSheet)
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (action) in self.displayLbl.text = "Upload Canceled"
        }
        
        let photo = UIAlertAction(title: "Import from Library", style: .default) { (action) in self.displayLbl.text = "Upload Successful!"
        }
        
        let camera = UIAlertAction(title: "Camera", style: .default) { (action) in self.displayLbl.text = "Upload Successful!"
        }
    
        alertView.addAction(cancel)
        alertView.addAction(photo)
        alertView.addAction(camera)

        present(alertView, animated: true, completion: nil)
}

    }

