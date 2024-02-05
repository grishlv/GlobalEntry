//
//  PresenterOnboarding.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 04.09.23.
//

import Foundation
import UIKit

final class OnboardingPresenter {
    
    private var onboardingItems: [OnboardingItem] = [
        OnboardingItem(image: UIImage(named: "firstOnboardingImage")!, description: "Quick search for entry conditions in all countries"),
        OnboardingItem(image: UIImage(named: "secondOnboardingImage")!, description: "Useful information about the country in a short form"),
        OnboardingItem(image: UIImage(named: "thirdOnboardingImage")!, description: "Discover new horizons with Global Entry!")
    ]
    
    func getOnboardingItems() -> [OnboardingItem] {
        return onboardingItems
    }
    
    func numberOfItems() -> Int {
        return onboardingItems.count
    }
}
