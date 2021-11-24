//
//  SignupPageViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/24.
//

import UIKit

class SignupPageViewController: UIPageViewController {
    
    let identifiers: NSArray = ["SignupFirstViewController", "SignupSecondViewController"]

    lazy var vcArray: [UIViewController] = {
        return [vcInstance(identifier: "SignupFirstViewController"),
                vcInstance(identifier: "SignupSecondViewController")
        ]
    }()
    
    private func vcInstance(identifier: String) -> UIViewController {
        return UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstVC = vcArray.first{
            setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }

}
