//
//  OnboardingViewController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 04.09.23.
//

import Foundation
import UIKit
import SnapKit

final class OnboardingViewController: UIViewController {
    
    private let presenter: OnboardingPresenter
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = presenter.numberOfItems()
        control.currentPageIndicatorTintColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1)
        control.pageIndicatorTintColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1)
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 43/255, green: 125/255, blue: 246/255, alpha: 1)
        button.setImage(UIImage(systemName: "chevron.forward", withConfiguration: UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)), for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = UIFont(name: "Inter-Medium", size: 14)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor(red: 174/255, green: 174/255, blue: 178/255, alpha: 1), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        
        setupView()
        setupConstraints()
        callView()
    }
    
    private func setupView() {
        view.addSubview(pageViewController.view)
        view.addSubview(pageControl)
        view.addSubview(nextButton)
        view.addSubview(skipButton)
        addChild(pageViewController)
        pageViewController.delegate = self
        pageViewController.dataSource = self
    }
    
    private func setupConstraints() {
        pageViewController.view.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageControl)
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        skipButton.snp.makeConstraints { make in
            make.centerY.equalTo(pageControl)
            make.leading.equalToSuperview().inset(20)
        }
    }
    
    func viewControllerTest(at index: Int) -> UIViewController? {
        if index >= 0 && index < presenter.numberOfItems() {
            let onboardingView = OnboardingView()
            onboardingView.configure(with: presenter.getOnboardingItems()[index])
            onboardingView.tag = index
            return UIViewController().withView(onboardingView)
        }
        return nil
    }
    
    func callView() {
        if let firstVC = viewControllerTest(at: 0) {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
    }
    
    // Button action methods
    @objc private func nextButtonTapped() {
        let currentIndex = pageControl.currentPage
        if currentIndex < presenter.numberOfItems() - 1 {
            if let nextVC = viewControllerTest(at: currentIndex + 1) {
                pageViewController.setViewControllers([nextVC], direction: .forward, animated: true, completion: nil)
                pageControl.currentPage = currentIndex + 1
            }
        } else {
            let chooseVC = ChoosePassportViewController(viewModel: ChoosePassportViewModel(), tabBar: TabController())
            navigationController?.pushViewController(chooseVC, animated: true)
            UserDefaultsManager.shared.isWelcomeScreenShown = true
        }
    }
    
    @objc private func skipButtonTapped() {
        let chooseVC = ChoosePassportViewController(viewModel: ChoosePassportViewModel(), tabBar: TabController())
        navigationController?.pushViewController(chooseVC, animated: true)
        UserDefaultsManager.shared.isWelcomeScreenShown = true
    }
    
    init(presenter: OnboardingPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    // Page view controller data source methods
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = (viewController.view.subviews.first as? OnboardingView)?.tag, index > 0 {
            return viewControllerTest(at: index - 1)
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let onboardingView = viewController.view.subviews.first as? OnboardingView {
            let index = onboardingView.tag
            if index < presenter.numberOfItems() - 1 {
                return viewControllerTest(at: index + 1)
            }
        }
        return nil
    }
    
    // Page view controller delegate methods
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed, let currentVC = pageViewController.viewControllers?.first, let index = (currentVC.view.subviews.first as? OnboardingView)?.tag {
            pageControl.currentPage = index
        }
    }
}

extension UIViewController {
    func withView(_ view: UIView) -> UIViewController {
        let vc = UIViewController()
        vc.view.addSubview(view)
        view.frame = vc.view.bounds
        return vc
    }
}
