//
//  WelcomeViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 24.03.23.
//

import Foundation
import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    //MARK: - image group of circles
    private let imageViewGroupOfCirles = UIImageView()
    private let imageGroupOfCircles = UIImage(named: "groupOfCircles")
    
    //MARK: - top image
    private let imageViewTop = UIImageView()
    private let imageTop = UIImage(named: "welcomeImageTop")
    
    //MARK: - right image
    private let imageViewRight = UIImageView()
    private let imageRight = UIImage(named: "welcomeImageRight")
    
    //MARK: - bottom image
    private let imageViewBottom = UIImageView()
    private let imageBottom = UIImage(named: "welcomeImageBottom")
    
    //MARK: - header label
    private let labelHeader = UILabel()
    
    //MARK: - description label
    private let labelDescription = UILabel()
    
    //MARK: - sign up button
    private let buttonSignUp = UIButton()
    
    //MARK: - log in button
    private let buttonLogIn = UIButton()

    //MARK: - later button
    private let buttonLater = UIButton()

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
        setupButtonLater()
    }
    
    //MARK: - group of circles on the background
    func setupGroupOfCircle() {
        
        imageViewGroupOfCirles.image = imageGroupOfCircles
        view.addSubview(imageViewGroupOfCirles)
        
        //constraints
        imageViewGroupOfCirles.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.greaterThanOrEqualToSuperview().offset(55)
            make.size.equalTo(335)
        })
    }
    
    //MARK: - image top
    func setupImageTop() {
        
        imageViewTop.image = imageTop
        imageViewTop.layer.cornerRadius = 21
        imageViewTop.layer.masksToBounds = true
        view.addSubview(imageViewTop)
        
        //constraints
        imageViewTop.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCirles.snp.leading).inset(45)
            make.top.equalTo(imageViewGroupOfCirles.snp.top).inset(51)
            make.size.equalTo(42)
        })
    }

    //MARK: - image right
    func setupImageRight() {
        
        imageViewRight.image = imageRight
        imageViewRight.layer.cornerRadius = 16
        imageViewRight.layer.masksToBounds = true
        view.addSubview(imageViewRight)
        
        //constraints
        imageViewRight.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewGroupOfCirles.snp.trailing).inset(-6)
            make.bottom.equalTo(imageViewGroupOfCirles.snp.bottom).inset(88)
            make.size.equalTo(32)
        })
    }
    
    //MARK: - image bottom
    func setupImageBottom() {
        
        imageViewBottom.image = imageBottom
        imageViewBottom.layer.cornerRadius = 35
        imageViewBottom.layer.masksToBounds = true
        view.addSubview(imageViewBottom)
        
        //constraints
        imageViewBottom.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCirles.snp.leading).inset(80)
            make.bottom.equalTo(imageViewGroupOfCirles.snp.bottom).inset(-10)
            make.size.equalTo(70)
        })
    }
    
    //MARK: - label header
    func setupLabelHeader() {
        
        labelHeader.text = "Welcome!"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        
        //constraints
        labelHeader.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCirles.snp.leading)
            make.top.greaterThanOrEqualTo(imageViewGroupOfCirles.snp.bottom).offset(32)
            make.width.equalTo(130)
            make.height.equalTo(32)
        })
    }
    
    //MARK: - label description
    func setupLabelDescription() {
        
        labelDescription.text = "Let's stay in touch! Please sign up or log in to account."
        labelDescription.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        labelDescription.font = UIFont(name: "Inter-Regular", size: 14)
        labelDescription.numberOfLines = 2
        view.addSubview(labelDescription)
        
        //constraints
        labelDescription.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewGroupOfCirles.snp.leading)
            make.top.equalTo(labelHeader.snp.bottom).offset(2)
            make.width.equalTo(292)
            make.height.equalTo(34)
        })
    }
    
    //MARK: - button sign up
    func setupButtonSignUp() {
        
        buttonSignUp.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonSignUp.layer.cornerRadius = 10
        buttonSignUp.setTitle("Sign up", for: .normal)
        buttonSignUp.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        view.addSubview(buttonSignUp)
        
        //constraints
        buttonSignUp.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelDescription.snp.bottom).offset(26)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - button log in
    func setupButtonLogIn() {
        
        buttonLogIn.backgroundColor = UIColor(red: 229/255, green: 239/255, blue: 251/255, alpha: 1)
        buttonLogIn.layer.cornerRadius = 10
        buttonLogIn.setTitle("Log in", for: .normal)
        buttonLogIn.titleLabel?.font = UIFont(name: "Inter-SemiBold", size: 14)
        buttonLogIn.setTitleColor(UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1), for: .normal)
        view.addSubview(buttonLogIn)
        
        //constraints
        buttonLogIn.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonSignUp.snp.bottom).offset(16)
            make.width.equalTo(335)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - button later
    func setupButtonLater() {
        
        buttonLater.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        buttonLater.layer.cornerRadius = 10
        buttonLater.setTitle("Later", for: .normal)
        buttonLater.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        buttonLater.setTitleColor(UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1), for: .normal)
        view.addSubview(buttonLater)
 
        //constraints
        buttonLater.snp.makeConstraints( { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(buttonLogIn.snp.bottom).offset(10)
            make.bottom.greaterThanOrEqualToSuperview().inset(44)
            make.width.equalTo(78)
            make.height.equalTo(32)
        })
    }
}
