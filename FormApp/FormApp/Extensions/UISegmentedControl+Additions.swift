//
//  UISegmentedControl+Additions.swift
//  FormApp
//
//  Created by Eduard Caziuc on 4/16/21.
//

import UIKit

extension UISegmentedControl {
    func replaceSegments(segments: [String]) {
        self.removeAllSegments()
        
        segments.forEach { segment in
            self.insertSegment(withTitle: segment, at: self.numberOfSegments, animated: false)
        }
    }
}
