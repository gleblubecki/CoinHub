import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.instance
    }
}

class DeveloperPreview {
    
    static let instance = DeveloperPreview()
    
    private init() { }
    
    let homeVM = CurrencyViewModel()
    
    let coin = Coin(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
            currentPrice: 42907,
            marketCap: 840805235006,
            marketCapRank: 1,
            fullyDilutedValuation: 900925127067,
            totalVolume: 13116669838,
            high24H: 43102,
            low24H: 42553,
            priceChange24H: -86.54233038237726,
            priceChangePercentage24H: -0.20129,
            marketCapChange24H: -4088750686.235718,
            marketCapChangePercentage24H: -0.48394,
            circulatingSupply: 19598643,
            totalSupply: 21000000,
            maxSupply: 21000000,
            ath: 69045,
            athChangePercentage: -37.86459,
            athDate: "2021-11-10T14:24:11.849Z",
            atl: 67.81,
            atlChangePercentage: 63167.78047,
            atlDate: "2013-07-06T00:00:00.000Z",
            lastUpdated: "2024-01-14T16:08:14.725Z",
            sparklineIn7D: SparklineIn7D(price: [
                44103.403089788066,
                44409.33805138321,
                44405.04225136407,
                44084.03092490082,
                43958.493023527255,
                44103.29615635756,
                44154.60710846988,
                44257.557416166645,
                44162.733844326656,
                44262.89569184346,
                43913.027171732334,
                43952.992480757515,
                43702.02490934488,
                43740.3752020791,
                43410.6732630009,
                43545.57815791436,
                43584.26900168194,
                43653.41647432126,
                43868.723957558876,
                43970.179872191286,
                43878.523123706,
                43721.87099876503,
                44115.62001137011,
                44623.831952807195,
                45035.36867852668,
                44955.829772490855,
                44858.77760739248,
                45053.117160726826,
                44963.711067966564,
                45616.32072220056,
                46732.89341590511,
                47054.237210353574,
                46826.481202040944,
                47102.64174367074,
                47029.96569899208,
                46967.382518119644,
                46723.764489802285,
                46514.34483831957,
                46743.81165370962,
                46984.46264782061,
                46848.80865883023,
                46735.82105328489,
                46823.72048119166,
                46842.55965062589,
                46599.039040291136,
                46445.44104892705,
                46632.63785648282,
                46291.51222544441,
                46850.62305126942,
                46582.7344868979,
                46912.018102602466,
                46932.086368230106,
                46806.0321359157,
                46635.6662538745,
                46865.975970359825,
                46616.472462636906,
                45415.897838606754,
                46306.9392339082,
                46141.0273060772,
                45906.06887155878,
                45939.259761930414,
                45950.313301301125,
                46111.48372135452,
                45952.15946645022,
                45987.496154178545,
                46027.177986635215,
                45792.75131463303,
                45369.25473142742,
                45679.30564246095,
                45590.52406586656,
                45479.27153522809,
                44684.81864350586,
                45163.47550511835,
                44869.51619645116,
                45467.6133572863,
                45392.622194144125,
                46453.97725062231,
                46513.81466983131,
                46511.14453394796,
                46078.25968508527,
                45853.9558535854,
                46934.634572964234,
                46632.31314804979,
                46725.54309792355,
                46519.79254173459,
                46616.62304903666,
                46469.15146114308,
                46433.607811226466,
                46129.1605134834,
                45883.34815509798,
                46103.12576087745,
                46299.968279201006,
                46238.272786511865,
                46864.651092302935,
                47100.21009651497,
                47463.81450104777,
                47323.27894613025,
                48494.622608035934,
                46726.97584697682,
                45962.76893619485,
                46391.61108734224,
                46548.9279345099,
                46702.39311031018,
                46128.48699055168,
                46141.899557215744,
                46433.7135397208,
                46368.73796928371,
                46355.166739373686,
                46175.025128523965,
                46102.678346513036,
                46074.26890318738,
                45909.2292601055,
                46203.895660012866,
                46139.41480725578,
                46007.99930206061,
                45842.02365041594,
                45927.066290360795,
                46110.06506169766,
                45972.599684783585,
                45891.671730129965,
                45811.741190577406,
                45506.38701813874,
                44404.38946733802,
                43413.265939278885,
                43566.38237421859,
                43577.38563709523,
                43425.90555959927,
                43669.16611568363,
                43429.23924893638,
                42449.031592594685,
                42893.92960550481,
                42810.836828553925,
                42636.96114574562,
                42620.00689292529,
                42603.522769457115,
                42834.21512509032,
                43097.34963950681,
                43156.04413567984,
                43110.82636184149,
                43194.611850561865,
                42924.06682416366,
                42787.447482294534,
                42620.73810818898,
                42691.75401835534,
                42727.83875284763,
                42769.239279800146,
                43107.161095413874,
                42839.17992906548,
                42877.01078287877,
                42801.10412018963,
                42799.45958566227,
                42848.850175774875,
                42965.74097370059,
                42961.7203495467,
                42848.47451640749,
                42697.81035924758,
                42778.29903610591,
                42757.98342959938,
                42675.56001761096,
                42562.31132663897,
                42704.64363545284,
                42984.370023795724,
                42953.296040174224,
                43000.279740181286,
                42946.26645181208,
                42890.12463639017,
                42817.99980499583
        ]),
        priceChangePercentage24HInCurrency: 3952.64,
        currentHoldings: 1.5)
        
}
