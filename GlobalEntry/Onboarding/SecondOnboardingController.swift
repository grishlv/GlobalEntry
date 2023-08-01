//
//  SecondOnboardingScreen.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 24.03.23.
//

import Foundation
import UIKit
import SnapKit

final class SecondOnboardingController: UIViewController {
    
    //MARK: - left circle
    private lazy var imageViewCircleLeft: UIImageView = {
        let imageViewCircleLeft = UIImageView()
        let imageCircleLeft = UIImage(named: "firstOnboardingCircle")
        imageViewCircleLeft.image = imageCircleLeft
        view.addSubview(imageViewCircleLeft)
        return imageViewCircleLeft
    }()
    
    //MARK: - right circle
    private lazy var imageViewCircleRight: UIImageView = {
        let imageViewCircleRight = UIImageView()
        let imageCircleRight = UIImage(named: "firstOnboardingCircle")
        imageViewCircleRight.image = imageCircleRight
        view.addSubview(imageViewCircleRight)
        return imageViewCircleRight
    }()
    
    //MARK: - main image
    private lazy var imageViewMain: UIImageView = {
        let imageViewMain = UIImageView()
        let imageMain = UIImage(named: "secondOnboardingImageMain")
        imageViewMain.layer.cornerRadius = 105
        imageViewMain.layer.masksToBounds = true
        imageViewMain.image = imageMain
        view.addSubview(imageViewMain)
        return imageViewMain
    }()
    
    //MARK: - right image
    private lazy var imageViewRight: UIImageView = {
        let imageViewRight = UIImageView()
        let imageRight = UIImage(named: "secondOnboardingImageRight")
        imageViewRight.layer.cornerRadius = 30
        imageViewRight.layer.masksToBounds = true
        imageViewRight.image = imageRight
        view.addSubview(imageViewRight)
        return imageViewRight
    }()
    
    //MARK: - left image
    private lazy var imageViewLeft: UIImageView = {
        let imageViewLeft = UIImageView()
        let imageLeft = UIImage(named: "secondOnboardingImageLeft")
        imageViewLeft.layer.cornerRadius = 15
        imageViewLeft.layer.masksToBounds = true
        imageViewLeft.image = imageLeft
        view.addSubview(imageViewLeft)
        return imageViewLeft
    }()
    
