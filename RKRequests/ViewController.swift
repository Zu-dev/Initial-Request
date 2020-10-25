//
//  ViewController.swift
//  RKRequests
//
//  Created by Zukhra on 10/26/20.
//  Copyright © 2020 Zu project first app UICollectionView. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var dataTask: URLSessionDataTask?
    let defaultSession = URLSession(configuration: .default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let url = URL(string: "http://zp.khangroup.kz/rest/clients-app/v1/screen/home")
        let ppp = PPP(name: "Ramazan")
        dataTask = defaultSession.dataTask(with: url!) { [weak self] data, response, error in
            defer {
                self?.dataTask = nil
            }
            
            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                print(NSString(data: data, encoding: String.Encoding.utf8.rawValue))
                
                do {
                    let model = try JSONDecoder().decode(HomeResponse.self, from: data)
                    print(model)
                    
                    let encoder = try JSONEncoder().encode(ppp)
                    let components = URLComponents(url: url!, resolvingAgainstBaseURL: false)
                    
                }
                catch {
                    print("Error catched")
                }
                
                
            }
                
        }
        var urlRequest: URLRequest?
        do {
            let encoder = try JSONEncoder().encode(ppp)
            urlRequest = URLRequest(url: url!)
            urlRequest?.httpBody = encoder.base64EncodedData()
            post(request: urlRequest!, type: MessageResponse.self) { (response) in
                
            }
        }catch {
            
        }
        
        
        dataTask?.resume()
    }

    func post<T: Decodable>(request urlRequest: URLRequest, type: T.Type, completion: @escaping ((T) -> Void)) {
        dataTask = defaultSession.dataTask(with: urlRequest) { [weak self] data, response, error in
            guard let _ = error else { return }
            
            if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                print(NSString(data: data, encoding: String.Encoding.utf8.rawValue)!)
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    completion(model)
                }catch {
                    
                }
            }
        }
        dataTask?.resume()
    }
}

struct MessageResponse: Decodable {
    let message: String?
}

