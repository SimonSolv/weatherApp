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
}

final class MyLabel: UILabel {
    
    init(labelType: LabelType) {
        super.init(frame: .zero)
        switch labelType {
        case .title:
            self.font = .boldSystemFont(ofSize: 30)
            self.textColor = .white
        case .mainText:
            self.font = .boldSystemFont(ofSize: 30)
            self.textColor = .white
        case .secondaryText:
            self.font = .boldSystemFont(ofSize: 10)
            self.textColor = .white
        }
        self.textAlignment = .center
        self.translatesAutoresizingMaskIntoConstraints = false

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


