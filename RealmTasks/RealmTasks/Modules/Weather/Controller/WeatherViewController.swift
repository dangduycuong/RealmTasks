//
//  WeatherViewController.swift
//  RealmTasks
//
//  Created by cuongdd on 21/04/2022.
//

import UIKit
import GoogleMaps
import DropDown
import RxSwift

class WeatherViewController: BaseViewController {
    let mapTypeMenuButton = UIButton()
    let customSegmentedView = CustomSegmentedControlView()
    
    private lazy var explainView: ExplainContentView = {
       let view = ExplainContentView()
        return view
    }()
    
    var addressLabel = UILabel()
    var mapView = GMSMapView()
    var mapCenterPinImage = UIImageView()
    var weatherInfoView = UIView()
    
    var locationLabel = UILabel()
    var timeConditionLabel = UILabel()
    var weatherIconImageView = UIImageView()
    var tempCLabel = UILabel()
    
    var feelslikeCLabel = UILabel()
    var humidityLabel = UILabel()
    var windkphLabel = UILabel()
    var conditionTextLabel = UILabel()
    
    let targetView = UIView()
    
    private var searchedTypes = ["bakery", "bar", "cafe", "grocery_or_supermarket", "restaurant"]
    private let locationManager = CLLocationManager()
    private let dataProvider = GoogleDataProvider()
    private let searchRadius: Double = 1000
    
    var viewModel = WeatherViewModel()
    var timer = Timer()
    private var weatherType: WeatherSegmentedType = WeatherSegmentedType.map
    var lastContentOffset: CGFloat = 0
    
