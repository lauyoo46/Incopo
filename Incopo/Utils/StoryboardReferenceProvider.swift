//
//  StoryboardReferenceProvider.swift
//  Incopo
//
//  Created by Laurentiu Ile on 10.02.2021.
//

import UIKit

protocol StoryboardReferenceProvider {
    static var storyboard: UIStoryboard { get }
    static var initialViewController: UIViewController? { get }
    
    var viewControllerIdentifier: String { get }
    var viewController: UIViewController { get }
}

extension StoryboardReferenceProvider {
    
    static var initialViewController: UIViewController? {
        let controller = storyboard.instantiateInitialViewController()
        if controller == nil {
            fatalError("Unable to create View Controller")
        }
        return controller
    }
    
    var viewController: UIViewController {
        Self.storyboard.instantiateViewController(withIdentifier: viewControllerIdentifier)
    }
    
}

extension StoryboardReferenceProvider where Self: RawRepresentable, Self.RawValue == String {
    var viewControllerIdentifier: String { rawValue }
}

struct Storyboard {
    
    enum Main: String, StoryboardReferenceProvider {
        static var storyboard: UIStoryboard { .main }
        
        case tabBar = "TabBarControllerID"
    }
    
}

private extension UIStoryboard {
    static var main: UIStoryboard { UIStoryboard(name: "Main", bundle: .main) }
}
