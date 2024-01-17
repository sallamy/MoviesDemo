//
//  UITextField+Publisher.swift
//  BanqueMisr-UAE
//
//  Created by Mohamed Samir on 23/03/2023.
//

import Combine
import UIKit

extension UITextField {
    public  var textPublisher: AnyPublisher<String, Never> {
        publisher(for: .editingChanged)
            .map { self.text ?? "" }
            .eraseToAnyPublisher()
    }
}
