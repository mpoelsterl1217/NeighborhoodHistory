//
//  UploadViewController.swift
//  NeighborhoodHistory
//
//  Created by Kelly Mei on 8/4/21.
//

import UIKit

class UploadViewController: UIViewController, UITableViewDataSource {
    
    let items = ["Upload Image", "Description", "Location", "Anonymous", "Upload Button"]

    @IBOutlet weak var uploadTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadTableView.dataSource = self
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let UploadCell1TableViewCell = tableView.dequeueReusableCell(withIdentifier: "UploadCell1TableViewCell")!
        UploadCell1TableViewCell.textLabel?.text = items[indexPath.row]
        return UploadCell1TableViewCell
    }

}
