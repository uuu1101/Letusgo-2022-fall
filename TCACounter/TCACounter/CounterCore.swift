//
//  CounterCore.swift
//  TCACounter
//
//  Created by 김태형 on 2022/10/25.
//

import ComposableArchitecture
import Combine

struct CounterState: Equatable {
  var value: Int = 0
  var primeState: PrimeState = .init()
  var showAlert = false
}

enum CounterAction {
  //User Action
  case increaseButtonTapped
  case decreaseButtonTapped
  case isPrimeButtonTapped
  case primeAction(PrimeAction)
  
  //Inner Action
  case _increaseValue
  case _decreaseValue
  case _showAlert(Bool)
}

struct CounterEnvironment {
  init() {}
}

let counterReducer =
AnyReducer<CounterState, CounterAction, CounterEnvironment>.combine([
  primeReducer
    .pullback(
      state: \.primeState,
      action: /CounterAction.primeAction,
      environment: { _ in PrimeEnvironment() }
    ),
  AnyReducer<CounterState, CounterAction, CounterEnvironment> {
    state, action, env in
    switch action {
    case .increaseButtonTapped:
      return Effect(value: ._increaseValue)
      
    case .decreaseButtonTapped:
      return Effect(value: ._decreaseValue)
      
    case ._increaseValue:
      state.value += 1
      return .none
      
    case ._decreaseValue:
      state.value -= 1
      return .none
      
    case .isPrimeButtonTapped:
      return Effect.concatenate([
        Effect(value: .primeAction(._checkIsPrime(state.value))),
        Effect(value: ._showAlert(true))
      ])
      
    case let ._showAlert(showAlert):
      state.showAlert = showAlert
      return .none
    
    case .primeAction:
      return .none
    }
  }
])
