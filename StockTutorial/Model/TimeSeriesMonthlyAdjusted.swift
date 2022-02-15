import Foundation

struct TimeSeriesMonthlyAdjusted: Decodable {
    let meta: Meta
    let series: [String: OHLC]
    var monthInfos: [MonthInfo] = []
    
    enum CodingKeys: String, CodingKey {
        case meta = "Meta Data"
        case series = "Monthly Adjusted Time Series"
    }
    
    struct Meta: Decodable {
        let symbol: String
        
        enum CodingKeys: String, CodingKey {
            case symbol = "2. Symbol"
        }
    }
    
    struct OHLC: Decodable {
        let open: String
        let close: String
        let adjustedClose: String
        
        enum CodingKeys: String, CodingKey {
            case open = "1. open"
            case close = "4. close"
            case adjustedClose = "5. adjusted close"
        }
    }
    
    mutating func generateMonthInfos() {
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "yyyy-MM-dd"
        
        var monthInfos = [MonthInfo]()
        
        let sortedSeries = series.sorted { $0.key > $1.key }
        
        sortedSeries.forEach { (dateString, ohlc) in
            if let date = dateformatter.date(from: dateString),
               let adjustedClose = Double(ohlc.close),
               let adjustedOpen = generateAdjustedOpen(ohlc: ohlc) {
                
                let monthInfo = MonthInfo(date: date, adjustedOpen: adjustedOpen, adjustedClose: adjustedClose)
                monthInfos.append(monthInfo)
            }
        }
        self.monthInfos = monthInfos
    }
    
    private func generateAdjustedOpen(ohlc: OHLC) -> Double? {
        var adjustedOpen: Double?
        
        if let open = Double(ohlc.open),
           let close = Double(ohlc.close),
           let adjustedClose = Double(ohlc.adjustedClose) {
            
            adjustedOpen = open * (adjustedClose / close)
        }
        return adjustedOpen
    }
}


