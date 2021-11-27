//
//  SignupViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit

protocol NextBtnDelegate {
    func nextBtnClicked(nickname: String, email: String, password: String)
}

class SignupViewController: UIViewController {
    
    var pageVC: SignupPageViewController?
    var pageIndex = 0

    @IBOutlet weak var progressbar: UIProgressView!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setPrgressbarUI()
        setbackBtnUI()
        
        progressbar.progress = 0.5
        UIView.animate(withDuration: 1.0, animations: {
            self.progressbar.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func setPrgressbarUI() {
        progressbar.progressTintColor = UIColor(named: "OOD_blue")
    }
    
    func setbackBtnUI() {
        backButton.imageView?.image = UIImage(named: "backbtn")
        navigationController?.setNavigationBarHidden(true, animated: false)
        backButton.setAttributedTitle(nil, for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        pageVC = segue.destination as? SignupPageViewController
        if let signupFirstVC = pageVC?.vcArray[0] as? SignupFirstViewController {
            signupFirstVC.nextBtnDelegate = self
        }
    }
    
    @IBAction func backButtonClicked(_ sender: UIButton) {
        switch pageIndex {
        case 0:
            print("현인덱스 \(pageIndex) - 로그인뷰로")
            self.navigationController?.popViewController(animated: true)
        case 1:
            print("현인덱스 \(pageIndex) - 정보입력로")
            pageIndex -= 1
            progressbar.progress = 0.5
            UIView.animate(withDuration: 2.0, animations: {
                self.progressbar.layoutIfNeeded()
            }, completion: nil)
            
            if let signupFirstVC = pageVC?.vcArray[0] as? SignupFirstViewController {
                pageVC?.setViewControllers([signupFirstVC], direction: .reverse, animated: false, completion: nil)
            }
        default:
            return
        }
        
        
    }
    
}

extension SignupViewController: NextBtnDelegate {

    func nextBtnClicked(nickname: String, email: String, password: String) {

        pageIndex += 1
        progressbar.progress = 1.0
        UIView.animate(withDuration: 2.0, animations: {
            self.progressbar.layoutIfNeeded()
        }, completion: nil)
        
        if let signupSecondVC = pageVC?.vcArray[1] as? SignupSecondViewController {
            pageVC?.setViewControllers([signupSecondVC], direction: .forward, animated: false, completion: nil)
            
            signupSecondVC.nickname = nickname
            signupSecondVC.email = email
            signupSecondVC.password = password
        }
    }
    
    
}


