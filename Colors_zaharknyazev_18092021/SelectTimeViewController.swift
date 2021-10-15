//
//  SelectTimeViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 13.10.2021.
//

import UIKit

class SelectTimeViewController: UIViewController {

    var data: [Int] = []
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView?.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension SelectTimeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 5
        }
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath)
        cell.textLabel?.text = "section - \(indexPath.section) row - \(indexPath.row)"
        return cell
        //17:54 про reusable cell
    }
    
}
