//
//  Publisher+Extension.swift
//  BanqueMisr-UAE
//
//  Created by Mohamed Samir on 25/07/2023.
//

import Combine
import Foundation

extension Publisher where Self.Failure == Never {

    public func assignToWithoutRetainCycle<Root>(to keyPath: ReferenceWritableKeyPath<Root, Self.Output>, on object: Root) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] (value) in
            guard let object = object else { return }
            _ = Just(value).assign(to: keyPath, on: object)
        }
    }
}
