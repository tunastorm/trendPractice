//
//  NasaViewController.swift
//  trendPractice
//
//  Created by 유철원 on 7/1/24.
//

import UIKit


final class NasaViewController: UIViewController {
    private enum Nasa: String, CaseIterable {
        
        static let baseURL = "https://apod.nasa.gov/apod/image/"
        
        case one = "2308/sombrero_spitzer_3000.jpg"
        case two = "2212/NGC1365-CDK24-CDK17.jpg"
        case three = "2307/M64Hubble.jpg"
        case four = "2306/BeyondEarth_Unknown_3000.jpg"
        case five = "2307/NGC6559_Block_1311.jpg"
        case six = "2304/OlympusMons_MarsExpress_6000.jpg"
        case seven = "2305/pia23122c-16.jpg"
        case eight = "2308/SunMonster_Wenz_960.jpg"
        case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
         
        static var photo: URL {
            return URL(string: baseURL + Nasa.allCases.randomElement()!.rawValue)!
        }
    }
    
    private let nasaImageView = UIImageView()
    private let progressLabel = UILabel()
    private let requestButton = UIButton()
    
    private var total: Double = 0
    private var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\((result * 100).formatted()) / 100"
        }
    }
    
    private var session: URLSession?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configHierarchy()
        configLayout()
        configView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        session?.invalidateAndCancel()
//        session?.finishTasksAndInvalidate()
    }
    
    private func configHierarchy() {
        view.addSubview(nasaImageView)
        view.addSubview(progressLabel)
        view.addSubview(requestButton)
    }
    
    private func configLayout() {
        requestButton.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        progressLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(requestButton.snp.bottom).offset(20)
            $0.height.equalTo(50)
        }
        nasaImageView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(progressLabel.snp.bottom).offset(20)
        }
    }
    
    private func configView() {
        view.backgroundColor = .white
        requestButton.backgroundColor = .gray
        progressLabel.backgroundColor = .blue
        nasaImageView.backgroundColor = .red
        requestButton.addTarget(self, action: #selector(requestButtonClicked), for: .touchUpInside)
    }
    
    private func callRequest() {
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        let request = URLRequest(url: Nasa.photo)
        session?.dataTask(with: request).resume()
    }
    
    @objc private func requestButtonClicked() {
        callRequest()
    }
                            
}

extension NasaViewController: URLSessionDataDelegate {
   func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200..<300).contains(response.statusCode) {
            guard let contentLength = response.value(forHTTPHeaderField: "Content-Length") else {
                return .cancel
            }
            guard let total = Double(contentLength) else {
                return .cancel
            }
            self.total = total
            buffer = Data()
            
            return .allow
        } else {
            return .cancel
        }
    }
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        buffer?.append(data)
        guard let buffer else {
            return
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        if let error = error {
            progressLabel.text = "에러가 발생했습니다"
        } else {
            guard let buffer = buffer else {
                return
            }
            nasaImageView.image = UIImage(data: buffer)
        }
    }
}
