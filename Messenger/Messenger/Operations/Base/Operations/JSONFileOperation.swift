import Foundation

class JSONFileOperation<T: Codable>: DataTaskOperation<T> {
    private var extensionType: String = "json"
        
    open func fileName() -> String? {
        return nil
    }
    
    public override func fetch() async throws -> T {
        guard let fileName = self.fileName() else { throw OperationError.noDataAvailable }
        guard let url = Bundle.main.url(forResource: fileName, withExtension: self.extensionType) else { throw OperationError.noDataAvailable }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
