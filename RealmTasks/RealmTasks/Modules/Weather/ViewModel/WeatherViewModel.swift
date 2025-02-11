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
    
    private func createURL() -> URL {
        let latitude = cocationCoordinate.latitude
        let longitude = cocationCoordinate.longitude
        let double = latitude
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let number =  numberFormatter.string(from: NSNumber(value: double)) else { fatalError("Can not get number") }
        print("\(number)")
        
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "weatherapi-com.p.rapidapi.com"
        urlComponents.path = "/current.json"
        let urlQueryItem: [URLQueryItem] = [
            URLQueryItem(name: "q", value: "\(latitude),\(longitude)")
        ]
        urlComponents.queryItems = urlQueryItem
        guard let url = urlComponents.url else {
            fatalError("URL not found")
        }
        return url
    }
    
    private func createURLRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        let headers = [
            "X-RapidAPI-Host": "weatherapi-com.p.rapidapi.com",
            "X-RapidAPI-Key": "fb71aa7f62msh153e4924e940392p16bbc4jsn166248f8bdaa"
        ]
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
    }
    
    func realtimeWeather() {
        let url = createURL()
        let request = createURLRequest(url: url)
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            print("====CURL:\n", request.cURL())
            if let error = error as? URLError {
                print("error code: ", error.code)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: ", httpResponse.statusCode) // httpResponse as Any
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(RealtimeWeather.self, from: data)
                self.weather = json
                self.translateJSON(weather: self.weather)
            } catch let error {
                print(error)
            }
        }
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
        let headers = [
            "x-rapidapi-key": "b266514becmsh63278b22c117acfp12ef2cjsn7a142a5dffa4",
            "x-rapidapi-host": "google-translate113.p.rapidapi.com",
            "Content-Type": "application/json"
        ]
        
        guard let url = URL(string: "https://google-translate113.p.rapidapi.com/api/v1/translator/json") else { return }
        var request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        do {
            let requestModel = getBody()
            let postData = try JSONEncoder().encode(requestModel)
            request.httpBody = postData
        } catch {}
        
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            print("====cURL:\n", request.cURL())
            if let error = error as? URLError {
                print(error.errorCode)
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            guard let data = data else { return }
            do {
                let json = try JSONDecoder().decode(LanguageResponseModel.self, from: data)
                if let trans = json.trans {
                    self.delegate?.updateData(model: trans)
                }
            } catch {}
        }
        
        dataTask.resume()
    }
}
