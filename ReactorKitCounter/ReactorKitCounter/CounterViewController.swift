//
//  CounterViewController.swift
//  ReactorKitCounter
//
//  Created by 김태형 on 2022/10/26.
//

import UIKit
import ReactorKit
import RxCocoa

final class CounterViewController: UIViewController, StoryboardView {
  @IBOutlet private var decreaseButton: UIButton!
  @IBOutlet private var increaseButton: UIButton!
  @IBOutlet private var valueLabel: UILabel!
  @IBOutlet private var checkPrimeButton: UIButton!
  
  var disposeBag = DisposeBag()

  func bind(reactor: CounterViewReactor) {
    //Action
    increaseButton.rx.tap
      .map { .increase }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    decreaseButton.rx.tap
      .map { .decrease }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    checkPrimeButton.rx.tap
      .map { .checkIsPrime }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
    
    //State
    reactor.state.map { $0.value }
      .distinctUntilChanged()
      .map { "\($0)" }
      .bind(to: valueLabel.rx.text)
      .disposed(by: disposeBag)
    
    reactor.state.map { $0.isPrime }
      .distinctUntilChanged()
      .compactMap { $0 }
      .flatMap { [weak self] isPrime -> Observable<Int> in
        guard let self = self else { return .just(1) }
        return UIAlertController.present(
          in: self,
          title: "isPrime?",
          message: "\(isPrime)",
          style: .alert,
          actions: [ .action(title: "확인", style: .default)]
        )
      }
      .filter { $0 == 0 }
      .map { _ in .tappedCloseAlert }
      .bind(to: reactor.action)
      .disposed(by: disposeBag)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  func showAlert(_ title: String, _ message: String) {
    let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let okayAction = UIAlertAction(title: "ok", style: .default)
    alertViewController.addAction(okayAction)
      
    self.present(alertViewController, animated: true)
  }
}
