//
//  TCACounterApp.swift
//  TCACounter
//
//  Created by κΉνν on 2022/10/25.
//

import ComposableArchitecture
import SwiftUI

@main
struct TCACounterApp: App {
  let store: Store<CounterState, CounterAction> = .init(
    initialState: CounterState(value: 0, primeState: .init()),
         reducer: counterReducer,
         environment: CounterEnvironment()
     )
    var body: some Scene {
        WindowGroup {
          CounterView(store: store)
        }
    }
}
