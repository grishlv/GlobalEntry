//
//  SecondOnboardingScreen.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 24.03.23.
//

import Foundation
import UIKit
import SnapKit

class SecondOnboardingController: UIViewController {

    //MARK: - left circle
    private let imageViewCircleLeft = UIImageView()
    private let imageCircleLeft = UIImage(named: "firstOnboardingCircle")
    
    //MARK: - right circle
    private let imageViewCircleRight = UIImageView()
    private let imageCircleRight = UIImage(named: "firstOnboardingCircle")
    
    //MARK: - main image
    private let imageViewMain = UIImageView()
    private let imageMain = UIImage(named: "secondOnboardingImageMain")
    
    //MARK: - right image
    private let imageViewRight = UIImageView()
    private let imageRight = UIImage(named: "secondOnboardingImageRight")
    
    //MARK: - left image
    private let imageViewLeft = UIImageView()
    private let imageLeft = UIImage(named: "secondOnboardingImageLeft")
    
    //MARK: - view border to left image
    private let imageLeftBorder = UIView()

    //MARK: - shape star
    private let imageViewStar = UIImageView()
    private let imageStar = UIImage(named: "secondOnboardingStar")

    
    //MARK: - header label
    private let labelHeader = UILabel()
    
    //MARK: - swipe lines
    private let viewLineFirst = UIView()
    private let viewLineSecond = UIView()
    private let viewLineThird = UIView()

    //MARK: - button next
    private let buttonNext = UIButton()
    
    //MARK: - button skip
    private let buttonSkip = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        view.clipsToBounds = true

        setupCircleLeft()
        setupCircleRight()
        setupImageMain()
        setupImageRight()
        setupImageLeft()
        setupImageStar()
        setupLabelHeader()
        setupSwipeLines()
        setupButtonNext()
        setupButtonSkip()
    }
    
    //MARK: - circle left
    func setupCircleLeft() {

        imageViewCircleLeft.image = imageCircleLeft
        view.addSubview(imageViewCircleLeft)
        
        //constraints
        imageViewCircleLeft.snp.makeConstraints( { make in
            make.leading.equalToSuperview().inset(-130)
            make.centerY.equalToSuperview().offset(-70)
            make.size.equalTo(320)
        })
    }
    
    //MARK: - circle right
    func setupCircleRight() {
        
        imageViewCircleRight.image = imageCircleRight
        view.addSubview(imageViewCircleRight)
        
        //constraints
        imageViewCircleRight.snp.makeConstraints( { make in
            make.leading.equalToSuperview().offset(135)
            make.centerY.equalToSuperview().offset(-120)
            make.size.equalTo(340)
        })
    }
    
    //MARK: - image main
    func setupImageMain() {

        imageViewMain.layer.cornerRadius = 105
        imageViewMain.layer.masksToBounds = true
        imageViewMain.image = imageMain
        view.addSubview(imageViewMain)
        
        //constraints
        imageViewMain.snp.makeConstraints( { make in
            make.centerX.equalToSuperview().inset(82)
            make.centerY.equalToSuperview().offset(-65)
            make.width.equalTo(210)
            make.height.equalTo(370)
        })
    }
    
    //MARK: - image right
    func setupImageRight() {
        
        imageViewRight.layer.cornerRadius = 30
        imageViewRight.layer.masksToBounds = true
        imageViewRight.image = imageRight
        view.addSubview(imageViewRight)
        
        //constraints
        imageViewRight.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewMain.snp.trailing).offset(0)
            make.bottom.equalTo(imageViewMain.snp.bottom).offset(30)
            make.width.height.equalTo(60)
        })
    }
    
    //MARK: - image left
    func setupImageLeft() {
        
        //image left
        imageViewLeft.layer.cornerRadius = 15
        imageViewLeft.layer.masksToBounds = true
        imageViewLeft.image = imageLeft
        view.addSubview(imageViewLeft)
        
        //constraints for left image
        imageViewLeft.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.leading).offset(-30)
            make.top.equalTo(imageViewMain.snp.top).offset(12)
            make.width.height.equalTo(30)
        })
        
        //image left border
        imageLeftBorder.layer.cornerRadius = 20
        imageLeftBorder.layer.borderWidth = 2
        imageLeftBorder.layer.borderColor = CGColor(red: 69/255, green: 116/255, blue: 86/255, alpha: 1)
        imageLeftBorder.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        view.addSubview(imageLeftBorder)
        
        //constraints for left border
        imageLeftBorder.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.leading).offset(-25)
            make.top.equalTo(imageViewMain.snp.top).offset(7)
            make.width.height.equalTo(40)
        })
    }
    
    //MARK: - shape star
    func setupImageStar() {

        imageViewStar.image = imageStar
        view.addSubview(imageViewStar)
        
        //constraints
        imageViewStar.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.trailing).offset(50)
            make.top.equalTo(imageViewMain.snp.top).inset(0)
            make.width.height.equalTo(117)
        })
    }
    
    //MARK: - label header
    func setupLabelHeader() {
        
        labelHeader.text = "Useful information about the country in a short form"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 2
        view.addSubview(labelHeader)
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.greaterThanOrEqualTo(imageViewMain.snp.bottom).offset(48)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(350)
            make.height.equalTo(65)
        })
    }
    
    //MARK: - view swipe lines
    func setupSwipeLines() {
        
        //first line
        viewLineFirst.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        viewLineFirst.layer.cornerRadius = 3
        view.addSubview(viewLineFirst)
        
        //constraints for the first line
        viewLineFirst.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })
        
        //second line
        viewLineSecond.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        viewLineSecond.layer.cornerRadius = 3
        view.addSubview(viewLineSecond)
        
        //constraints to the second current line
        viewLineSecond.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(46)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })

        //third line
        viewLineThird.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        viewLineThird.layer.cornerRadius = 3
        view.addSubview(viewLineThird)
        
        //constraints to the third line
        viewLineThird.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(72)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })
    }

    //MARK: - button next
    func setupButtonNext() {

        buttonNext.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonNext.setImage(UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)), for: .normal)
        buttonNext.tintColor = .white
        buttonNext.layer.cornerRadius = 10
        view.addSubview(buttonNext)
        
        //constraints
        buttonNext.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(labelHeader.snp.bottom).offset(28)
            make.width.equalTo(60)
            make.height.equalTo(60)
        })
        
        //create action on the next view 
        buttonNext.addTarget(self, action: #selector(actionForButtonNext), for: .touchUpInside)
    }
    
    //MARK: - action button to the next view
    @objc func actionForButtonNext() {
        let thirdOnboardingVC = storyboard?.instantiateViewController(withIdentifier: "ThirdOnboardingController") as! ThirdOnboardingController
        navigationController?.pushViewController(thirdOnboardingVC, animated: true)
    }

    //MARK: - button skip
    func setupButtonSkip() {
        
        buttonSkip.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        buttonSkip.setTitle("Skip", for: .normal)
        buttonSkip.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        buttonSkip.titleLabel?.textAlignment = .left
        buttonSkip.setTitleColor(UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1), for: .normal)
        view.addSubview(buttonSkip)

        //constraints
        buttonSkip.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(viewLineFirst.snp.bottom).offset(12)
            make.width.equalTo(30)
            make.height.equalTo(20)
        })
    }
}
