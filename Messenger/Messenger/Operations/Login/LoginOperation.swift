import Foundation

enum LoginOperationModels {
    struct Request {
        let email: String
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

class LoginOperation: DataTaskOperation<LoginOperationModels.Response> {
    override func fetch() async throws -> LoginOperationModels.Response {
        guard let model = self.model as? LoginOperationModels.Request else { throw OperationError.noDataAvailable }
        let user = try await FirebaseService.shared.loginUser(email: model.email, password: model.password)
        return LoginOperationModels.Response(data: LoginOperationModels.DataModel(user: user))
    }
}

class LoginLocalOperation: JSONFileOperation<LoginOperationModels.Response> {
    override func fileName() -> String? {
        return "login_local_operation"
    }
}
