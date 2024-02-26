//
//  WeatherViewModel.swift
//  RealmTasks
//
//  Created by cuongdd on 23/04/2022.
//

import Foundation
import GoogleMaps
import RxRelay
import RxSwift

protocol WeatherViewModelDelegate: AnyObject {
    func updateData(weather: RealtimeWeather)
}

class BaseViewModel {
    let disposeBag = DisposeBag()
}

class WeatherViewModel: BaseViewModel {
    
    var fetchedWeatherDataSource = BehaviorRelay<[WeatherContentModel]>(value: [])
    var cocationCoordinate = CLLocationCoordinate2D()
    var weather: RealtimeWeather?
    weak var delegate: WeatherViewModelDelegate?
    var folksModel = [WeatherContentModel]()
    var proverbsModel = [WeatherContentModel]()
    var tabSelected = BehaviorRelay<WeatherSegmentedType>(value: .map)
    
    override init() {
        super.init()
        tabSelected.subscribe(onNext: { [weak self] type in
            guard let `self` = self else { return }
            switch type {
            case .map:
                break
            case .folk:
                fetchedWeatherDataSource.accept(folksModel)
            case .proverb:
                fetchedWeatherDataSource.accept(proverbsModel)
            }
        }).disposed(by: disposeBag)
    }
    
    var searchText: String? = "" {
        didSet {
            filterText(searchText)
        }
    }
    
    private func filterText(_ searchText: String?) {
        var list = [WeatherContentModel]()
        if tabSelected.value == .folk {
            list = filterByText(searchText: searchText, sourceList: folksModel)
        } else if tabSelected.value == .proverb {
            list = filterByText(searchText: searchText, sourceList: proverbsModel)
        }
        fetchedWeatherDataSource.accept(list)
    }
    
    private func filterByText(searchText: String?, sourceList: [WeatherContentModel]) -> [WeatherContentModel] {
        let keyWord: String = (searchText ?? "").lowercased().unaccent()
        
        if keyWord == "" {
            return sourceList
        }
        
        var list = [WeatherContentModel]()
        
        list = sourceList.filter { (weather: WeatherContentModel) in
            let content = weather.content?.lowercased().unaccent()
            let explain = weather.explain?.lowercased().unaccent()
            if content?.range(of: keyWord) != nil {
                return true
            }
            if explain?.range(of: keyWord) != nil {
                return true
            }
            return false
        }
        return list
    }
    
    func updateShowingItem(_ selectedIndex: Int) {
        var array = fetchedWeatherDataSource.value
        for i in 0..<array.count {
            array[i].isShowing = i == selectedIndex
        }
        fetchedWeatherDataSource.accept(array)
    }
    
    func realtimeWeather() {
        let latitude = cocationCoordinate.latitude
        let longitude = cocationCoordinate.longitude
        let double = latitude
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let number =  numberFormatter.string(from: NSNumber(value: double)) else { fatalError("Can not get number") }
        print("\(number)")
        
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        var urlComponents = URLComponents(string: "https://weatherapi-com.p.rapidapi.com")
        urlComponents?.path = "/current.json"
        urlComponents?.queryItems = urlQueryItem
        guard let url = urlComponents?.url else { return }
        let headers = [
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa"
        ]
        
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            print("params", urlQueryItem)
            if (error != nil) {
                print(error as Any)
            } else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 {
                }
                print(httpResponse as Any)
            }
            do {
                if let data = data {
                    data.printFormatedJSON()
                    let json = try JSONDecoder().decode(RealtimeWeather.self, from: data)
                    self.weather = json
                    self.delegate?.updateData(weather: json)
                }
            } catch let error {
                print(error)
            }
        })
        dataTask.resume()
    }
    
    func readJSONFile(forName name: String) {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                let weatherModel = try? JSONDecoder().decode(WeatherModel.self, from: jsonData)
                if let folks = weatherModel?.folks {
                    self.folksModel = folks
                }
                if let proverbs = weatherModel?.proverbs {
                    self.proverbsModel = proverbs
                }
                if let json = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String: Any] {
                    print("JSON: \(json)")
                } else {
                    print("Given JSON is not a valid dictionary object.")
                }
            }
        } catch {
            print(error)
        }
    }
}