    //MARK: - view border to left image
    private lazy var imageLeftBorder: UIView = {
        let imageLeftBorder = UIView()
        imageLeftBorder.layer.cornerRadius = 20
        imageLeftBorder.layer.borderWidth = 2
        imageLeftBorder.layer.borderColor = CGColor(red: 69/255, green: 116/255, blue: 86/255, alpha: 1)
        imageLeftBorder.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0)
        view.addSubview(imageLeftBorder)
        return imageLeftBorder
    }()
    
    //MARK: - shape star
    private lazy var imageViewStar: UIImageView = {
        let imageViewStar = UIImageView()
        let imageStar = UIImage(named: "secondOnboardingStar")
        imageViewStar.image = imageStar
        view.addSubview(imageViewStar)
        return imageViewStar
    }()
    
    //MARK: - header label
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Useful information about the country in a short form"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 2
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - swipe line first
    private lazy var viewLineFirst: UIView = {
        let viewLineFirst = UIView()
        viewLineFirst.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        viewLineFirst.layer.cornerRadius = 3
        view.addSubview(viewLineFirst)
        return viewLineFirst
    }()
    
    //MARK: - swipe line second
    private lazy var viewLineSecond: UIView = {
        let viewLineSecond = UIView()
        viewLineSecond.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        viewLineSecond.layer.cornerRadius = 3
        view.addSubview(viewLineSecond)
        return viewLineSecond
    }()
    
    //MARK: - swipe line third
    private lazy var viewLineThird: UIView = {
        let viewLineThird = UIView()
        viewLineThird.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        viewLineThird.layer.cornerRadius = 3
        view.addSubview(viewLineThird)
        return viewLineThird
    }()
    
    //MARK: - button next
    private lazy var buttonNext: UIButton = {
        let buttonNext = UIButton()
        buttonNext.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        buttonNext.setImage(UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)), for: .normal)
        buttonNext.tintColor = .white
        buttonNext.layer.cornerRadius = 10
        view.addSubview(buttonNext)
        return buttonNext
    }()
    
    //MARK: - button skip
    private lazy var buttonSkip: UIButton = {
        let buttonSkip = UIButton()
        buttonSkip.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        buttonSkip.setTitle("Skip", for: .normal)
        buttonSkip.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        buttonSkip.titleLabel?.textAlignment = .left
        buttonSkip.setTitleColor(UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1), for: .normal)
        view.addSubview(buttonSkip)
        return buttonSkip
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        navigationItem.setHidesBackButton(true, animated: true)
        view.clipsToBounds = true
        
        setupSwipeByGestureForward()
        setupSwipeByGestureBack()
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
    
    //MARK: - go forward by gesture recognizer
    func setupSwipeByGestureForward() {
        let goForward = UISwipeGestureRecognizer(target: self, action: #selector(swipeFuncForward(gesture:)))
        goForward.direction = .left
        view.addGestureRecognizer(goForward)
    }
    
    @objc func swipeFuncForward(gesture: UISwipeGestureRecognizer) {
        let thirdOnboardingVC = ThirdOnboardingController()
        navigationController?.pushViewController(thirdOnboardingVC, animated: true)
    }
    
    //MARK: - go back by gesture recognizer
    func setupSwipeByGestureBack() {
        let goBack = UISwipeGestureRecognizer(target: self, action: #selector(swipeFuncBack(gesture:)))
        goBack.direction = .right
        view.addGestureRecognizer(goBack)
    }
    
    @objc func swipeFuncBack(gesture: UISwipeGestureRecognizer) {
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - circle left
    func setupCircleLeft() {
        //constraints
        imageViewCircleLeft.snp.makeConstraints( { make in
            make.leading.equalToSuperview().inset(-130)
            make.centerY.equalToSuperview().offset(-70)
            make.size.equalTo(320)
        })
    }
    
    //MARK: - circle right
    func setupCircleRight() {
        //constraints
        imageViewCircleRight.snp.makeConstraints( { make in
            make.leading.equalToSuperview().offset(135)
            make.centerY.equalToSuperview().offset(-120)
            make.size.equalTo(340)
        })
    }
    
    //MARK: - image main
    func setupImageMain() {
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
        //constraints
        imageViewRight.snp.makeConstraints( { make in
            make.leading.equalTo(imageViewMain.snp.trailing).offset(0)
            make.bottom.equalTo(imageViewMain.snp.bottom).offset(30)
            make.width.height.equalTo(60)
        })
    }
    
    //MARK: - image left
    func setupImageLeft() {
                //constraints for left image
        imageViewLeft.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.leading).offset(-30)
            make.top.equalTo(imageViewMain.snp.top).offset(12)
            make.width.height.equalTo(30)
        })
        
        //constraints for left border
        imageLeftBorder.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.leading).offset(-25)
            make.top.equalTo(imageViewMain.snp.top).offset(7)
            make.width.height.equalTo(40)
        })
    }
    
    //MARK: - shape star
    func setupImageStar() {
        //constraints
        imageViewStar.snp.makeConstraints( { make in
            make.trailing.equalTo(imageViewMain.snp.trailing).offset(50)
            make.top.equalTo(imageViewMain.snp.top).inset(0)
            make.width.height.equalTo(117)
        })
    }
    
    //MARK: - label header
    func setupLabelHeader() {
        
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
        
        //constraints for the first line
        viewLineFirst.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })
        
        //constraints to the second current line
        viewLineSecond.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(46)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })
        
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
        
        //constraints
        buttonNext.snp.makeConstraints({ make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalTo(labelHeader.snp.bottom).offset(28)
            make.width.equalTo(60)
            make.height.equalTo(60)
        })
        
        //MARK: - create action on the next view
        buttonNext.addTarget(self, action: #selector(actionForButtonNext), for: .touchUpInside)
    }
    
    //MARK: - action button to the next view
    @objc func actionForButtonNext() {
        let thirdOnboardingVC = ThirdOnboardingController()
        navigationController?.pushViewController(thirdOnboardingVC, animated: true)
    }
    
    //MARK: - button skip
    func setupButtonSkip() {
        
        //constraints
        buttonSkip.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(viewLineFirst.snp.bottom).offset(12)
            make.width.equalTo(30)
            make.height.equalTo(20)
        })
        
        //MARK: - create action on the welcome view controller
        buttonSkip.addTarget(self, action: #selector(actionForButtonSkip), for: .touchUpInside)
    }
    
    //MARK: - action to the next view
    @objc func actionForButtonSkip() {
        let chooseVC = ChoosePassportViewController(viewModel: ChoosePassportViewModel(), tabBar: TabController())
        self.navigationController?.pushViewController(chooseVC, animated: true)
        UserDefaultsManager.shared.isWelcomeScreenShown = true
    }
}

