//
//  MainScreenViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 25.06.23.
//
import Foundation
import UIKit
import SnapKit
import RealmSwift

final class MainScreenViewController: UIViewController, UISearchBarDelegate, ChoosePassportViewModelDelegate {
    
    var labelCountry: String?
    var features: [Feature] = []
    private var viewModel: ChoosePassportViewModel = ChoosePassportViewModel()
    
    let countryImages = ["afghanistan", "albania", "algeria", "andorra", "angola", "antiguaAndBarbuda", "argentina", "armenia", "australia", "austria", "azerbaijan", "bahamas", "bahrain", "bangladesh", "barbados", "belarus", "belgium", "belize", "benin", "bhutan", "bolivia", "bosniaAndHerzegovina", "botswana", "brazil", "brunei", "bulgaria", "burkinaFaso", "burundi", "cambodia", "cameroon", "canada", "capeVerde", "centralAfricanRepublic", "chad", "chile", "china", "colombia", "comoros", "congo", "costaRica", "croatia", "cuba", "cyprus", "czechRepublic", "democraticCongo", "denmark", "djibouti", "dominica", "dominicanRepublic", "ecuador", "egypt", "elSalvador", "equatorialGuinea", "eritrea", "estonia", "ethiopia", "fiji", "finland", "france", "gabon", "gambia", "georgia", "germany", "ghana", "greece", "grenada", "guatemala", "guineaBissau", "guineaNext", "guyana", "haiti", "honduras", "hongKong", "hungary", "iceland", "india", "indonesia", "iran", "iraq", "ireland", "israel", "italy", "ivoryCoast", "jamaica", "japan", "jordan", "kazakhstan", "kenya", "kiribati", "kosovo", "kuwait", "kyrgyzstan", "laos", "latvia", "lebanon", "lesotho", "liberia", "libya", "liechtenstein", "lithuania", "luxembourg", "macao", "madagascar", "malawi", "malaysia", "maldives", "mali", "malta", "marshallIslands", "mauritania", "mauritius", "mexico", "mirconesia", "moldova", "monaco", "mongolia", "montenegro", "morocco", "mozambique", "myanmar", "namibia", "nauru", "nepal", "netherlands", "newZealand", "nicaragua", "niger", "nigeria", "northKorea", "northMacedonia", "norway", "oman", "pakistan", "palau", "palestine", "panama", "papuaNewGuinea", "paraguay", "peru", "philippines", "poland", "portugal", "qatar", "romania", "russia", "rwanda", "saintKittsAndNevis", "saintLucia", "saintVincentAndTheGrenadines", "samoa", "sanMarino", "saoTomeAndPrincipe", "saudiArabia", "senegal", "serbia", "seychelles", "sierraLeone", "singapore", "slovakia", "slovenia", "solomonIslands", "somalia", "southAfrica", "southKorea", "southSudan", "spain", "sriLanka", "sudan", "suriname", "swaziland", "sweden", "switzerland", "syria", "taiwan", "tajikistan", "tanzania", "thailand", "timor-leste", "togo", "tonga", "trinidadAndTobago", "tunisia", "turkey", "turkmenistan", "tuvalu", "uganda", "ukraine", "unitedArabEmirates", "unitedKingdom", "unitedStates", "uruguay", "uzbekistan", "vanuatu", "vatican", "venezuela", "vietnam", "yemen", "zambia", "zimbabwe"]
    
    //MARK: - label header
    private lazy var labelHeader: UILabel = {
        let labelHeader = UILabel()
        labelHeader.text = "Your country list"
        labelHeader.font = UIFont(name: "Inter-Bold", size: 30)
        labelHeader.textColor = UIColor(red: 44/255, green: 44/255, blue: 46/255, alpha: 1)
        labelHeader.numberOfLines = 1
        view.addSubview(labelHeader)
        return labelHeader
    }()
    
    //MARK: - search bar
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        //custom UI
        setupCustomSearchBar(searchBar)
        
        searchBar.barTintColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        searchBar.searchTextField.backgroundColor = UIColor(red: 238/255, green: 239/255, blue: 244/255, alpha: 1)
        searchBar.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
        searchBar.backgroundImage = UIImage()
        searchBar.setImage(UIImage(named: "ic_clear"), for: .clear, state: .normal)
        searchBar.delegate = self
        view.addSubview(searchBar)
        return searchBar
    }()
    
    //MARK: - table view
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.sectionHeaderTopPadding = 0
        tableView.rowHeight = 110.0
        tableView.keyboardDismissMode = .onDrag
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLabelHeader()
        setupSearchBar()
        setupTableView()
        searchBar(searchBar, textDidChange: "")
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        viewModel.delegate = self
        viewModel.fetchData()
    }
    
    //MARK: - setup label header
    private func setupLabelHeader() {

        //constraints
        labelHeader.snp.makeConstraints({ make in
            make.top.equalToSuperview().inset(75)
            make.leading.equalToSuperview().inset(20)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup search bar
    private func setupSearchBar() {
        
        //constraints
        searchBar.snp.makeConstraints({ make in
            make.top.equalTo(labelHeader.snp.bottom).inset(-16)
            make.leading.trailing.equalToSuperview().inset(10)
            make.width.equalTo(345)
            make.height.equalTo(48)
        })
    }
    
    //MARK: - setup table view
    private func setupTableView() {
        
        //constraints
        tableView.snp.makeConstraints({ make in
            make.top.equalTo(searchBar.safeAreaLayoutGuide.snp.bottomMargin)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        })
    }
    
    init(features: [Feature]) {
        self.features = features
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didSelectCountry(_ passportName: String) {
        // Filter the features based on the selected passport
        let selectedCountry = viewModel.passports?.filter("passport == %@", passportName).first
        features = Array(selectedCountry?.features ?? List<Feature>())
        
        // Reload the table view with the filtered features
        tableView.reloadData()
    }
}

extension MainScreenViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return features.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.performSearch(with: searchText)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = view.backgroundColor
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let feature = features[indexPath.section]
        let image = UIImage(named: countryImages[indexPath.section])
        
        cell.textLabel?.text = "\(feature.destination): \(feature.requirement)"
        cell.imageView?.image = image
        cell.imageView?.sizeToFit()
        cell.imageView?.translatesAutoresizingMaskIntoConstraints = false
        cell.imageView?.clipsToBounds = true
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .black
        cell.textLabel?.font = UIFont(name: "Inter-Medium", size: 18)
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 1
        cell.layer.borderColor = CGColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let feature = features[section]
        return feature.destination
    }
}

//MARK: - setup custom UI to search bar
extension MainScreenViewController {

    func setupCustomSearchBar(_ searchBar: UISearchBar) {
        //setup custom UI
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {

            //setup color to search icon
            if let leftView = textfield.leftView as? UIImageView {
                leftView.image = leftView.image?.withRenderingMode(.alwaysTemplate)
                leftView.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
            }

            //setup color to clear button
            if let clearButton = textfield.value(forKey: "clearButton") as? UIButton {
                clearButton.setImage(clearButton.currentImage?.withRenderingMode(.alwaysTemplate), for: .normal)
                clearButton.tintColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 0.5)
            }

            //setup color and font conf to text
            let attributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1),
                .font: UIFont(name: "Inter-Medium", size: 16) ?? 0
            ]
            textfield.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
            textfield.textColor = UIColor(red: 110/255, green: 114/255, blue: 123/255, alpha: 1)
        }
    }
}

//MARK: - hide keyboard on tap everywhere
extension MainScreenViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(ChoosePassportViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
