//
//  BlueViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 12.10.2021.
//

import UIKit

class BlueViewController: UIViewController {

    @IBOutlet weak var testLabel: UILabel!
    var textForLabel = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        testLabel.text = textForLabel
    }
    
    @IBAction func goToGreenController(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "greenVC") as? GreenViewController {
            vc.textForLabel = "Test String Green"
            vc.title = "Зеленый"
            //pushViewController не рекомендует Apple
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
        
}
