//
//  WelcomeViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 24.03.23.
//

import Foundation
import UIKit
import SnapKit

final class WelcomeViewController: UIViewController {
    
    //MARK: - image group of circles
    private lazy var imageViewGroupOfCircles: UIImageView = {
        let imageViewGroupOfCircles = UIImageView()
        let imageGroupOfCircles = UIImage(named: "groupOfCircles")
        imageViewGroupOfCircles.image = imageGroupOfCircles
        view.addSubview(imageViewGroupOfCircles)
        return imageViewGroupOfCircles
    }()
    
    //MARK: - top image
    private lazy var imageViewTop: UIImageView = {
        let imageViewTop = UIImageView()
        let imageTop = UIImage(named: "welcomeImageTop")
        imageViewTop.image = imageTop
        imageViewTop.layer.cornerRadius = 21
        imageViewTop.layer.masksToBounds = true
        view.addSubview(imageViewTop)
        return imageViewTop
    }()
    
    //MARK: - right image
    private lazy var imageViewRight: UIImageView = {
        let imageViewRight = UIImageView()
        let imageRight = UIImage(named: "welcomeImageRight")
        imageViewRight.image = imageRight
        imageViewRight.layer.cornerRadius = 16
        imageViewRight.layer.masksToBounds = true
        view.addSubview(imageViewRight)
        return imageViewRight
    }()
    
    //MARK: - bottom image
    private lazy var imageViewBottom: UIImageView = {
        let imageViewBottom = UIImageView()
        let imageBottom = UIImage(named: "welcomeImageBottom")
        imageViewBottom.image = imageBottom
        imageViewBottom.layer.cornerRadius = 35
        imageViewBottom.layer.masksToBounds = true
        view.addSubview(imageViewBottom)
        return imageViewBottom
    }()
    
    //MARK: - header label
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Welcome!"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - description label
    private lazy var labelDescription: UILabel = {
        let labelDescription = UILabel()
        labelDescription.text = "Let's stay in touch! Please sign up or log in to account."
        labelDescription.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        labelDescription.font = UIFont(name: "Inter-Regular", size: 14)
        labelDescription.numberOfLines = 2
        view.addSubview(labelDescription)
        return labelDescription
    }()
    
    //MARK: - sign up button
    private lazy var buttonSignUp: UIButton = {
        let buttonSignUp = UIButton()
        buttonSignUp.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonSignUp.layer.cornerRadius = 10
        buttonSignUp.setTitle("Sign up", for: .normal)
        buttonSignUp.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        view.addSubview(buttonSignUp)
        return buttonSignUp
    }()
    
    //MARK: - log in button
    private lazy var buttonLogIn: UIButton = {
        let buttonLogIn = UIButton()
        buttonLogIn.backgroundColor = UIColor(red: 229/255, green: 239/255, blue: 251/255, alpha: 1)
        buttonLogIn.layer.cornerRadius = 10
        buttonLogIn.setTitle("Login", for: .normal)
        buttonLogIn.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        buttonLogIn.setTitleColor(UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1), for: .normal)
        view.addSubview(buttonLogIn)
        return buttonLogIn
    }()
    
    //MARK: - activity indicator
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .gray
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        return activityIndicator
    }()
    
    //MARK: - later button
    private lazy var buttonLater: UIButton = {
        let buttonLater = UIButton()
        buttonLater.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        buttonLater.layer.cornerRadius = 10
        buttonLater.setTitle("Later", for: .normal)
        buttonLater.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        buttonLater.setTitleColor(UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1), for: .normal)
        view.addSubview(buttonLater)
        return buttonLater
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupGroupOfCircle()
        setupImageTop()
        setupImageRight()
        setupImageBottom()
        setupLabelHeader()
        setupLabelDescription()
        setupButtonSignUp()
        setupButtonLogIn()
        setupIndicator()
        setupButtonLater()
    }
    
    //MARK: - group of circles on the background
    func setupGroupOfCircle() {
        
        //constraints
        imageViewGroupOfCircles.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(30)
            make.size.equalTo(335)
        })
    }
    
    //MARK: - image top
    func setupImageTop() {
        
        //constraints
        imageViewTop.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCircles.snp.leading).inset(45)
            make.top.equalTo(imageViewGroupOfCircles.snp.top).inset(51)
            make.size.equalTo(42)
        })
    }
    
    //MARK: - image right
    func setupImageRight() {
        
        //constraints
        imageViewRight.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewGroupOfCircles.snp.trailing).inset(-6)
            make.bottom.equalTo(imageViewGroupOfCircles.snp.bottom).inset(88)
            make.size.equalTo(32)
        })
    }
    
    //MARK: - image bottom
    func setupImageBottom() {
        
        //constraints
        imageViewBottom.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCircles.snp.leading).inset(80)
            make.bottom.equalTo(imageViewGroupOfCircles.snp.bottom).inset(-10)
            make.size.equalTo(70)
        })
    }
    
    //MARK: - label header
    func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCircles.snp.leading)
            make.top.greaterThanOrEqualTo(imageViewGroupOfCircles.snp.bottom).offset(30)
            make.width.equalTo(130)
            make.height.equalTo(32)
        })
    }
    
    //MARK: - label description
    func setupLabelDescription() {
        
        //constraints
        labelDescription.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCircles.snp.leading)
            make.top.equalTo(labelHeader.snp.bottom).offset(2)
            make.width.equalTo(292)
            make.height.equalTo(34)
        })
    }
    
    //MARK: - button sign up
    func setupButtonSignUp() {
        
        //constraints
        buttonSignUp.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelDescription.snp.bottom).offset(26)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        buttonSignUp.addTarget(self, action: #selector(actionForSignupButton), for: .touchUpInside)
    }
    
    //MARK: - action to the next view
    @objc func actionForSignupButton() {
        let signupVC = SingupModuleAssembly.assemble()
        navigationController?.pushViewController(signupVC, animated: true)
    }
    
    //MARK: - button log in
    func setupButtonLogIn() {
        
        //constraints
        buttonLogIn.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonSignUp.snp.bottom).offset(16)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
        
        //MARK: - create action on the next view
        buttonLogIn.addTarget(self, action: #selector(actionForLogInButton), for: .touchUpInside)
    }
    
    //MARK: - action to the next view
    @objc func actionForLogInButton() {
        let loginVC = LoginModuleAssembly.assemble()
        navigationController?.pushViewController(loginVC, animated: true)
    }
    
    //MARK: - indicator activity view
    func setupIndicator() {
        
        //constraints
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().inset(-40)
        }
    }
    
    //MARK: - button later
    func setupButtonLater() {
        
        //constraints
        buttonLater.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonLogIn.snp.bottom).offset(10)
            make.bottom.equalTo(self.view.safeAreaInsets.bottom).inset(30)
            make.width.equalTo(78)
            make.height.equalTo(32)
        })
        
        //skip login or sign up
        buttonLater.addTarget(self, action: #selector(actionForButtonLater), for: .touchUpInside)
    }
    
    //MARK: - action for button later
    @objc func actionForButtonLater() {
        let viewModel = ChoosePassportViewModel()
        let chooseVC = ChoosePassportViewController(viewModel: viewModel)
        activityIndicator.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.navigationController?.pushViewController(chooseVC, animated: true)
        }
    }
}
