//
//  TableViewController.swift
//  NeighborhoodHistory
//
//  Created by Kelly Mei on 8/6/21.
//

import UIKit

class TableViewController: UIViewController, UITableViewDataSource {

    
    @IBOutlet weak var ProfileView: UITableView!
    
    let items = ["My Posts", "Collection", "Saved"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProfileView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }

}
