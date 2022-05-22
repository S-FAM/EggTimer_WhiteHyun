import Foundation

extension UserDefaults {
  
  /// UserDefaults에서 사용되는 `Custom Key` 입니다.
  enum Keys {
    
    /// 시계를 변경할 때 사용되는 키 값입니다.
    static let switchClock         = "switchClockKey"
    
    
    /// 앱이 백그라운드로 들어가고 나서 시간을 저장할 때 사용되는 키 값입니다.
    static let didEnterBackgroundDate     = "didEnterBackgroundDate"
    
  }
  
}
