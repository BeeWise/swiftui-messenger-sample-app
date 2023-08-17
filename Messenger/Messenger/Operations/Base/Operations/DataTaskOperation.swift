import Foundation

public protocol OperationProtocol: AnyObject {
    associatedtype T: Codable
    var model: Any? { get set }
    var request: URLRequest? { get }
    func fetch() async throws -> T
}

public struct OperationResult<T: Codable> {
    public let value: T
    public let pageCount: Int?
    public let itemsPerPage: Int?
    
    public init(value: T, pageCount: Int?, itemsPerPage: Int?) {
        self.value = value
        self.pageCount = pageCount
        self.itemsPerPage = itemsPerPage
    }
}

open class DataTaskOperation<T: Codable>: Operation, OperationProtocol {
    public var model: Any?
    public var request: URLRequest? { return nil }
    
    public init(model: Any? = nil) {
        self.model = model
        super.init()
    }
    
    open func fetch() async throws -> T {
        guard let request = self.request else { throw OperationError.noUrlAvailable }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        self.log(request: request, data: data, response: response, error: nil)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw OperationError.noUrlAvailable }
        guard statusCode == OperationStatusCode.ok.rawValue else { throw OperationError.error(message: String(describing: statusCode), code: statusCode) }
        guard let decodedData = try? JSONDecoder().decode(APIResponse<T>.self, from: data) else { throw OperationError.cannotParseResponse }
        guard let result = decodedData.data else { throw OperationError.noDataAvailable }
        return result
    }
}
