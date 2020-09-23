
// (c) 2015 Nate Cook, licensed under the MIT license
//
// Fisher-Yates shuffle as protocol extensions

import UIKit

extension Collection {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Iterator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollection where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

//[1, 2, 3].shuffle()
// [2, 3, 1]
//let fiveStrings = (0.stride(to: 100, by: 5).map(String.init)).shuffle()
// ["20", "45", "70", "30", ...]
//var numbers = [1, 2, 3, 4]
//numbers.shuffleInPlace()
// [3, 2, 1, 4]
