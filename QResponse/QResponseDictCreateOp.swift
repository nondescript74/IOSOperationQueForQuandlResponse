//
//  QResponseDictCreateOp.swift
//  Correlations
//
//  Created by Zahirudeen Premji on 8/19/18.
//  Copyright © 2018 Bodopine LLC. All rights reserved.
//

import Foundation

protocol QResponseDictCreateOpDataProvider {
    var quandlResponse:QuandlResponse? { get }
}

class QResponseDictCreateOp: Operation {
    
    fileprivate var inputQuandlResponse: QuandlResponse?
    fileprivate var completion: ((NSDictionary?) -> ())?
    fileprivate var myReturnDict: NSDictionary?
    fileprivate var multiplier: Double?
    fileprivate var buysell: String?
    fileprivate var tradeType: String?
    
    init(multiplir: Double, buysellz: String, quandlResponse: QuandlResponse?, completion: ((NSDictionary?) -> ())? = nil) {
        self.inputQuandlResponse = quandlResponse
        self.multiplier = multiplir
        self.buysell = buysellz
        self.completion = completion
        super.init()
    }
    
    override func main() {
        let quandlResponse: QuandlResponse?
        if self.isCancelled { return }
        if let inputQuandlResponse = inputQuandlResponse {
            quandlResponse = inputQuandlResponse
        } else {
            let dataProvider = dependencies
                .filter {$0 is QResponseDictCreateOpDataProvider }
                .first as? QResponseDictCreateOpDataProvider
            quandlResponse = dataProvider?.quandlResponse
        }
        
        guard quandlResponse != nil else { return }
        
        if self.isCancelled { return }
        
        myReturnDict = NSDictionary.init(objects: [quandlResponse!], forKeys: ["quandlResponse" as NSCopying])
        
        completion?(myReturnDict)  // z0, qcrt and qcrdiff are in the dict
        
        if self.isCancelled { return }
    }
}

extension QResponseDictCreateOp: FilterAbstractOpDataProvider {
    var str: NSDictionary? {
        return myReturnDict
    }
}


