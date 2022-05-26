//
//  Egg.swift
//  Egg Timer
//
//  Created by 홍승현 on 2022/05/26.
//

import UIKit


typealias ClockView = ClockLayer

protocol EggTimeDelegate: AnyObject {
  
  
  /// 타이머의 틱이 발생할 때마다 불려집니다.
  func timerDidChangesPerTick(_ manager: EggTimeManager, timeString: String)
  
  /// 타이머가 끝나면 이 메서드가 호출됩니다.
  func timerDone(_ manager: EggTimeManager)
  
}


class EggTimeManager {
  
  private let eggTimes = ["Soft": 4.0, "Medium": 7.0, "Hard": 12.0]
  
  /// 달걀 스케쥴 타이머
  private var timer = Timer()
  
  weak var delegate: EggTimeDelegate?
  
  
  /// 타이머 남은 시간
  private var secondsLeft = 0.0
  
  /// 타이머 남은 시간
  var timeLeft: Double {
    return secondsLeft
  }
  
  /// `분:초`  formatter
  private let dateFormatter = DateFormatter().then {
    $0.dateFormat = "mm:ss"
  }
  
  /// 타이머 남은 시간을 String으로 가져오는 프로퍼티입니다.
  var timeLeftString: String {
    return dateFormatter.string(from: Date(timeIntervalSince1970: secondsLeft))
  }
  
  
  /// 달걀의 `hardness`에 따라 타이머를 설정합니다.
  func setTimer(to hardness: String) {
    
    guard let minute = eggTimes[hardness] else { return }
    
    // 값 초기화
    timer.invalidate()
    secondsLeft = minute * 60
  }
  
  
  /// 시간에 맞춰 타이머를 설정합니다.
  func setTimer(to seconds: Double) {
    
    // 값 초기화
    timer.invalidate()
    secondsLeft = seconds
  }
  
  
  /// 타이머를 작동시킵니다.
  ///
  /// 에그 타이머를 작동시키고 싶을 때 이 메서드를 사용하세요.
  /// 만약, 타이머를 설정하지 않았다면, `setTimer(to:)` 함수를 먼저 사용한 뒤에 불러오셔야합니다.
  /// 즉, 이 메서드를 실행하기 위해서는 다음의 작업을 하셔야합니다.
  /// ```
  /// var eggTimeManager = EggTimeManager()
  ///
  /// eggTimeManager.setTimer(5) // 5초로 타이머 설정
  ///
  /// eggTimeManager.startTimer() // 타이머 시작!
  /// ```
  func startTimer() {
    
    // 타이머 설정
    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) {
      
      // 아직 타이머가 끝나지 않은 경우
      if self.secondsLeft > 0 {
        
        self.secondsLeft -= 0.01
        
        // delegate pattern
        self.delegate?.timerDidChangesPerTick(self, timeString: self.timeLeftString)
        
      } else {
        // Timer 끝!
        $0.invalidate()
        self.delegate?.timerDone(self)
      }
    }
  }
}
