//
//  NetworkManager.swift
//  lec7
//
//  Created by Vin Bui on 10/31/23.
//

import Alamofire
import Foundation

class NetworkManager {

    /// Shared singleton instance
    static let shared = NetworkManager()

    private init() { }

    // MARK: - Requests

    /**
     Fetch the entire roster from the backend
     */
    func fetchRoster(completion: @escaping ([Member]) -> Void) {
        // Specify the endpoint
        let endpoint = "https://ioscourse-g3jtiqqehq-ue.a.run.app/"

        // Create a decoder
        let decoder = JSONDecoder()
        // decoder.dateDecodingStrategy = .iso8601 // Only if needed
        // decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed

        // Create the request
        AF.request(endpoint, method: .get)
            .validate()
            .responseDecodable(of: [Member].self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let members):
                    print("Successfully fetched \(members.count) members")
                    completion(members)
                case .failure(let error):
                    print("Error in NetworkManager.fetchRoster: \(error.localizedDescription)")
                }
            }
    }

}
