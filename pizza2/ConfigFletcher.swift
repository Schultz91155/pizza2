//
//  ConfigFletcher.swift
//  pizza2
//
//  Created by admin on 24.03.2023.
//

import Foundation

class ConfigFetcher {
    let configUrl = URL(string: "https://raw.githubusercontent.com/Schultz91155/Pizza1/main/Pizza1/ProductStorage.json")!
    
    func fetchConfig (completion: @escaping((Error?, AppConfig?)-> Void)){
        
        let request = URLRequest(url: configUrl)
        let task = URLSession.shared.dataTask(with: request,
                                              completionHandler: {(completitionData, completitionResponse, completionError) in
            if let error = completionError{
                return completion(error, nil)
            }
            
            guard let data = completitionData else {return}
            
            do{
                let JsonData = try JSONDecoder().decode(AppConfig.self, from: data)
                completion(nil, JsonData)
            }
            catch{
                completion(error, nil)
            }
        })
        
        task.resume()
            }
        }
        

