//
//  ViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 22.03.23.
//

import Foundation
import UIKit
import SnapKit

final class FirstOnboardingController: UIViewController {
    
    //MARK: - left circle
    private lazy var imageViewCircleLeft: UIImageView = {
        let imageCircleLeft = UIImage(named: "firstOnboardingCircle")
        let imageViewCircleLeft = UIImageView()
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
        let imageMain = UIImage(named: "firstOnboardingImage")
        imageViewMain.image = imageMain
        view.addSubview(imageViewMain)
        return imageViewMain
    }()
    
    //MARK: - header label
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Quick search for entry conditions in all countries"
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.font = UIFont(name: "Inter-Bold", size: 26)
        labelHeader.numberOfLines = 2
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - swipe lines
    //MARK: - line first
    private lazy var viewLineFirst: UIView = {
        let viewLineFirst = UIView()
        viewLineFirst.backgroundColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        viewLineFirst.layer.cornerRadius = 3
        view.addSubview(viewLineFirst)
        return viewLineFirst
    }()
    
    //MARK: - line second
    private lazy var viewLineSecond: UIView = {
        let viewLineSecond = UIView()
        viewLineSecond.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        viewLineSecond.layer.cornerRadius = 3
        view.addSubview(viewLineSecond)
        return viewLineSecond
    }()
    
    //MARK: - line third
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
        
        setupSwipeByGesture()
        setupCircleLeft()
        setupCircleRight()
        setupImageMain()
        setupLabelHeader()
        setupSwipeLines()
        setupButtonNext()
        setupButtonSkip()
    }
    
    //MARK: - go forward by gesture recognizer
    func setupSwipeByGesture() {
        let goForward = UISwipeGestureRecognizer(target: self, action: #selector(swipeFunc(gesture:)))
        goForward.direction = .left
        view.addGestureRecognizer(goForward)
    }
    
    @objc func swipeFunc(gesture: UISwipeGestureRecognizer) {
        let secondOnboardingVC = SecondOnboardingController()
        navigationController?.pushViewController(secondOnboardingVC, animated: true)
    }
    
    //MARK: - circle left
    func setupCircleLeft() {
        
        //constraints
        imageViewCircleLeft.snp.makeConstraints( { make in
            make.leading.equalToSuperview().inset(-130)
            make.centerY.equalToSuperview().offset(-70)
            make.size.equalTo(410)
        })
    }
    
    //MARK: - circle right
    func setupCircleRight() {
        
        //constraints
        imageViewCircleRight.snp.makeConstraints( { make in
            make.leading.equalToSuperview().offset(185)
            make.centerY.equalToSuperview().offset(-100)
            make.size.equalTo(340)
        })
    }
    
    //MARK: - image main
    func setupImageMain() {
        
        //constraints
        imageViewMain.snp.makeConstraints( { make in
            make.centerX.equalToSuperview().inset(40)
            make.centerY.equalToSuperview().offset(-80)
            make.height.equalTo(395)
            make.width.equalTo(290)
        })
    }
    
    //MARK: - label header
    func setupLabelHeader() {
        
        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.greaterThanOrEqualTo(imageViewMain.snp.bottom).offset(48)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(335)
            make.height.equalTo(65)
        })
    }
    
    //MARK: - view swipe lines
    func setupSwipeLines() {
        
        //constraints to the first line
        viewLineFirst.snp.makeConstraints({ make in
            make.leading.equalToSuperview().inset(20)
            make.top.equalTo(labelHeader.snp.bottom).offset(40)
            make.bottom.greaterThanOrEqualToSuperview().inset(100)
            make.width.equalTo(22)
            make.height.equalTo(6)
        })
        
        //constraints to the second line
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
    
    //MARK: - action to the next view
    @objc func actionForButtonNext() {
        let secondOnboardingVC = SecondOnboardingController()
        navigationController?.pushViewController(secondOnboardingVC, animated: true)
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
        let welcomeVC = WelcomeViewController()
        navigationController?.pushViewController(welcomeVC, animated: true)
    }
}
