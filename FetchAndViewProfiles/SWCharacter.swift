//
//  SWCharacter.swift
//  FetchAndViewProfiles
//
//  Created by Eric Ludlow on 4/6/18.
//  Copyright © 2018 EricLudlow. All rights reserved.
//

import Foundation
import RealmSwift

struct SWCharacterResponseWrapper: Codable {
    enum CodingKeys: String, CodingKey {
        case characters = "individuals"
    }
    var characters: [SWCharacter]
}

class SWCharacter: Codable {
    static let webServiceUrl: String = "https://edge.ldscdn.org/mobile/interview/directory"
    
    enum Affiliation: String {
        case jedi = "JEDI"
        case resistance = "RESISTANCE"
        case firstOrder = "FIRST_ORDER"
        case sith = "SITH"
    }
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, birthdate, profilePictureUrl = "profilePicture", forceSensitive, affiliationString = "affiliation"
    }
    
    var id: Int
    var firstName: String
    var lastName: String
    var birthdate: String
    var profilePictureUrl: URL
    var forceSensitive: Bool
    var affiliationString: String
    
    var affiliation: Affiliation? {
        return Affiliation(rawValue: affiliationString)
    }
    
    static func fetchCharacters(completion: @escaping ([SWCharacter]?, Error?) -> Void) {
        guard let url = URL(string: webServiceUrl) else {
            let error = NSError(domain: "Bad URL string", code: -101, userInfo: nil)
            completion(nil, error)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let session = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    completion(nil, error)
                } else if let data = data {
                    do {
                        let wrapper = try JSONDecoder().decode(SWCharacterResponseWrapper.self, from: data)
                        completion(wrapper.characters, nil)
                    } catch {
                        completion(nil, error)
                    }
                } else {
                    let error = NSError(domain: "Missing Data Error", code: 400, userInfo: nil)
                    completion(nil, error)
                }
            }
        }
        
        session.resume()
    }
}
