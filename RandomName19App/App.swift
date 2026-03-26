@_exported import HotSwiftUI
import SwiftData
import SwiftUI

@main
struct ProjectNameApp: App {
  let container: ModelContainer
  @StateObject private var appState = RandomName32State()
  @StateObject private var purchaseManager = RandomName14Purchase()
  init() {
    let appearance = UITabBarAppearance()
    appearance.configureWithTransparentBackground()
    appearance.backgroundEffect = nil
    appearance.backgroundColor = .clear
    UITabBar.appearance().backgroundColor = .clear
    UITabBar.appearance().standardAppearance = appearance
    UITabBar.appearance().scrollEdgeAppearance = appearance
    #if DEBUG
      Bundle(path: "/Applications/InjectionIII.app/Contents/Resources/iOSInjection.bundle")?.load()
      if let path = Bundle.main.path(
        forResource:
          "iOSInjection", ofType: "bundle")
      {
        Bundle(path: path)!.load()
      }
    #endif
    RandomName12ScreenUtil.shared.updateSize()
    do {
      container =
        try ModelContainer(
          for:
            RandomName33ChatModel.self,
          RandomName5MessageModel.self,
          RandomName3UserModel.self,
          RandomName4CommentModel.self,
          RandomName2DynamicModel.self,
        )
    } catch {
      fatalError("\(error)")
    }
  }

  var body: some Scene {
    WindowGroup {
      RandomName31ContentView()
        .task {
          bootstrapIfNeeded(context: container.mainContext)
        }
        .environmentObject(appState)
        .environmentObject(purchaseManager)
    }
    .modelContainer(container)
  }
}
