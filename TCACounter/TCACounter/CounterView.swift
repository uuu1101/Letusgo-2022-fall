//
//  CounterView.swift
//  TCACounter
//
//  Created by 김태형 on 2022/10/25.
//

import ComposableArchitecture
import SwiftUI

struct CounterView: View {
  let store: Store<CounterState, CounterAction>
  
  init(store: Store<CounterState, CounterAction>) {
    self.store = store
  }
  
  var body: some View {
    WithViewStore(store) { viewStore in
      VStack {
        HStack {
          Button("-", action: { viewStore.send(.decreaseButtonTapped) })

          Text("\(viewStore.value)")

          Button("+", action: { viewStore.send(.increaseButtonTapped) })
        }

        Button("is Prime", action: { viewStore.send(.isPrimeButtonTapped) })
      }
      .alert(
        isPresented: viewStore.binding(
          get: \.showAlert,
          send: CounterAction._showAlert
        ),
        content: {
          Alert(
            title: Text("Is this Prime?"),
            message: Text(String(viewStore.primeState.isPrime)),
            dismissButton: .default(Text("OK"))
          )
        }
      )
    }
  }
}
