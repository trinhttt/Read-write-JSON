//
//  ViewController.swift
//  PlayingWithJSON
//
//  Created by Trinh Thai on 9/15/20.
//  Copyright © 2020 Trinh Thai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        readJSON_JSONSerialization()
        readJSON_Coable()
    }

    func readJSON_JSONSerialization() {
        if let url = Bundle.main.url(forResource: "Test", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    let data = jsonResult["data"] as? [Any]
                    print(data)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func readJSON_Coable() {
        if let url = Bundle.main.url(forResource: "Test", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let response = try JSONDecoder().decode(APIBase<StudentResponse>.self, from: data)
                print(response.data[0])
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
struct APIError: Decodable, CustomDebugStringConvertible {
    let code: String
    let message: String

    var debugDescription: String {
        return "code=\(code), message=\(message)"
    }
}

struct APIBase<T: Decodable>: Decodable {
    let data: [T]
    let status: Int
    let errors: [APIError]
}

struct StudentResponse: Decodable {
    let info: PersonalInfo
    let avatar: String?
    let studentId: String

    private enum CodingKeys: String, CodingKey {
        case info
        case avatar
        case studentId = "student_id"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        info = try container.decode(PersonalInfo.self, forKey: .info)
        avatar = try container.decodeIfPresent(String.self, forKey: .avatar)
        studentId = try container.decode(String.self, forKey: .studentId)
    }
}

struct PersonalInfo: Decodable {
    let name: String
    let birthday: String
}
