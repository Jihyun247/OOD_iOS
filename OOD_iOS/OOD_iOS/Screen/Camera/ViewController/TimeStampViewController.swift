//
//  TimeStampViewController.swift
//  OOD_iOS
//
//  Created by 김지현 on 2021/11/29.
//

import UIKit
import AVFoundation

class TimeStampViewController: UIViewController {
    
    var captureSession: AVCaptureSession!
    var capturedImageOutput: AVCapturePhotoOutput!
    var videoPreviewLayer: AVCaptureVideoPreviewLayer!
    
    var timeStampImage: UIImage?
    
    @IBOutlet weak var cameraView: UIView!
    @IBOutlet weak var timestampBorderVIew: UIView!
    
    @IBOutlet weak var stampDateLabel: UILabel!
    @IBOutlet weak var stampTimeLabel: UILabel!
    
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCameraView()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setCaptureSession()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.captureSession.stopRunning()
    }
    
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cameraBtnClicked(_ sender: UIButton) {
        let settings = AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])
        // jpeg 파일 형식으로 format
        capturedImageOutput.capturePhoto(with: settings, delegate: self)
        // AVCapturePhotoCaptureDelegate 위임
    }
    
    func setCameraView() {
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(nowTimeLabel), userInfo: nil, repeats: true)
        
        stampDateLabel.font = UIFont.robotoMedium(size: 50)
        stampDateLabel.textColor = .white
        stampTimeLabel.font = UIFont.robotoMedium(size: 50)
        stampTimeLabel.textColor = .white
        nowTimeLabel()
        
        timestampBorderVIew.backgroundColor = .clear
        timestampBorderVIew.setBorderColorAndRadius(borderColor: .white, borderWidth: 1, cornerRadius: 2)
        
        cancelButton.titleLabel?.font = UIFont.notoSansMedium(size: 17)
        cancelButton.tintColor = UIColor(named: "OOD_purple")
    }
    
    @objc func nowTimeLabel() {
        // 현재 시간을 기반으로 time과 날짜를 label에 넣어줌
        stampTimeLabel.text = Date().timestampToString().recordTime()
        stampDateLabel.text = Date().timestampToString().recordDate()
    }

    func setupLivePreview() {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // captureSession를 사용해 캡쳐한 비디오를 표시해줌
        
        videoPreviewLayer.videoGravity = .resizeAspectFill
        // videoGravity: 콘텐츠를 표시하는 방법 -> resizeAspectFill: 비율을 유지하면서 채우기
        videoPreviewLayer.connection?.videoOrientation = .portrait
        // portrait - 세로, landscape - 가로모드
        cameraView.layer.addSublayer(videoPreviewLayer)
        // cameraView의 위치에 videoPreviewLayer를 띄움
    }
    
    func setCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.sessionPreset = .high
        // 캡쳐 화질 high로 설정
        
        // default video 장치를 찾는다
        guard let backCamera = AVCaptureDevice.default(for: AVMediaType.video)
            else {
                print("Unable to access back camera!")
                return
        }
        do {
            // 찾은 video 장치를 캡쳐 장치에 넣음
            let input = try AVCaptureDeviceInput(device: backCamera)
            capturedImageOutput = AVCapturePhotoOutput()

            // 주어진 세션을 캡쳐에 사용할 수 있는지 + 세션에 추가할 수 있는지 먼저 파악한다
            if captureSession.canAddInput(input) && captureSession.canAddOutput(capturedImageOutput) {
                // 주어진 입력을 추가한다
                captureSession.addInput(input)
                // 주어진 출력 추가
                captureSession.addOutput(capturedImageOutput)
                setupLivePreview()
            }
        }
        catch let error  {
            print(error.localizedDescription)
        }
        
        // startRunning는 시간이 걸릴 수 있는 호출이므로 main queue가 방해되지 않게 serial queue에서 실행함
        DispatchQueue.global(qos: .userInitiated).async {
            // 세션 실행 시작
            self.captureSession.startRunning()
            // 콜백 클로저를 통해 세션실행이 시작하는 작업이 끝난다면
            // cameraView에 AVCaptureVideoPreviewLayer를 띄우게 만듦
            DispatchQueue.main.async {
                self.videoPreviewLayer.frame = self.cameraView.bounds
            }
        }
    }
}

extension TimeStampViewController: AVCapturePhotoCaptureDelegate {
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        
        guard let imageData = photo.fileDataRepresentation()
            else { return }
        
        let image = UIImage(data: imageData)
        timeStampImage = image?.cropToBounds(width: Double(cameraView.layer.frame.width), height: Double(cameraView.layer.frame.width))
        
        guard let timestampCheckVC = self.storyboard?.instantiateViewController(identifier: "TimeStampCheckViewController") as? TimeStampCheckViewController else {
            return
        }
        
        timestampCheckVC.snapImage = timeStampImage
        timestampCheckVC.snapDate = self.stampDateLabel.text
        timestampCheckVC.snapTime = self.stampTimeLabel.text
        
        self.navigationController?.pushViewController(timestampCheckVC, animated: true)
    }
    
}
