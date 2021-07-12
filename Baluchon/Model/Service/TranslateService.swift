//
//  TranslateService.swift
//  Baluchon
//
//  Created by Gilles Sagot on 27/06/2021.
//

import Foundation

class TranslateService {
    
    static var shared = TranslateService()
    
    private var translateSession = URLSession(configuration: .default)
    private var task: URLSessionDataTask?
    
    private init () {}

    init(translateSession: URLSession) {
        self.translateSession = translateSession
    }

    private var source = "fr"
    private var target = "en"
    private var format = "text"
    
    private static var translateUrl = URL(string: "https://translation.googleapis.com/language/translate/v2?")!
    
    func getTranslation(sentence: String, completionHandler: @escaping ((Bool, String?, TranslationResult? ) -> Void)) {
        
        var request = URLRequest(url: TranslateService.translateUrl)
        request.httpMethod = "POST"
        
        let body = "key=\(key.translation)&q=\(sentence)&source=\(source)&target=\(target)&format=text"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        
        task = translateSession.dataTask(with: request) { (data, response, error) in
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
                guard let result = try? JSONDecoder().decode(TranslationResult.self, from: data) else {
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
