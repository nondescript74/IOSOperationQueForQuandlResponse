//
//  QResponseOperationQue.swift
//  Correlations
//
//  Created by Zahirudeen Premji on 8/19/18.
//  Copyright © 2018 Bodopine LLC. All rights reserved.
//

import Foundation

class QResponseOperationQue {
    
    fileprivate let operationQueue1 = OperationQueue()
    var url: URL?
    
    init(url: URL, completion: @escaping (NSDictionary?) -> ()) {
        self.url = url
        var multiplier: Double?
        var myTradeStr: String?
        
        // Create the operations
        
        multiplier = 1.0
        myTradeStr = ""
        
        
        let dataLoad = DataLoadOperation(url: (self.url!))
        let periodData = QResponseSerializeOp(data: nil)
        
        let currentCreate = QResponseDictCreateOp(multiplir: multiplier!, buysellz: myTradeStr!, quandlResponse: nil)
        let qResponseOut = QResponseFilterOutputOp(completion: completion)
        
        let operations = [dataLoad, periodData, currentCreate, qResponseOut]
        
        periodData.addDependency(dataLoad)
        currentCreate.addDependency(periodData)
        qResponseOut.addDependency(currentCreate)
        operationQueue1.addOperations(operations, waitUntilFinished: false)
        
        if Defaults.zBug1 { print("QResponseOperationQue: completed addOperations") }
        
    }
    
    func cancel() {
        operationQueue1.cancelAllOperations()
    }
}

extension QResponseOperationQue: Hashable {
    var hashValue: Int {
        return  (self.url?.hashValue)!
    }
}

func ==(lhs: QResponseOperationQue, rhs: QResponseOperationQue) -> Bool {
    return lhs.url == rhs.url
}


