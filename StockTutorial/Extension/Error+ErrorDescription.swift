import Foundation

enum MyError: Error {
    case badresponse
    case badURL
    case encoding
}

extension MyError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badresponse:
            return "네트워크 상태가 좋지 않습니다."
        case .badURL:
            return "유효하지 않은 URL입니다."
        case .encoding:
            return "인코딩에 실패하였습니다."
        }
    }
}
