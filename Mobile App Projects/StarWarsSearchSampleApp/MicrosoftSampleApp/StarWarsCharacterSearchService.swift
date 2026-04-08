//
//  StarWarsCharacterSearchService.swift
//  MicrosoftSampleApp
//
//  Created by Abhay Curam on 12/8/25.
//

import Foundation

public enum StarWarsCharacterSearchServiceError: Error {
    case jsonDecodeError
}

public typealias CharacterSearchCompletion = ((_ result: CharacterSearchResult?, _ error: Error?) -> Void)

public class StarWarsCharacterSearchService {
    
    private var urlSession = URLSession.shared
    private let urlEndpoint: String = "https://swapi.tech/api/people/?name="
    
    public func searchForCharacters(_ query: String,
                                    _ callbackQueue: DispatchQueue,
                                    _ completion: @escaping CharacterSearchCompletion) {
        var urlString = urlEndpoint
        urlString.append(query)
        let url = URL(string: urlString)!
        let urlRequest = URLRequest(url: url)
        let task = urlSession.dataTask(with: urlRequest) { (data, response, error) in
            if let responseData = data, error == nil {
                do {
                    let searchResults = try JSONDecoder().decode(CharacterSearchResult.self, from: responseData)
                    callbackQueue.async {
                        completion(searchResults, nil)
                    }
                } catch {
                    callbackQueue.async {
                        let decodeError: StarWarsCharacterSearchServiceError = .jsonDecodeError
                        completion(nil, decodeError)
                    }
                }
            }
        }
        task.resume()
    }
    
    
}