    override func loadView() {
        super.loadView()
        prepareForViewController()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addObserver()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(with: WeatherTableViewCell.self)
        viewModel.tabSelected.accept(weatherType)
        customSegmentedView.setDefaultValue(0)
        updateUI(0)
        viewModel.readJSONFile(forName: "Weather")
        NotificationCenter.default.addObserver(self, selector: #selector(changeMapType), name: .changeMapType, object: nil)
        
        locationManager.delegate = self
        
        DispatchQueue.main.async {
            self.requestPermissonLocationServices()
        }
        
        viewModel.delegate = self
        mapView.delegate = self
        mapView.mapType = .satellite
        mapView.animate(toZoom: 17)
    }
    
    private func prepareForViewController() {
        addBackground()

        view.layout(mapView)
            .topSafe()
            .left()
            .bottomSafe()
            .right()
        
        addTitle(title: "Thời Tiết")
        
        view.layout(customSegmentedView)
            .below(titleLabel, 32)
            .left(16).right(16).height(40)
        customSegmentedView.setNewValue(WeatherSegmentedType.all.map { $0.title })
        customSegmentedView.updateColor(UIColor.black)
        
        view.layout(searchView)
            .below(customSegmentedView, 16).left(16).right(16).height(40)
        
        view.layout(tableView)
            .below(searchView, 16).left().bottomSafe().right()
        
        targetView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        targetView.layer.borderWidth = 1
        targetView.layer.borderColor = UIColor.white.cgColor
        view.layout(targetView)
            .center(mapView)
            .width(40)
            .height(40)
        targetView.layer.cornerRadius = 20
        
        let dotView = UIView()
        targetView.layout(dotView)
            .center().width(4).height(4)
        dotView.backgroundColor = UIColor.white
        dotView.layer.cornerRadius = 2
        
        view.layout(addressLabel)
            .below(targetView, 8)
            .left(16)
            .right(16)
            .height(40)
        
        addressLabel.textColor = UIColor.black
        addressLabel.backgroundColor = UIColor.white
        addressLabel.layer.cornerRadius = 4
        
        let vStackView = UIStackView()
        vStackView.axis = .vertical
        vStackView.spacing = 8
        vStackView.alignment = .fill
        vStackView.distribution = .fill
        
        weatherInfoView.layer.shadowColor = UIColor.black.cgColor
        weatherInfoView.layer.shadowOpacity = 0.35
        weatherInfoView.layer.shadowOffset = .zero
        weatherInfoView.layer.shadowRadius = 2
        weatherInfoView.layer.cornerRadius = 4
        view.layout(weatherInfoView)
            .below(customSegmentedView, 16)
            .left(16)
        weatherInfoView.backgroundColor = UIColor.white
        
        weatherInfoView.layout(vStackView)
            .top(8)
            .left(8)
            .bottom(8)
            .right(8)
        
        vStackView.addArrangedSubview(locationLabel)
        vStackView.addArrangedSubview(timeConditionLabel)
        vStackView.addArrangedSubview(tempCLabel)
        vStackView.addArrangedSubview(feelslikeCLabel)
        
        vStackView.addArrangedSubview(humidityLabel)
        vStackView.addArrangedSubview(windkphLabel)
        vStackView.addArrangedSubview(conditionTextLabel)
        
        locationLabel.font = R.font.playfairDisplayBold(size: 20)
        timeConditionLabel.font = R.font.playfairDisplayMedium(size: 20)
        tempCLabel.font = R.font.playfairDisplayMedium(size: 20)
        feelslikeCLabel.font = R.font.playfairDisplayMedium(size: 20)
        
        humidityLabel.font = R.font.playfairDisplayMedium(size: 20)
        windkphLabel.font = R.font.playfairDisplayMedium(size: 20)
        conditionTextLabel.font = R.font.playfairDisplayMedium(size: 20)
        
        locationLabel.textColor = UIColor.black
        timeConditionLabel.textColor = UIColor.black
        tempCLabel.textColor = UIColor.black
        feelslikeCLabel.textColor = UIColor.black
        
        humidityLabel.textColor = UIColor.black
        windkphLabel.textColor = UIColor.black
        conditionTextLabel.textColor = UIColor.black
        
        view.layout(explainView)
            .left()
            .bottomSafe()
            .right()
        
        let hight = NSLayoutConstraint(item: explainView, attribute: .height, relatedBy: .greaterThanOrEqual, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40)
        explainView.addConstraints([hight])
        explainView.translatesAutoresizingMaskIntoConstraints = false
        
        setupMenuButtonMapType()
    }
    
    private func addObserver() {
        customSegmentedView.segmentedControlValue = { index in
            self.updateUI(index)
        }
        viewModel.fetchedWeatherDataSource.skip(1).observeOn(MainScheduler.instance).subscribe(onNext: { [weak self] list in
            guard let `self` = self else { return }
            self.tableView.reloadData()
        }).disposed(by: disposeBag)
        
        searchView.searchText = { text in
            self.viewModel.searchText = text
        }
    }
    
    private func updateUI(_ index: Int) {
        self.weatherType = WeatherSegmentedType.all[index]
        self.viewModel.tabSelected.accept(self.weatherType)
        self.tableView.isHidden = self.weatherType == .map
        self.searchView.isHidden = self.weatherType == .map
        self.weatherInfoView.isHidden = !(self.weatherType == .map)
        explainView.isHidden = true
        mapView.isHidden = !(weatherType == .map)
        addressLabel.isHidden = !(weatherType == .map)
        targetView.isHidden = !(weatherType == .map)
        mapTypeMenuButton.isHidden = !(weatherType == .map)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: .changeMapType, object: nil)
    }
}

// MARK: - Lifecycle
extension WeatherViewController {
    
