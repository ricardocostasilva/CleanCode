//
//  AppRouter.swift
//  CleanCodeTest
//
//  Created by ricardo silva on 27/04/2024.
//

import Foundation
import SwiftUI

enum Transition {
  case push
}

struct AppRouter<Destination: DestinationProtocol>: ViewModifier {

  @Binding var destination: Destination?
  @State var isLinkActive = false

  func body(content: Content) -> some View {
    ZStack {
      NavigationLink(
        destination: destinationView,
        isActive: $isLinkActive, label: {})
      content
    }.onChange(of: destination, { _, _ in
         routeChanged()
     })
     .onChange(of: isLinkActive) { _, _ in
         routeDismissed()
     }
  }

  var destinationView: some View {
    destination?.content
  }

  func routeDismissed() {
    if !isLinkActive {
      destination = nil
    }
  }

  func routeChanged() {
    guard let destination = destination else { return }
    isLinkActive = destination.transition == .push
  }
}

struct Navigator: ViewModifier {
  func body(content: Content) -> some View {
    NavigationView {
      content
    }
    .navigationBarColor(backgroundColor: .alpineGoat, titleColor: .black)
    .accentColor(.black)
  }
}

extension View {
  func route<Destination: DestinationProtocol>(to destination: Binding<Destination?>) -> some View {
    modifier(AppRouter(destination: destination))
  }

  func navigation() -> some View {
    modifier(Navigator())
  }
}
