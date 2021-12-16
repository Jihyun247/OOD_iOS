//
//  SettingViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit

class SettingViewController: UIViewController {
    
    let deviceHeight = UIScreen.main.bounds.height / 896
    
    @IBOutlet weak var naviTitleLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviTitleLabel.font = UIFont.notoSansMedium(size: 18)
        naviTitleLabel.text = "설정"
        
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = settingTableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.identifier, for: indexPath) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.font = UIFont.notoSansMedium(size: 16)
        
        switch indexPath.row {
        case 0:
            cell.titleLabel.text = "로그아웃"
        default:
            cell.titleLabel.text = "정보수집처리방침"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            UserDefaults.standard.removeObject(forKey: "token")
            self.dismiss(animated: true, completion: nil)
        default:
            guard let url = URL(string: "https://longhaired-middle-9c1.notion.site/37861210bb2546599242881a54f67df8"), UIApplication.shared.canOpenURL(url) else {return}
            UIApplication.shared.open(url)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
