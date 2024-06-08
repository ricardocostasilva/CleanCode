//
//  AppDependencyContainer.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation

protocol DIContainerProtocol {
  func register<Service>(type: Service.Type, component: Any)
  func inject<Service>(type: Service.Type) -> Service?
}

final class DIContainer: DIContainerProtocol {

  static let shared = DIContainer()

  private init() {}

  var services: [String: Any] = [:]

    func register<Service>(type: Service.Type, component service: Any) {
      services["\(type)"] = service
  }

  func inject<Service>(type: Service.Type) -> Service? {
    return services["\(type)"] as? Service
  }
}

