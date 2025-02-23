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
    func updateData(model: TransModel)
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
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        
        let target = WeatherEndpoint.realtimeWeather(queryItems: queryItems)
        APIClient.shared.callApi(target: target) { (model: RealtimeWeather) in
            self.weather = model
            self.translateJSON(weather: self.weather)
        }
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
    
    func getBody() -> LangueRequestModel {
        let address = weather?.location?.name ?? ""
        let lastUpdated = weather?.current?.lastUpdated ?? ""
        let tempC = weather?.current?.tempC?.toString() ?? ""
        let feelsLike = "Feels like \(weather?.current?.feelslikeC ?? 0)"
        let humidity = "Humidity \(weather?.current?.humidity ?? 0)"
        let wind = "Wind \(weather?.current?.windKph ?? 0)"
        let text = weather?.current?.condition?.text ?? ""
        
        let content = Content(
            address: address,
            lastUpdated: lastUpdated,
            tempC: tempC,
            feelsLike: feelsLike,
            humidity: humidity,
            wind: wind,
            text: text)
        
        return LangueRequestModel(
            protectedPaths: ["extra.last_comment.author"],
            from: "auto",
            json: content,
            to: "vi",
            commonProtectedPaths: ["image"])
    }
    
    func translateJSON(weather: RealtimeWeather?) {
        let requestModel = getBody()
        
        let target = TranslateEndpoint.translateJSON(model: requestModel)
        APIClient.shared.callApi(target: target) { (model: LanguageResponseModel) in
            if let trans = model.trans {
                self.delegate?.updateData(model: trans)
            }
        }
    }
}
