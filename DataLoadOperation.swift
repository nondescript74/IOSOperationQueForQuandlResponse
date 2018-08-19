//
//  DataLoadOperation.swift
//  Correlations
//
//  Created by Zahirudeen Premji on 8/10/18.
//  Copyright © 2018 Bodopine LLC. All rights reserved.
//

import Foundation

class DataLoadOperation: AsyncOperation {
    
    fileprivate let url: URL
    fileprivate let completion: ((Data?) -> ())?
    fileprivate var loadedData: Data?
    
    init(url: URL, completion: ((Data?) -> ())? = nil) {
        self.url = url
        self.completion = completion
        super.init()
    }
    
    override func main() {
        if self.isCancelled { return }
        NetworkAccessor.asyncLoadDataAtURL(url) {
            data in
            if self.isCancelled { return }
            self.loadedData = data
            self.completion?(data)
            self.state = .Finished
        }
    }
}

extension DataLoadOperation: QResponseSerializeOpDataProvider, MetadataSerializeOperationDataProvider {
    var data: Data? { return loadedData }
}
