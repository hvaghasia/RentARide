//
//  AlertViewPresentable.swift
//  RideCellAssignment
//
//  Created by Hardik on 22/03/18.
//  Copyright © 2018 Ugam. All rights reserved.
//

import Foundation
import UIKit

struct ErrorOptions {
    let title: String
    let message: String
    let actionButtonTitle: String
    let completionHandler: (() -> Void)?
    
    init(title: String = "Oops!",
         message: String = "Something went wrong",
         actionButtonTitle: String = "Ok",
         completionHandler: (() -> Void)? = nil) {
        self.message = message
        self.title = title
        self.actionButtonTitle = actionButtonTitle
        self.completionHandler = completionHandler
    }
}

protocol AlertViewPresentable {
    func presentError(errorOption: ErrorOptions)
}

extension AlertViewPresentable where Self: UIViewController {
    func presentError(errorOption: ErrorOptions) {
        let alert = UIAlertController(title: errorOption.title, message: errorOption.message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: errorOption.actionButtonTitle, style: .cancel) { _ in
            errorOption.completionHandler?()
        })
        self.present(alert, animated: true, completion: nil)
    }
}
