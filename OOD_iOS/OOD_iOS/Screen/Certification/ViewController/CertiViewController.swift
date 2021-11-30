//
//  CertiViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/21.
//

import UIKit
import FSCalendar

class CertiViewController: UIViewController{
    
    //MARK: - parameter
    
    let spacing = (UIScreen.main.bounds.width/414) * 20
    let deviceHeight = UIScreen.main.bounds.height / 896
    
    let collectionHeaderDF = DateFormatter()
    let calendarHeaderDF = DateFormatter()
    let queryDF = DateFormatter()
    
    var selectedDate: String?
    var selectedDateDelegate: SelectedDateDelegate?
    var currentPage: Date?
    lazy var today: Date = {
        return Date()
    }()
    
    var certiListData: [CertiListData] = [] {
        didSet {
            print("언제 호출되느냐")
            certiCollectionView.reloadData()
            
            DispatchQueue.main.async {
                self.collectionViewHeight.constant = self.certiCollectionView.contentSize.height
                self.certiCollectionView.isHidden = false
            }
            
            if certiListData.count == 0 {
                noCertiLabel.isHidden = true
                noCertiImageView.isHidden = true
            } else {
                noCertiLabel.isHidden = false
                noCertiImageView.isHidden = false
            }
        }
    }
    
    //MARK: - @IBOutlet
    
    @IBOutlet weak var certiCollectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var calendarViewHeight: NSLayoutConstraint!
    // 캘린더뷰 Height도 디바이스에 따라 조절해주기
    
    @IBOutlet weak var calendarView: FSCalendar!
    
    @IBOutlet weak var viewTitleLabel: UILabel!
    @IBOutlet weak var viewGuideLabel: UILabel!
    @IBOutlet weak var calendarHeaderLabel: UILabel!
    @IBOutlet weak var noCertiLabel: UILabel!
    @IBOutlet weak var noCertiImageView: UIImageView!
    
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var mypageButton: UIButton!
    
    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        print(UIScreen.main.bounds.height)
        setDateFormat()
        setCalendarView()
        setCollectionView()
        setLabelUI()
        setButtonUI()
        
        let todayDate = self.queryDF.string(from: today)
        if let token = UserDefaults.standard.string(forKey: "token") {
            certiListByCal(token: token, date: selectedDate ?? todayDate)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let todayDate = self.queryDF.string(from: today)
        if let token = UserDefaults.standard.string(forKey: "token") {
            certiListByCal(token: token, date: selectedDate ?? todayDate)
        }
    }
    
    //MARK: - func
    
    func setCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        certiCollectionView.collectionViewLayout = layout
        
        certiCollectionView.delegate = self
        certiCollectionView.dataSource = self
        
