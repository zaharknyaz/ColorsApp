//
//  RecordViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 15.10.2021.
//

import UIKit

class RecordViewController: UIViewController {
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let record = UserDefaults.standard.integer(forKey: keysUserDefaults.recordGame)
        if record != 0 {
            recordLabel.text = "Your record - \(record)"
        }else {
            recordLabel.text = "Record not set"
        }
    }
    
    @IBAction func closeVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
