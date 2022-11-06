//
//  PrimeCore.swift
//  TCACounter
//
//  Created by 김태형 on 2022/10/25.
//

import Combine
import ComposableArchitecture
import Foundation

struct PrimeState: Equatable {
  var isPrime: Bool = false
}

enum PrimeAction {
  //User Action
  
  //Inner Action
  case _checkIsPrime(_ value: Int)
}

struct PrimeEnvironment {
  init() {}
}

let primeReducer = AnyReducer<PrimeState, PrimeAction, PrimeEnvironment> {
  state, action, env in
  switch action {
  case let ._checkIsPrime(value):
    state.isPrime = isPrime(value)
    return .none
  }
}

private func isPrime (_ number: Int) -> Bool {
  if number <= 1 { return false }
  if number <= 3 { return true }
  for i in 2...Int(sqrtf(Float(number))) {
    if number % i == 0 { return false }
  }
  return true
}