    private func requestPermissonLocationServices() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager.requestLocation()
                    self.mapView.isMyLocationEnabled = true
                    self.mapView.settings.myLocationButton = true
                }
            } else {
                self.locationManager.requestWhenInUseAuthorization()
            }
        }
    }
    
    @objc func timerAction() {
        viewModel.realtimeWeather()
    }
    
    private func setupMenuButtonMapType() {
        let mapTypeImageView = UIImageView(image: R.image.icons8Menu_rounded()?.withRenderingMode(.alwaysTemplate))
        mapTypeImageView.tintColor = UIColor.black
        
        view.layout(mapTypeMenuButton)
            .centerY(titleLabel).right(16).width(40).height(40)
        
        mapTypeMenuButton.layout(mapTypeImageView)
            .right().centerY().width(24).height(24)
        
        mapTypeMenuButton.addTarget(self, action: #selector(updateMapType), for: .touchUpInside)
    }
    
    @objc private func updateMapType(_ sender: UIButton) {
        let dropDown = DropDown()
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.random
        if let font = PlayfairDisplayFont.semiBold(with: 20) {
            DropDown.appearance().textFont = font
        }
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.random
        DropDown.appearance().cellHeight = 60
        
        DropDown.startListeningToKeyboard()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = view // UIView or UIBarButtonItem
        
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: UIScreen.main.bounds.width - 118, y: view.safeAreaInsets.top + 44)
        dropDown.width = 110
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = MapType.all.map { $0.text }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            var mapType = GMSMapViewType.normal
            switch MapType.all[index] {
            case .normal:
                mapType = .normal
            case .satellite:
                mapType = .satellite
            case .terrain:
                mapType = .terrain
            case .hybrid:
                mapType = .hybrid
            case .noneNormal:
                mapType = .none
            }
            mapView.mapType = mapType
            mapView.animate(toZoom: 17)
        }
        
        dropDown.show()
    }
    
    @objc private func changeMapType(notification: Notification) {
        //        guard let isConnect = notification.userInfo?["key"] as? Bool else {
        //            return
        //        }
        let dropDown = DropDown()
        
        DropDown.appearance().textColor = UIColor.black
        DropDown.appearance().selectedTextColor = UIColor.random
        if let font = PlayfairDisplayFont.semiBold(with: 20) {
            DropDown.appearance().textFont = font
        }
        DropDown.appearance().backgroundColor = UIColor.white
        DropDown.appearance().selectionBackgroundColor = UIColor.random
        DropDown.appearance().cellHeight = 60
        
        DropDown.startListeningToKeyboard()
        
        // The view to which the drop down will appear on
        dropDown.anchorView = view // UIView or UIBarButtonItem
        
        dropDown.direction = .bottom
        dropDown.bottomOffset = CGPoint(x: UIScreen.main.bounds.width - 118, y: 8)
        dropDown.width = 110
        
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = MapType.all.map { $0.text }
        
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            var mapType = GMSMapViewType.normal
            switch MapType.all[index] {
            case .normal:
                mapType = .normal
            case .satellite:
                mapType = .satellite
            case .terrain:
                mapType = .terrain
            case .hybrid:
                mapType = .hybrid
            case .noneNormal:
                mapType = .none
            }
            mapView.mapType = mapType
            mapView.animate(toZoom: 17)
        }
        
        dropDown.show()
    }
    
    //  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //    guard
    //      let navigationController = segue.destination as? UINavigationController,
    //      let controller = navigationController.topViewController as? TypesTableViewController
    //      else {
    //        return
    //    }
    //    controller.selectedTypes = searchedTypes
    //    controller.delegate = self
    //  }
    
    
}

// MARK: - Actions
extension WeatherViewController {
    @IBAction func refreshPlaces(_ sender: Any) {
        fetchPlaces(near: mapView.camera.target)
    }
    
    func fetchPlaces(near coordinate: CLLocationCoordinate2D) {
        mapView.clear()
        
        dataProvider.fetchPlaces(
            near: coordinate,
            radius: searchRadius,
            types: searchedTypes
        ) { places in
            places.forEach { place in
                let marker = PlaceMarker(place: place, availableTypes: self.searchedTypes)
                marker.map = self.mapView
            }
        }
    }
    
