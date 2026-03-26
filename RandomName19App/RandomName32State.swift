import Combine
import SwiftData
import SwiftUI

@MainActor
final class RandomName32State: ObservableObject {
  @Published var wfzqCubCpmUser: RandomName3UserModel? = nil
  @Published var vkyeFxuEaaPhase: RandomName16Phase = .nipjSeaNvbSplash
  func tnngDfrhGkgtAddCoins(_ mpkVfgBazdAmount: Int) {
    guard let user = wfzqCubCpmUser else { return }
    user.coins += mpkVfgBazdAmount
  }
  func hzglZtiFzlLogout() {
    vkyeFxuEaaPhase = .asqLicvGlkGuide
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.47) {
      self.wfzqCubCpmUser = nil
    }
  }
}
