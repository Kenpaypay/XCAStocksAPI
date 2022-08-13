//  Created by Alfian Losari on 13/08/22.
//

import Foundation

public struct SearchTickerResponse: Decodable {
    
    public let error: ErrorResponse?
    public let data: [Ticker]?
    
    enum RootKeys: String, CodingKey {
        case count
        case quotes
        case finance
    }
    
    enum FinanceKeys: String, CodingKey {
        case error
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        data = try container.decodeIfPresent([Ticker].self, forKey: .quotes)
        error = try? container.nestedContainer(keyedBy: FinanceKeys.self, forKey: .finance)
            .decodeIfPresent(ErrorResponse.self, forKey: .error)
    }
}

public struct Ticker: Decodable {
    public let symbol: String
    public let quoteType: String?
    public let shortname: String?
    public let longname: String?
    public let sector: String?
    public let industry: String?
    public let exchDisp: String?
}