    func reverseGeocode(coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            self.addressLabel.unlock()
            
            guard
                let address = response?.firstResult(),
                let lines = address.lines
            else {
                return
            }
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 6
            paragraphStyle.firstLineHeadIndent = 8
            
            let attributes: [NSAttributedString.Key: Any] = [
                .font: R.font.playfairDisplayMedium(size: 20) as Any,
                .foregroundColor: UIColor.black,
                .paragraphStyle: paragraphStyle
            ]
            let place = lines.joined(separator: "\n")
            self.addressLabel.attributedText = NSAttributedString(string: place, attributes: attributes)
            
            let labelHeight = self.addressLabel.intrinsicContentSize.height
            let topInset = self.view.safeAreaInsets.top
            self.mapView.padding = UIEdgeInsets(
                top: topInset,
                left: 0,
                bottom: labelHeight,
                right: 0)
            
            UIView.animate(withDuration: 0.25) {
//                self.pinImageVerticalConstraint.constant = (labelHeight - topInset) * 0.5
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - TypesTableViewControllerDelegate
//extension WeatherViewController: TypesTableViewControllerDelegate {
//  func typesController(_ controller: TypesTableViewController, didSelectTypes types: [String]) {
//    searchedTypes = controller.selectedTypes.sorted()
//    dismiss(animated: true)
//    fetchPlaces(near: mapView.camera.target)
//  }
//}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard status == .authorizedWhenInUse else {
            return
        }
        
        locationManager.requestLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        mapView.camera = GMSCameraPosition(
            target: location.coordinate,
            zoom: 17,
            bearing: 0,
            viewingAngle: 0)
        fetchPlaces(near: location.coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

// MARK: - GMSMapViewDelegate
extension WeatherViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocode(coordinate: position.target)
        viewModel.cocationCoordinate = position.target
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: false)
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        timer.invalidate()
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        addressLabel.lock()
        
        if gesture {
            mapCenterPinImage.fadeIn(0.25)
            mapView.selectedMarker = nil
        }
    }
    
    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard let placeMarker = marker as? PlaceMarker else {
            return nil
        }
        guard let infoView = UIView.viewFromNibName("MarkerInfoView") as? MarkerInfoView else {
            return nil
        }
        
        infoView.nameLabel.text = placeMarker.place.name
        infoView.addressLabel.text = placeMarker.place.address
        
        return infoView
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapCenterPinImage.fadeOut(0.25)
        return false
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        mapCenterPinImage.fadeIn(0.25)
        mapView.selectedMarker = nil
        mapView.animate(toZoom: 17)
        viewModel.realtimeWeather()
        return false
    }
}

extension WeatherViewController: WeatherViewModelDelegate {
    func updateData(model: TransModel) {
        DispatchQueue.main.async {
            self.fillData(model: model)
        }
    }
    
    private func fillData(model: TransModel) {
        weatherInfoView.isHidden = false
        locationLabel.text = model.address
        timeConditionLabel.text = model.lastUpdated
        if let tempC = model.tempC {
            tempCLabel.text = "\(tempC) °C"
        }
        
        if let feelsLike = model.feelsLike {
            feelslikeCLabel.text = "\(feelsLike) °C"
        }
        
        if let humidity = model.humidity {
            humidityLabel.text = "\(humidity) %"
        }
        
        if let wind = model.wind {
            windkphLabel.text = "\(wind) Kph"
        }
        
        if let text = model.text {
            conditionTextLabel.text = text
        }
    }
}

extension WeatherViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.fetchedWeatherDataSource.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: WeatherTableViewCell.self, forIndexPath: indexPath)
        let data = viewModel.fetchedWeatherDataSource.value[indexPath.row]
        cell.fillData(content: data.content, isShowing: data.isShowing, searchText: viewModel.searchText, color: UIColor.black)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updateShowingItem(indexPath.row)
        explainView.isHidden = false
        explainView.fillData(viewModel.fetchedWeatherDataSource.value[indexPath.row].explain)
    }
    
}

extension WeatherViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.lastContentOffset = scrollView.contentOffset.y
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if self.lastContentOffset < scrollView.contentOffset.y {
            print("---- did move up")
            // did move up
            explainView.isHidden = true
        } else if self.lastContentOffset > scrollView.contentOffset.y {
            print("---- did move down")
            // did move down
        } else {
            print("---- didn't move")
            // didn't move
        }
    }
}

