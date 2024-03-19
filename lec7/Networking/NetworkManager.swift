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

    /**
     Add a new member to the roster

     - Parameters:
        - member: the member object to add
     */
    func addToRoster(member: Member, completion: @escaping (Member) -> Void) {
        // Specify the endpoint
        let endpoint = "https://ioscourse-g3jtiqqehq-ue.a.run.app/"

        // Define the request body
        let parameters: Parameters = [
            "name": member.name,
            "subteam": member.subteam,
            "position": member.position
        ]

        // Create a decoder
        let decoder = JSONDecoder()
        // decoder.dateDecodingStrategy = .iso8601 // Only if needed
        // decoder.keyDecodingStrategy = .convertFromSnakeCase // Only if needed

        // Create the request
        AF.request(endpoint, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Member.self, decoder: decoder) { response in
                // Handle the response
                switch response.result {
                case .success(let member):
                    print("Successfully added member \(member.name)")
                    completion(member)
                case .failure(let error):
                    print("Error in NetworkManager.addToRoster: \(error.localizedDescription)")
                }
            }
    }

}
