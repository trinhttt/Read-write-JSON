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
        // Do any additional setup after loading the view.
        readJSON()
    }

    func readJSON() {
        if let url = Bundle.main.url(forResource: "Test", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    let data = jsonResult["data"] as? [Any]
                    print(data)
                }
            } catch {
                // handle error
            }
        }
    }
    
    func readJSON_Coable() {
        
    }
}

//struct UploadImageResponse: Decodable {
//    let name: String
//    let meta: MetaData
//    let tookAt: String?
//    let originalFileName: String
//    let imageId: Int
//
//    private enum CodingKeys: String, CodingKey {
//        case name
//        case meta
//        case tookAt = "took_at"
//        case originalFileName = "original_file_name"
//        case imageId = "image_id"
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        name = try container.decode(String.self, forKey: .name)
//        meta = try container.decode(MetaData.self, forKey: .meta)
//        tookAt = try container.decodeIfPresent(String.self, forKey: .tookAt)
//        originalFileName = try container.decode(String.self, forKey: .originalFileName)
//        imageId = try container.decode(Int.self, forKey: .imageId)
//    }
//}
//
//struct MetaData: Decodable {
//    let mime: String
//    let rotate: Int
//    let width: Int
//    let height: Int
//}
