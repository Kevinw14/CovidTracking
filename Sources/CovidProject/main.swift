import TSCUtility
import TSCBasic
import Foundation
import Alamofire

class Main: NSObject, URLCovidRequestDelegate {
    
    private let request: URLCovidRequest!
    private let animation: PercentProgressAnimation!
    private var totalCompleted: Int = 1
    
    override init() {
        self.request = URLCovidRequest()
        self.animation = PercentProgressAnimation(stream: stdoutStream, header: "Downloading Covid Statistics")
        
        super .init()
        for state in Stat.State.allCases {
            downloadData(state: state)
        }
        
        animation.complete(success: true)
    }
    
    func downloadData(state: Stat.State) {
        request.delegate = self
        request.data(state: state)
    }
    
    func urlCovidRequestDataReceived(request: DataRequest, data: Data, state: Stat.State) {
        do {
            var stats: [Stat] = try JSONDecoder().decode([Stat].self, from: data)
            var everyTwoWeeks: [Stat] = []
            
            for stat in stats {
                if stat.date.isLastDate || stat.date.isTwoWeeksIn {
                    everyTwoWeeks.append(stat)
                }
            }
            
            stats = everyTwoWeeks
            stats.sort(by: {$0.date < $1.date})
            let url = URL(fileURLWithPath: "./statistics/\(state.rawValue).json")
            let data: Data = try JSONEncoder().encode(stats)
            try data.write(to: url)
        } catch {
            print(error.localizedDescription)
        }
        
        self.totalCompleted += 1
    }
    
    func urlCovidRequestErrorReceived(request: DataRequest, error: Error) {
        print("Error getting data")
    }
    
    func urlCovidRequestProgress(requst: DataRequest, progress: Double, state: Stat.State) {
        
        animation.update(step: totalCompleted, total: Stat.State.allCases.count, text: "Downloading \(state.rawValue)")
    }
}

let _ = Main()
