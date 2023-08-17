//
//  SignUpOperation.swift
//  Messenger
//
//  Created by Dimitri Strauneanu on 16.08.2023.
//

import Foundation

enum SignUpOperationModels {
    struct Request {
        let email: String
        let fullname: String
        let password: String
    }
    
    struct Response: Codable {
        var data: DataModel?
        
        enum CodingKeys: String, CodingKey {
            case data = "data"
        }
    }
    
    struct DataModel: Codable {
        var user: User?
    }
}

class SignUpOperation: DataTaskOperation<SignUpOperationModels.Response> {
    override func fetch() async throws -> SignUpOperationModels.Response {
        guard let model = self.model as? SignUpOperationModels.Request else { throw OperationError.noDataAvailable }
        let user = try await FirebaseService.shared.createUser(email: model.email, password: model.password, fullname: model.fullname)
        return SignUpOperationModels.Response(data: SignUpOperationModels.DataModel(user: user))
    }
}

class SignUpLocalOperation: JSONFileOperation<SignUpOperationModels.Response> {
    override func fileName() -> String? {
        return "sign_up_local_operation"
    }
}
