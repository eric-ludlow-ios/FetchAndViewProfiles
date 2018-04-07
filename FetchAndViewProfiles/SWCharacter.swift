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

class SWCharacter: Object, Codable {
    static let webServiceUrl: String = "https://edge.ldscdn.org/mobile/interview/directory"
    
    enum Affiliation: String {
        case jedi = "JEDI"
        case resistance = "RESISTANCE"
        case firstOrder = "FIRST_ORDER"
        case sith = "SITH"
        
        var title: String {
            switch self {
            case .jedi:
                return "Jedi Master"
            case .resistance:
                return "Resistance Leader"
            case .firstOrder:
                return "First Order"
            case .sith:
                return "Sith Lord"
            }
        }
        
        var color: CGColor {
            switch self {
            case .jedi, .resistance:
                return UIColor.blue.cgColor
            case .firstOrder, .sith:
                return UIColor.red.cgColor
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id, firstName, lastName, birthdate, profilePictureUrlString = "profilePicture", forceSensitive, affiliationString = "affiliation"
    }
    
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var birthdate: String = ""
    @objc dynamic var profilePictureUrlString: String = ""
    @objc dynamic var forceSensitive: Bool = false
    @objc dynamic var affiliationString: String = ""
    
    var fullName: String {
        let name = firstName + " " + lastName
        return name.trimmingCharacters(in: .whitespaces)
    }
    
    var age: Int {
        return Calendar.age(from: birthdate)
    }
    
    var forceUser: String {
        return forceSensitive ? "Force User" : "\"Muggle\""
    }
    
    var profilePictureUrl: URL? {
        return URL(string: profilePictureUrlString)
    }
    
    var affiliation: Affiliation? {
        return Affiliation(rawValue: affiliationString)
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    static func getCharacters(completion: @escaping ([SWCharacter]?, Error?) -> Void) {
        if let realm = try? Realm() {
            let characters = realm.objects(SWCharacter.self)
            if !characters.isEmpty {
                completion([SWCharacter](characters), nil)
                return
            }
        }
        
        fetchCharacters(completion: completion)
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
                        let characters = wrapper.characters
                        completion(characters, nil)
                        save(characters)
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
    
    static func save(_ characters: [SWCharacter]) {
        for character in characters {
            character.save()
        }
    }
    
    func save(completion: ((Bool, Error?) -> Void)? = nil) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self)
                completion?(true, nil)
            }
        } catch {
            print(error)
            completion?(false, error)
        }
    }
}
