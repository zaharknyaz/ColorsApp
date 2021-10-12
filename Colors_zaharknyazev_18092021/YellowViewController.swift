//
//  YellowViewController.swift
//  Colors_zaharknyazev_18092021
//
//  Created by Захар Князев on 12.10.2021.
//

import UIKit

class YellowViewController: UIViewController {

    //3 метода когда контроллер показывается:
    
    //при загрузке(выполняется 1 раз при загрузке контроллера)
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" YellowViewController viewDidLoad")
    }

    //перед отображением view controller(выполняется каждый раз при переходе на контроллер)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(" YellowViewController viewWillAppear")
    }
    
    //сразу после отображения view controller(выполняется каждый раз при переходе на контроллер) - подходит для ресурсоемких задач в фоне
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(" YellowViewController viewDidAppear")
    }
    
    //2 метода когда контроллер уходит с экрана:
    
    //вызывается перед тем как контроллер будет скрыт с экрана
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(" YellowViewController viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(" YellowViewController viewDidDisappear")
    }
    
    //вызывается когда контроллер уже скрыт и будет уничтожен если на контроллер нет strong ссылок(только weak ссылки)
    @IBAction func goToBlueController(_ sender: Any) {
        //performSegue рекомендует использовать Apple
        performSegue(withIdentifier: "goToBlue", sender: "Test String")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "goToBlue":
            if let blueVC = segue.destination as? BlueViewController {
                if let string = sender as? String {
                    blueVC.textForLabel = string
                }
            }
        default:
            break
        }
        
    }
    
    //вызывается при уничтожении экземпляра класса
    deinit {
        print(" YellowViewController deinit")
    }
}
