//
//  Webservice.swift
//  NoticiasMVVM-New
//
//  Created by Jose David Bustos H on 09-01-24.
//


import Foundation

class Webservice {
    
    func getArticles( completion: @escaping ([Article]?) -> ()) {
        
        let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!
        
//        let endpointData = getEndpoint(fromName: "crearIssue")!
//        let urlhttp = URL(string: endpointData.url.absoluteString)
//
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                do {
                    let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                    if let articleList = articleList {
                        completion(articleList.articles)
                    }
                    print(articleList?.articles)
                } catch {
                        print(error)
                }
            }
            
        }.resume()
        
    }
    
//    public func getEndpoint(fromName: String) -> APIEndpointModel? {
//        var endpointFile = ""
//        #if DEBUG
//            endpointFile = "endpointsDev"
//        #else
//            endpointFile = "endpoints"
//        #endif
//        debugPrint(endpointFile)
//        guard let path = Bundle.main.path(forResource: endpointFile, ofType: "plist") else {
//            debugPrint("ERROR: No se encontró archivo endpoints.plist")
//            return nil
//        }
//        let myDict = NSDictionary(contentsOfFile: path) as! [String : Any]
//        guard let endpoint = myDict[fromName] as? [String : String] else {
//            debugPrint("ERROR: No existe endpoint con el nombre \(fromName)")
//            return nil
//        }
//        return APIEndpointModel(url: URL(string: endpoint["url"]!)!, APIKey: endpoint["x-api-key"]!, APIToken: endpoint["x-api-token"])
//    }
    
}

