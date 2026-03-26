import SwiftData
import SwiftUI

struct RandomName23Main: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @StateObject private var router: RandomName16Router = RandomName16Router()

  enum Tab: Hashable {
    case home
    case found
    case message
    case profile
  }

  @State private var selectedTab: Tab = .home
  init() {
    UITabBar.appearance().isHidden = true
    UINavigationBar.appearance().scrollEdgeAppearance = .none
  }
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    NavigationStack(path: $router.projectNamePath) {
      TabView(selection: $selectedTab) {
        RandomName28Home()
          .tag(Tab.home)
        RandomName24Found()
          .tag(Tab.found)
        RandomName26Message()
          .tag(Tab.message)
        RandomName21Profile()
          .tag(Tab.profile)
      }
      .navigationDestination(for: RandomName16MainRoute.self) { route in
        switch route {
        case .wfueZroFsmnPrimary(let url):
          RandomName27Primary(trvudfhvSsxcUrl: url)
        }
      }
      .safeAreaInset(edge: .bottom) {
        HStack(spacing: 0) {
          Image(selectedTab == .home ? "Assets/projectName_home_a" : "Assets/projectName_home_u")
            .resizable()
            .scaledToFit()
            .frame(width: 24.r, height: 24.r)
            .onTapGesture {
              selectedTab = .home
            }
          Spacer()
          Image(selectedTab == .found ? "Assets/projectName_found_a" : "Assets/projectName_found_u")
            .resizable()
            .scaledToFit()
            .frame(width: 24.r, height: 24.r)
            .onTapGesture {
              selectedTab = .found
            }
          Spacer()
          Image(selectedTab == .message ? "Assets/projectName_msg_a" : "Assets/projectName_msg_u")
            .resizable()
            .scaledToFit()
            .frame(width: 24.r, height: 24.r)
            .onTapGesture {
              selectedTab = .message
            }
          Spacer()
          Image(
            selectedTab == .profile
              ? "Assets/projectName_profile_a" : "Assets/projectName_profile_u"
          )
          .resizable()
          .scaledToFit()
          .frame(width: 24.r, height: 24.r)
          .onTapGesture {
            selectedTab = .profile
          }
        }
        .padding(.horizontal, 30.w)
        .frame(maxWidth: .infinity)
        .frame(height: 73.h)
        .background(
          .white.opacity(0.2)
        )
        .background(.ultraThinMaterial)
        .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 2)
        .cornerRadius(48)
        .padding(.horizontal, 20.w)
      }
    }
    .environmentObject(router)
    .enableInjection()
  }
}
