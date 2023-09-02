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
    private let englishSkills: String
    
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
        label.font = UIFont(name: "Inter-Bold", size: 24)
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
        label.font = UIFont(name: "Inter-Bold", size: 17)
        aboutView.addSubview(label)
        return label
    }()
    
    private lazy var englishSkillsView: UIView = {
        let englishSkillsView = UIView()
        englishSkillsView.backgroundColor = .white
        englishSkillsView.layer.cornerRadius = 10
        view.addSubview(englishSkillsView)
        return englishSkillsView
    }()
    
    private lazy var englishLevelsImage: UIImageView = {
        let englishLevelsImage = UIImageView()
        englishLevelsImage.image = UIImage(named: "englishLevels")
        englishSkillsView.addSubview(englishLevelsImage)
        return englishLevelsImage
    }()
    
    private lazy var labelSkills: UILabel = {
        let labelSkills = UILabel()
        labelSkills.text = "English skills"
        labelSkills.textColor = UIColor(red: 44/255, green: 44/255, blue: 44/255, alpha: 1)
        labelSkills.font = UIFont(name: "Inter-Bold", size: 22)
        englishSkillsView.addSubview(labelSkills)
        return labelSkills
    }()
    
    private lazy var labelProficiency: UILabel = {
        let labelProficiency = UILabel()
        let proficiencyAttributes = getProficiencyAttributes(from: englishSkills)
        labelProficiency.text = proficiencyAttributes.text
        labelProficiency.textColor = proficiencyAttributes.color
        labelProficiency.font = UIFont(name: "Inter-Bold", size: 14)
        englishSkillsView.addSubview(labelProficiency)
        return labelProficiency
    }()
    
    private lazy var labelRanking: UILabel = {
        let labelRanking = UILabel()
        labelRanking.text = "Global ranking:"
        labelRanking.textColor = UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1)
        labelRanking.font = UIFont(name: "Inter-Medium", size: 12)
        englishSkillsView.addSubview(labelRanking)
        return labelRanking
    }()
    
    private lazy var labelRankingNumber: UILabel = {
        let labelRankingNumber = UILabel()
        labelRankingNumber.text = "\(englishSkills)/111"
        labelRankingNumber.textColor = UIColor(red: 99/255, green: 99/255, blue: 102/255, alpha: 1)
        labelRankingNumber.font = UIFont(name: "Inter-Bold", size: 12)
        englishSkillsView.addSubview(labelRankingNumber)
        return labelRankingNumber
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
        setupEnglishSkillsView()
        setupEnglishLevelsImage()
        setupLabelEnglish()
        setupLabelProficiency()
        setupLabelRanking()
        setupLabelRankingNumber()
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
            make.leading.equalTo(aboutView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label
    private func setupLabelVisaConditions() {
        
        //constraints
        labelVisaConditions.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).inset(-15)
            make.leading.equalTo(aboutView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label
    private func setupLabelRequirement() {
        
        //constraints
        labelRequirement.snp.makeConstraints { make in
            make.top.equalTo(labelVisaConditions.snp.bottom).inset(-3)
            make.leading.equalTo(aboutView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup english skills view
    private func setupEnglishSkillsView() {
        
        //constraints
        englishSkillsView.snp.makeConstraints { make in
            make.top.equalTo(aboutView.snp.bottom).inset(-16)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(180)
            make.height.equalTo(120)
        }
    }
    
    //MARK: - setup english levels image
    private func setupEnglishLevelsImage() {
        
        //constraints
        englishLevelsImage.snp.makeConstraints { make in
            make.top.equalTo(englishSkillsView.snp.top).inset(14)
            make.leading.equalTo(englishSkillsView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label english
    private func setupLabelEnglish() {
       
        //constraints
        labelSkills.snp.makeConstraints { make in
            make.top.equalTo(englishLevelsImage.snp.bottom).inset(-10)
            make.leading.equalTo(englishSkillsView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label proficiency
    private func setupLabelProficiency() {
       
        //constraints
        labelProficiency.snp.makeConstraints { make in
            make.top.equalTo(labelSkills.snp.bottom).inset(-4)
            make.leading.equalTo(englishSkillsView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label ranking
    private func setupLabelRanking() {
       
        //constraints
        labelRanking.snp.makeConstraints { make in
            make.top.equalTo(labelProficiency.snp.bottom).inset(-16)
            make.leading.equalTo(englishSkillsView.snp.leading).inset(12)
        }
    }
    
    //MARK: - setup label ranking number
    private func setupLabelRankingNumber() {
       
        //constraints
        labelRankingNumber.snp.makeConstraints { make in
            make.top.equalTo(labelProficiency.snp.bottom).inset(-16)
            make.leading.equalTo(labelRanking.snp.trailing).inset(-2)
        }
    }
    
    init(viewModel: CardViewModel, destinationText: String, requirementText: String, englishSkills: String) {
        self.viewModel = viewModel
        self.destinationText = destinationText
        self.requirementText = requirementText
        self.englishSkills = englishSkills
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
    
    func getProficiencyAttributes(from scoreString: String) -> (text: String, color: UIColor) {
        guard let score = Int(scoreString) else { return ("Unknown proficiency", UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1)) }

        switch score {
        case 1...13:
            return ("Very high proficiency", UIColor(red: 69/255, green: 119/255, blue: 168/255, alpha: 1))
        case 14...31:
            return ("High proficiency", UIColor(red: 111/255, green: 130/255, blue: 125/255, alpha: 1))
        case 32...60:
            return ("Moderate proficiency", UIColor(red: 171/255, green: 183/255, blue: 150/255, alpha: 1))
        case 61...87:
            return ("Low Proficiency", UIColor(red: 221/255, green: 203/255, blue: 133/255, alpha: 1))
        case 88...111:
            return ("Very low proficiency", UIColor(red: 206/255, green: 138/255, blue: 102/255, alpha: 1))
        default:
            return ("Unknown proficiency", UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1))
        }
    }
}
