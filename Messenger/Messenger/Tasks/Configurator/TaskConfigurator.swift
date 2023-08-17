import Foundation

class TaskConfigurator {
    static let shared = TaskConfigurator()
    
    // TODO: - Add configuration!
    var environment: TaskEnvironment = .development
    
    init() {
        
    }
    
    func authenticationTask() -> AuthenticationTaskProtocol {
        return AuthenticationTask(environment: self.environment)
    }
}
