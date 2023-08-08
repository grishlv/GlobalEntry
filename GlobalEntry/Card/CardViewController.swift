//
//  CardViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 08.08.23.
//

import Foundation
import UIKit
import SnapKit
import Combine

final class CardViewController: UIViewController {
    
    private let viewModel: CardViewModel
    private var cancellables = Set<AnyCancellable>()
    private let destinationText: String
    private let requirementText: String

    private lazy var placeholderView: UIView = {
        let aboutView = UIView()
        aboutView.backgroundColor = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
        aboutView.layer.cornerRadius = 10
        view.addSubview(aboutView)
        return aboutView
    }()
    
    private lazy var imageMain: UIImageView = {
        let imageMain = UIImageView()
        imageMain.contentMode = .scaleAspectFill
        imageMain.layer.cornerRadius = 10
        imageMain.backgroundColor = .lightGray
        imageMain.clipsToBounds = true
        view.addSubview(imageMain)
        return imageMain
    }()
    
    private lazy var aboutView: UIView = {
        let aboutView = UIView()
        aboutView.backgroundColor = .white
        aboutView.layer.cornerRadius = 10
        view.addSubview(aboutView)
        return aboutView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = destinationText
        label.textColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        label.font = UIFont(name: "Inter-Bold", size: 22)
        aboutView.addSubview(label)
        return label
    }()
    
    private lazy var labelVisaConditions: UILabel = {
        let label = UILabel()
        label.text = "🪪 VISA CONDITIONS"
        label.textColor = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
        label.font = UIFont(name: "Inter-Bold", size: 10)
        aboutView.addSubview(label)
        return label
    }()
    
    private lazy var labelRequirement: UILabel = {
        let label = UILabel()
        label.text = requirementText
        label.textColor = UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1)
        label.font = UIFont(name: "Inter-Bold", size: 19)
        aboutView.addSubview(label)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupPlaceholerView()
        setupImageMain()
        setupAboutView()
        setupLabel()
        setupLabelVisaConditions()
        setupLabelRequirement()
        setupBindings()
        viewModel.loadImage()
    }
    
    //MARK: - setup placeholder view
    private func setupPlaceholerView() {
        
        //constraints
        placeholderView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
    }
    
    //MARK: - setup image main
    private func setupImageMain() {
        
        //constraints
        imageMain.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(170)
        }
    }
    
    //MARK: - setup about view
    private func setupAboutView() {
        
        //constraints
        aboutView.snp.makeConstraints { make in
            make.top.equalTo(imageMain.snp.bottom).inset(-30)
            make.trailing.leading.equalToSuperview().inset(20)
            make.height.equalTo(120)
        }
    }
    
    //MARK: - setup label
    private func setupLabel() {
        
        //constraints
        label.snp.makeConstraints { make in
            make.top.equalTo(aboutView.snp.top).inset(18)
            make.leading.equalTo(aboutView.snp.leading).inset(13)
        }
    }
    
    //MARK: - setup label
    private func setupLabelVisaConditions() {
        
        //constraints
        labelVisaConditions.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).inset(-13)
            make.leading.equalTo(aboutView.snp.leading).inset(13)
        }
    }
    
    //MARK: - setup label
    private func setupLabelRequirement() {
        
        //constraints
        labelRequirement.snp.makeConstraints { make in
            make.top.equalTo(labelVisaConditions.snp.bottom).inset(-3)
            make.leading.equalTo(aboutView.snp.leading).inset(13)
        }
    }
        
    init(viewModel: CardViewModel, destinationText: String, requirementText: String) {
        self.viewModel = viewModel
        self.destinationText = destinationText
        self.requirementText = requirementText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBindings() {
        viewModel.$image
            .sink { [weak self] image in
                self?.imageMain.image = image
                self?.imageMain.backgroundColor = .clear
            }
            .store(in: &cancellables)
    }
}
