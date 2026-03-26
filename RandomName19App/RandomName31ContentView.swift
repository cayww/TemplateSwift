import SwiftData
import SwiftUI

struct RandomName31ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var appState: RandomName32State
  var body: some View {
    ZStack {
      switch appState.vkyeFxuEaaPhase {
      case .nipjSeaNvbSplash:
        RandomName29Splash()
      case .asqLicvGlkGuide:
        RandomName30Guide()
      case .vzxtUcsAkqqMain:
        RandomName23Main()
      }
      VStack {
        MzyhRcjWazgToastView()
        Spacer()
      }
      .ignoresSafeArea()
    }
  }
}