        let nibName = UINib(nibName: CertiCollectionViewCell.identifier, bundle: nil)
        certiCollectionView.register(nibName, forCellWithReuseIdentifier: CertiCollectionViewCell.identifier)
    }
    
    func setCalendarView() {
        calendarView.delegate = self
        calendarView.dataSource = self
        
        calendarView.scrollDirection = .horizontal
        calendarView.appearance.selectionColor = UIColor(named: "OOD_blue")
        calendarView.locale = Locale(identifier: "ko")
        calendarView.today = nil
        calendarView.scope = .week
        calendarView.select(self.today)
        
        calendarView.headerHeight = 0
        calendarView.weekdayHeight = 40
        calendarView.appearance.weekdayFont = UIFont.notoSansMedium(size: 16.0)
        calendarView.appearance.weekdayTextColor = .systemGray3
        calendarView.appearance.titleFont = UIFont.robotoMedium(size: 16.0)
        
        calendarHeaderLabel.text = self.calendarHeaderDF.string(from: calendarView.currentPage)
        
        calendarViewHeight.constant = deviceHeight * 120
    }
    
    func setDateFormat() {
        collectionHeaderDF.locale = Locale(identifier: "ko")
        collectionHeaderDF.dateFormat = "M월 d일 EEEE"
        
        calendarHeaderDF.locale = Locale(identifier: "ko")
        calendarHeaderDF.dateFormat = "YYYY년 M월"
        
        queryDF.locale = Locale(identifier: "ko")
        queryDF.dateFormat = "YYYY-MM-dd"
    }
    
    func setLabelUI() {
        viewTitleLabel.font = UIFont.notoSansBold(size: 24)
        viewTitleLabel.textColor = .white
        viewGuideLabel.font = UIFont.notoSansMedium(size: 14)
        viewTitleLabel.textColor = .white
        calendarHeaderLabel.font = UIFont.notoSansMedium(size: 22)
        calendarHeaderLabel.textColor = .black
        noCertiLabel.font = UIFont.notoSansMedium(size: 18)
        noCertiLabel.textColor = .black
    }
    
    func setButtonUI() {
        addButton.imageView?.image = UIImage(named: "addCertiBtn")
    }
    
    func scrollCurrentPage(isPrev: Bool) {
        let cal = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = isPrev ? -1 : 1
        
        self.currentPage = cal.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
    func certiListByCal(token: String, date: String) {
        APIService.shared.certiListByCal(token: token, date: date) { result in
            switch result {
            case .success(let resultData):
                self.certiListData = resultData as? [CertiListData] ?? []
            case .requestErr(let message):
                print("requestErr", message)
            case .pathErr:
                print("pathErr")
            case .failure(let err):
                print(err)
            }
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func prevBtnClicked(_ sender: UIButton) {
        scrollCurrentPage(isPrev: true)
    }
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        scrollCurrentPage(isPrev: false)
    }
    
    
    
    @IBAction func addCertiButtonClicked(_ sender: UIButton) {
        
        guard let certiUploadVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiTimeSelectViewController") as? CertiTimeSelectViewController else {return}
        
        navigationController?.pushViewController(certiUploadVC, animated: true)
    }
    
    @IBAction func mypageButtonClicked(_ sender: UIButton) {
        guard let mypageVC = self.storyboard?.instantiateViewController(withIdentifier: "MypageViewController") as? MypageViewController else {return}
        
        navigationController?.pushViewController(mypageVC, animated: true)
    }

}

//MARK: - extension CollectionView Delegate & DataSource

extension CertiViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    
    // 콜렉션 헤더
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard let headerView = certiCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CertiCollectionReusableView.identifier, for: indexPath) as? CertiCollectionReusableView else {
            return UICollectionReusableView()
        }
        
        self.selectedDateDelegate = headerView
        headerView.selectedDateLabel.font = UIFont.notoSansMedium(size: 20.0)
        headerView.selectedDateLabel.textColor = .black
        
        return headerView
    }
    
    // 셀 개수 & 셀 내용
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return certiListData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = certiCollectionView.dequeueReusableCell(withReuseIdentifier: "CertiCollectionViewCell", for: indexPath) as? CertiCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.certiImageView.setKFImage(from: certiListData[indexPath.row].imageUrl ?? "")
        cell.certiImageView.contentMode = .scaleAspectFill
        cell.setBorderColorAndRadius(borderColor: .clear, borderWidth: 0, cornerRadius: 8)
        
        return cell
    }
    
    // 셀 클릭 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let certiDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "CertiDetailViewController") as? CertiDetailViewController else {return}
        
        certiDetailVC.certiId = certiListData[indexPath.row].id
        
        navigationController?.pushViewController(certiDetailVC, animated: true)
    }
}

//MARK: - extension CollectionView DelegateFlowLayout

extension CertiViewController: UICollectionViewDelegateFlowLayout {
    
    // 지정된 셀 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let deviceWidth = UIScreen.main.bounds.width
        let width = (deviceWidth - self.spacing*3) / 2 // 왼쪽 중앙 오른쪽 spacing 세개
        
        return CGSize(width: width, height: width)
    }
    
    // 지정된 섹션의 여백을 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: self.spacing, bottom: self.spacing, right: self.spacing)
    }
    
    // 섹션 행 사이 최소 간격 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.spacing
    }
    
    // 섹션 헤더뷰 크기 반환
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: deviceHeight * 70)
    }
    
}

//MARK: - extension FSCalendar

extension CertiViewController: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let stringDate = self.collectionHeaderDF.string(from: date)
        self.selectedDateDelegate?.setLabel(date: stringDate)
        
        selectedDate = self.queryDF.string(from: date)
        if let token = UserDefaults.standard.string(forKey: "token") {
            certiListByCal(token: token, date: selectedDate!)
        }
        
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.calendarHeaderLabel.text = self.calendarHeaderDF.string(from: calendarView.currentPage)
    }

    
}
