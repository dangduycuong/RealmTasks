//
//  CLLocationCoordinate+Extensions.swift
//  RealmTasks
//
//  Created by cuongdd on 22/04/2022.
//

import CoreLocation

extension CLLocationCoordinate2D: CustomStringConvertible {
  public var description: String {
    let lat = String(format: "%.6f", latitude)
    let lng = String(format: "%.6f", longitude)
    return "\(lat),\(lng)"
  }
}
