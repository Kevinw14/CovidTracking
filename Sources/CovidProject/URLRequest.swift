//
//  URLCovidRequest.swift
//  
//
//  Created by Kevin Wood on 3/2/21.
//

import Foundation
import Alamofire

protocol URLCovidRequestDelegate: class {
    func urlCovidRequestDataReceived(request: DataRequest, data: Data, state: Stat.State)
    func urlCovidRequestErrorReceived(request: DataRequest, error: Error)
    func urlCovidRequestProgress(requst: DataRequest, progress: Double, state: Stat.State)
}

class URLCovidRequest {
    
    private var request: DataRequest!
    weak var delegate: URLCovidRequestDelegate?
    
    func data(state: Stat.State) {
        let url = URL(string: "https://api.covidtracking.com/v1/states/\(state.rawValue)/daily.json")!
        self.request = AF.request(url)
        request.responseData { (response) in
            switch response.result {
            case .success( let data ):
                self.delegate?.urlCovidRequestDataReceived(request: self.request, data: data, state: state)
            case .failure( let error ):
                self.delegate?.urlCovidRequestErrorReceived(request: self.request, error: error)
            }
        }
        
        request.downloadProgress { (progress) in
            self.delegate?.urlCovidRequestProgress(requst: self.request, progress: progress.fractionCompleted, state: state)
        }
        
        RunLoop.main.run(until: Date(timeIntervalSinceNow: 0.2))
    }
}
