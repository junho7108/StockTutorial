import Foundation
import RxSwift
import Alamofire

class StockRepositoryImpl: StockRepository {
    
    enum StockRepositoryError: Error {
        case encoding
        case badURL
    }
    
    let apiKey: String = "IZEI2Y7NR30L387V"
    let decoder = JSONDecoder()
    
    //MARK: - 기존 API를 이용해서 Observable을 리턴하는 API 구현
    func fetchStockPublisher(keywords: String) -> Observable<StockResult> {
        return Observable.create { observable -> Disposable in
            
            self.fetchStockPublisher(keywords: keywords) { result in
                switch result {
                case .success(let stockResult):
                    observable.onNext(stockResult)
                    observable.onCompleted()
                    
                case .failure(let error):
                    observable.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    //MARK: -  Observable.Create로 API 구현
    
    func fetchTimeSeriesPublisher(keywords: String) -> Observable<TimeSeriesMonthlyAdjusted> {
        return Observable.create { [unowned self] observable -> Disposable in
            
            let queryResult = parseQueryString(text: keywords)
            var query = ""
            
            switch queryResult {
            case .success(let value):
                query = value
                
            case .failure(let error):
                return Disposables.create {
                    observable.onError(error)
                }
            }
            
            let urlString = "https://www.alphavantage.co/query?function=TIME_SERIES_MONTHLY_ADJUSTED&symbol=\(query)&\(self.apiKey)"
            let urlResult = parseURL(urlString: urlString)
            
            switch urlResult {
            case .success(let url):
                AF.request(url, method: .get,
                           parameters: nil,
                           encoding: JSONEncoding.default,
                           headers: nil, interceptor: nil, requestModifier: nil)
                    .responseDecodable(of: TimeSeriesMonthlyAdjusted.self) { response in
                        
                        if let error = response.error {
                            observable.onError(error)
                        }
                        
                        if let timeSeries = response.value {
                            observable.onNext(timeSeries)
                            observable.onCompleted()
                        }
                    }
                
            case .failure(let error):
                return Disposables.create {
                    observable.onError(error)
                }
            }
         
            return Disposables.create()
        }
    }
    
    private func parseURL(urlString: String) -> Result<URL, Error> {
        if let url = URL(string: urlString) {
            return .success(url)
        } else {
            let error = StockRepositoryError.badURL
            return .failure(error)
        }
    }
    
    private func parseQueryString(text: String) -> Result<String, Error> {
        if let query = text.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            return .success(query)
        } else {
            let error = StockRepositoryError.encoding
            return .failure(error)
        }
    }
}

extension StockRepositoryImpl {
    private func fetchStockPublisher(keywords: String, completion: @escaping ((Result<StockResult, Error>) -> Void)) {
        let queryResult = parseQueryString(text: keywords)
        var query = ""
        
        switch queryResult {
        case .success(let value):
            query = value
        case .failure(let error):
            return completion(.failure(error))
        }
        
        let urlString = "https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=\(query)&apikey=\(apiKey)"
        let urlResult = parseURL(urlString: urlString)
     
        switch urlResult {
        case .success(let url):
            AF.request(url, method: .get,
                       parameters: nil,
                       encoding: JSONEncoding.default,
                       headers: nil, interceptor: nil, requestModifier: nil)
                .responseDecodable(of: StockResult.self) { response in
                    
                    if let error = response.error {
                        completion(.failure(error))
                    }
                    
                    if let stockResult = response.value {
                        completion(.success(stockResult))
                    }
                }
            
        case .failure(let error):
            return completion(.failure(error))
            
        }
    }
}
