//
//  QResponseSerializeOp.swift
//  Correlations
//
//  Created by Zahirudeen Premji on 8/19/18.
//  Copyright © 2018 Bodopine LLC. All rights reserved.
//

import Foundation

protocol QResponseSerializeOpDataProvider {
    var data:Data? { get }
}

class QResponseSerializeOp: Operation {
    
    fileprivate let inputData: Data?
    fileprivate let completion: ((QuandlResponse?) -> ())?
    fileprivate var qResponse: QuandlResponse?
    
    init(data: Data?, completion: ((QuandlResponse?) -> ())? = nil) {
        inputData = data
        self.completion = completion
        super.init()
    }
    
    override func main() {
        let tradesData: Data?
        if self.isCancelled { return }
        if let inputData = inputData {
            tradesData = inputData
        } else {
            let dataProvider = dependencies
                .filter { $0 is QResponseSerializeOpDataProvider }
                .first as? QResponseSerializeOpDataProvider
            tradesData = dataProvider?.data
        }
        
        guard let setOfData = tradesData else { return }
        
        if self.isCancelled { return }
        
        qResponse = serializeReceivedDataWithModel(data: setOfData)
        
        if Defaults.zBug1 { print("QResponseSerializeOpDataProvider: qResponse most recent date is  ", qResponse?.dataset.newest_available_date ?? "zWTF?" ) }
        
        if self.isCancelled { return }
        completion?(qResponse)
    }
    
    func serializeReceivedDataWithModel(data: Data) -> QuandlResponse   {
        
        let decoder = JSONDecoder()
        
        do  {
            let response = try decoder.decode(QuandlResponse.self, from: data)
            if Defaults.zBug0 { print(response.dataset.description) }
            self.qResponse = response
            return response
        }   catch   {
            print(error)
            fatalError()
        }
    }
}

extension QResponseSerializeOp: QResponseDictCreateOpDataProvider {
    var quandlResponse: QuandlResponse? {
        return qResponse
    }
}
