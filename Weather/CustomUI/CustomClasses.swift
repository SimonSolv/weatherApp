//
//  CustomClasses.swift
//  Weather
//
//  Created by Simon Pegg on 28.11.2022.
//

import Foundation
import UIKit

enum LabelType {
    case title
    case mainText
    case secondaryText
    case smallText
    
}

final class MyLabel: UILabel {
    
    init(labelType: LabelType, color: UIColor) {
        super.init(frame: .zero)
        switch labelType {
        case .title:
            self.font = .boldSystemFont(ofSize: 30)
            self.textColor = color
        case .mainText:
            self.font = .boldSystemFont(ofSize: 35)
            self.textColor = color
        case .secondaryText:
            self.font = .boldSystemFont(ofSize: 14)
            self.textColor = color
        case .smallText:
            self.font = .systemFont(ofSize: 11)
            self.textColor = color
        }
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

final class CustomAlert: UIAlertController {
    
    init(message: String, actionHandler: ((UIAlertAction) -> Void)?) {
       // self.preferredStyle = .alert
        super.init(nibName: nil, bundle: nil)
        self.title = "Warning"
        self.message = message
        let action = UIAlertAction(title: "Ok", style: .default, handler: actionHandler)
        self.addAction(action)
    }
    required init?(coder: NSCoder) {
        nil
    }

}


