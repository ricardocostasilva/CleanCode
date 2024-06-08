//
//  Coordinatable.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import SwiftUI

// implemented by routes enum inside each view
protocol Routing: Equatable {}

// implemented by the view that has routes
protocol Coordinatable: View {
  associatedtype Route: Routing
}
