//
//  ReuseIdentifiable.swift
//  PlanFit
//
//  Created by 김진웅 on 5/14/24.
//

import Foundation

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}
