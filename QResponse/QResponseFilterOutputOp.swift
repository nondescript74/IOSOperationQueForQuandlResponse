//
//  QResponseFilterOutputOp.swift
//  Correlations
//
//  Created by Zahirudeen Premji on 8/19/18.
//  Copyright © 2018 Bodopine LLC. All rights reserved.
//

import Foundation

class QResponseFilterOutputOp: FilterAbstractOp {
    
    fileprivate let completion: (NSDictionary?) -> ()
    
    init(completion: @escaping (NSDictionary?) -> ()) {
        self.completion = completion
        super.init(str: nil)
    }
    
    override func main() {
        if isCancelled { return }
        completion(filterInput)
    }
}
