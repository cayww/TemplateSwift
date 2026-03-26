import Combine
import SwiftUI

enum RandomName16Phase: Hashable {
  case nipjSeaNvbSplash
  case asqLicvGlkGuide
  case vzxtUcsAkqqMain
}

enum RandomName16Route: Hashable {
  case asqLicvGlkGuide
  case gingFfkFidqLogin
  case vccMliWsyRegister
  case wfueZroFsmnPrimary(url: URL)
}

enum RandomName16MainRoute: Hashable {
  case wfueZroFsmnPrimary(url: URL)
}

class RandomName16Router: ObservableObject {
  @Published var projectNamePath = NavigationPath()
}
