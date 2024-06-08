//
//  CoordinatorProtocol.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI

protocol DestinationProtocol: Equatable {
  associatedtype Destination: View
  var content: Destination { get }
  var transition: Transition { get }
}

protocol CoordinatorProtocol: View {
  associatedtype MainContent: Coordinatable
  associatedtype Destination: DestinationProtocol
  var mainView: MainContent { get }
  var activeRoute: Destination? { get }
}

