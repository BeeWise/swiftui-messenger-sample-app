import Foundation
import Combine

enum AuthenticationTaskModels {
    struct Login {
        struct Request {
            let email: String
            let password: String
        }
        
        struct Response {
            var user: User?
        }
    }
    
    struct SignUp {
        struct Request {
            let email: String
            let fullname: String
            let password: String
        }
        
        struct Response {
            var user: User?
        }
    }
}

protocol AuthenticationTaskProtocol: TaskProtocol {
    func login(model: AuthenticationTaskModels.Login.Request, subject: PassthroughSubject<User?, Error>)
    func signUp(model: AuthenticationTaskModels.SignUp.Request, subject: PassthroughSubject<User?, Error>)
}

class AuthenticationTask: AuthenticationTaskProtocol {
    var environment: TaskEnvironment
    
    init(environment: TaskEnvironment) {
        self.environment = environment
    }
    
    func login(model: AuthenticationTaskModels.Login.Request, subject: PassthroughSubject<User?, Error>) {
        let operationModel = LoginOperationModels.Request(email: model.email, password: model.password)
        let operation = self.loginOperation(model: operationModel)
        Task {
            do {
                let result = try await operation.fetch()
                subject.send(result.data?.user)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }
    }
    
    func loginOperation(model: LoginOperationModels.Request) -> DataTaskOperation<LoginOperationModels.Response> {
        switch self.environment {
            case .production: return LoginOperation(model: model)
            case .development: return LoginOperation(model: model)
            case .memory: return LoginLocalOperation(model: model)
        }
    }
    
    func signUp(model: AuthenticationTaskModels.SignUp.Request, subject: PassthroughSubject<User?, Error>) {
        let operationModel = SignUpOperationModels.Request(email: model.email, fullname: model.fullname, password: model.password)
        let operation = self.signUpOperation(model: operationModel)
        Task {
            do {
                let result = try await operation.fetch()
                subject.send(result.data?.user)
                subject.send(completion: .finished)
            } catch {
                subject.send(completion: .failure(error))
            }
        }
    }
    
    func signUpOperation(model: SignUpOperationModels.Request) -> DataTaskOperation<SignUpOperationModels.Response> {
        switch self.environment {
            case .production: return SignUpOperation(model: model)
            case .development: return SignUpOperation(model: model)
            case .memory: return SignUpLocalOperation(model: model)
        }
    }
}
