//
//  UIButton+Publisher.swift
//  BanqueMisr-UAE
//
//  Created by Mohamed Samir on 23/03/2023.
//

import Combine
import UIKit

extension UIButton {
    public   var tapPublisher: EventPublisher {
        publisher(for: .touchUpInside)
    }
}
