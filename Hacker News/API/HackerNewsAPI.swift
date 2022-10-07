//
//  HackerNewsAPI.swift
//  Hacker News
//
//  Created by Cory Ginsberg on 10/1/22.
//

import Foundation

let BASE_URL: String = "https://hacker-news.firebaseio.com/v0"

//struct RequestTypesContainer: Decodable {
//    let RequestTypes : [PostInfo]
//
//    private enum CodingKeys: String, CodingKey {
//       case RequestTypes
//    }
//}


struct PostInfo: Decodable, Identifiable {
  public let by: String;
  public let descendants: Int;
  public let id: Int;
  public let kids: [Int];
  public let score: Int;
  public let text: String?;
  public let time: Int;
  public let title: String;
  public let type: String;
  public let url: String;
  public var deleted: Bool = false;
  public var dead: Bool = false;
};

class HackerNewsAPI: ObservableObject {

  @Published var hnStories: [PostInfo] = [PostInfo]()

  init() {
    let topStoriesUrl: URL = URL(string: "\(BASE_URL)/topstories.json")!
    URLSession.shared.dataTask(with: topStoriesUrl) {(data: Data?, _, _) in
      let decodedData = try! JSONDecoder().decode([Int].self, from: data!)
      for storyId in decodedData {
        self.getDataFromJSON(data: storyId, completion: { (stories) in
          self.hnStories.append(contentsOf: stories)
        })
      }
    }.resume()
  }
  
  func getDataFromJSON(data: Int, completion: @escaping ([PostInfo]) -> ()) {
    let url = URL(string: "\(BASE_URL)/item/\(data).json")!
    URLSession.shared.dataTask(with: url) {(itemData: Data?, _: URLResponse?, error: Error?) in
      do {
        let jsonDecoder = JSONDecoder();
        jsonDecoder.assumesTopLevelDictionary = true
        let decodedData: [PostInfo] = try jsonDecoder.decode([PostInfo].self, from: itemData!)
        print("decodedData: \(decodedData)")
        DispatchQueue.main.async {
          completion(decodedData)
        }
      } catch {
        print(itemData!)
        print(error.localizedDescription)
      }
      
    }.resume()
  }
}
