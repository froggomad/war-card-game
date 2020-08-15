//
//  UIImage+Named.swift
//  War
//
//  Created by Kenny on 8/14/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

extension String {
    enum CardRankToNum: Int, CaseIterable {
        case two = 2
        case three
        case four
        case five
        case six
        case seven
        case eight
        case nine
        case ten
        case jack
        case queen
        case king
        case ace
    }

    enum CardImage: String {
        case background = "Background"
        case logo
        case dealButton = "dealbutton"
        case back
    }

    static func image(_ named: CardImage) -> String {
        return named.rawValue
    }

    static func cardImage(_ rank: CardRankToNum) -> String {
        return "card\(rank.rawValue)"
    }
}
