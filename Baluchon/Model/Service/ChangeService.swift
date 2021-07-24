//
//  ChangeService.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import Foundation

class ChangeService {
    
    static var shared = ChangeService()
    
    private var changeSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    private init () {}

    init(changeSession: URLSession) {
        self.changeSession = changeSession
    }
    
    func start(){
        ChangeService.shared = ChangeService()
    }
    
    func getChange(completionHandler: @escaping ((Bool, String?, ChangeResult? ) -> Void)) {
        
        //let changeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(key.rate)")!
        
        let changeUrl = formatUrl()
        
        var request = URLRequest(url: changeUrl)
        request.httpMethod = "POST"
        
        task?.cancel()
        
        task = changeSession.dataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, Settings.shared.errorData,nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, Settings.shared.errorReponseCurrency, nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(ChangeResult.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, Settings.shared.errorJson, nil)
                    return
                }
                
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
        
    }
    
    private func formatUrl ()->URL {
        let bodyUrl = "access_key=\(key.rate)"
        let changeUrl = "http://data.fixer.io/api/latest?"
        guard let resultUrl = URL(string: changeUrl + bodyUrl) else {return URL(string:"http://data.fixer.io/")!}
        
        return resultUrl
        
    }
    
}
