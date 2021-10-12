//
//  YellowViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 12.10.2021.
//

import UIKit

class YellowViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func goToBlueController(_ sender: Any) {
        performSegue(withIdentifier: "goToBlue", sender: nil)
    }
}
