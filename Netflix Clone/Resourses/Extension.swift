//
//  Extension.swift
//  Netflix Clone
//
//  Created by K Praveen Kumar on 28/07/23.
//

import Foundation

extension String {
    func capitalizerFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
