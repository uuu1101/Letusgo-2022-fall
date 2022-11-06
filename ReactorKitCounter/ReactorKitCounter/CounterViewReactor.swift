//
//  CounterViewReactor.swift
//  ReactorKitCounter
//
//  Created by 김태형 on 2022/10/26.
//

import ReactorKit
import RxSwift

final class CounterViewReactor: Reactor {
  enum Action {
    case increase
    case decrease
    case checkIsPrime
    case tappedCloseAlert
  }
  
  enum Mutation {
    case increaseValue
    case decreaseValue
    case checkIsPrime
    case resetIsPrime
  }
  
  struct State {
    var value: Int = 0
    var isPrime: Bool? = nil
  }
  
  let initialState: State = State()
  
  func mutate(action: Action) -> Observable<Mutation> {
    switch action {
    case .increase:
      return Observable.just(Mutation.increaseValue)
      
    case .decrease:
      return Observable.just(Mutation.decreaseValue)
      
    case .checkIsPrime:
      return Observable.just(Mutation.checkIsPrime)
      
    case .tappedCloseAlert:
      return Observable.just(Mutation.resetIsPrime)
    }
  }
  
  func reduce(state: State, mutation: Mutation) -> State {
    var newState = state
    switch mutation {
    case .increaseValue:
      newState.value += 1
    
    case .decreaseValue:
      newState.value -= 1
      
    case .checkIsPrime:
      newState.isPrime = isPrime(newState.value)
      
    case .resetIsPrime:
      newState.isPrime = nil
    }
    return newState
  }
  
  private func isPrime (_ p: Int) -> Bool {
    if p <= 1 { return false }
    if p <= 3 { return true }
    for i in 2...Int(sqrtf(Float(p))) {
      if p % i == 0 { return false }
    }
    return true
  }
}
