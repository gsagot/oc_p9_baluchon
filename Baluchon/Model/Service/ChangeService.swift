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
    
    private static var changeUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(key.rate)")!

    func getChange(completionHandler: @escaping ((Bool, String?, ChangeResult? ) -> Void)) {
        var request = URLRequest(url: ChangeService.changeUrl)
        request.httpMethod = "POST"
        
        task?.cancel()
        
        task = changeSession.dataTask(with: request) { (data, response, error) in

            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print ("ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "Can't connect to the server, please verify your connexion",nil)
                    return
                }
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    print ("ERROR: \(String(describing: response))")
                    completionHandler (false, "Can't connect to the server, please try again", nil)
                    return
                }
                guard let result = try? JSONDecoder().decode(ChangeResult.self, from: data) else {
                    print("JSON ERROR: \(String(describing: error?.localizedDescription))")
                    completionHandler (false, "An error occurred, please try again", nil)
                    return
                }
                
                completionHandler (true, nil, result)
            }
        }
        task?.resume()
        
    }
    
}
