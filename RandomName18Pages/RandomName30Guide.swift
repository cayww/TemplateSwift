import SwiftData
import SwiftUI

struct RandomName30Guide: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @State private var isLoading = false
  @State private var isAgreeEula = false
  @State private var isShowEula = false
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @StateObject private var router: RandomName16Router = RandomName16Router()
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    NavigationStack(path: $router.projectNamePath) {
      GeometryReader { geometry in
        Image("Assets/projectName_guide_bg")
          .resizable()
          .scaledToFill()
          .ignoresSafeArea()
        VStack(spacing: 0) {
          Spacer().frame(height: 10.h)
          HStack {
            Image("Assets/projectName_guide_label")
              .resizable().scaledToFit().frame(width: 87.w, height: 64.h)
            Spacer()
            Text("EULA")
              .foregroundColor(Color("fzs1"))
              .font(.system(size: 16.sp))
              .padding(.vertical, 7.h)
              .padding(.horizontal, 12.w)
              .background(.white.opacity(0.2))
              .cornerRadius(10)
              .onTapGesture {
                isShowEula = true
              }
              .padding(.top, 6.h)
          }
          .padding(.horizontal, 18.w)
          Spacer()
          Button(action: {
            if isAgreeEula {
              router.projectNamePath.append(RandomName16Route.gingFfkFidqLogin)
            } else {
              isShowEula = true
            }
          }) {
            Text("LOGIN BY EMAIL")
              .foregroundColor(.white)
              .font(.system(size: 20.sp, weight: .bold))
              .frame(maxWidth: .infinity)
          }
          .frame(height: 62.h)
          .background(
            Color("fzs1")
          )
          .cornerRadius(40.r)
          .padding(.horizontal, 73.w)
          Spacer().frame(height: 20.h)
          Button(action: {
            guard !isLoading else { return }
            guard isAgreeEula else {
              isShowEula = true
              return
            }
            let email = "vtfrvbdvtr@gmail.com"
            let newUser = RandomName3UserModel(
              userId: "u99",
              email: email,
              password: "123456789",
              avatar:
                "http://huanniuchat.oss-ap-northeast-1.aliyuncs.com/leepy/leepy_default_photo.png",
              name: "User6516",
              about: "Nothing",
              coins: 0
            )
            Task {
              await MainActor.run { isLoading = true }
              defer { isLoading = false }
              do {
                try await Task.sleep(for: .milliseconds(518))
                let descriptor = FetchDescriptor<RandomName3UserModel>(
                  predicate: #Predicate { $0.email == email }
                )
                let user = try modelContext.fetch(descriptor).first
                await MainActor.run {
                  if let user = user {
                    appState.wfzqCubCpmUser = user
                  } else {
                    modelContext.insert(newUser)
                    appState.wfzqCubCpmUser = newUser
                  }
                  appState.vkyeFxuEaaPhase = .vzxtUcsAkqqMain
                }
              } catch {
              }
            }
          }) {
            if isLoading {
              ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .frame(maxWidth: .infinity)
            } else {
              Text("I'M NEW")
                .foregroundColor(.white)
                .font(.system(size: 20.sp, weight: .bold))
                .frame(maxWidth: .infinity)
            }
          }
          .frame(height: 62.h)
          .background(
            Color("zs1")
          )
          .cornerRadius(40.r)
          .padding(.horizontal, 73.w)
          Spacer().frame(height: 10.h)
          HStack(spacing: 0) {
            Text("Don't have an account? ")
              .font(.system(size: 14.sp))
              .foregroundColor(.black)
            Text("SIGN UP")
              .font(.system(size: 14.sp, weight: .bold))
              .underline()
              .foregroundColor(.black)
              .onTapGesture {
                if isAgreeEula {
                  router.projectNamePath.append(RandomName16Route.vccMliWsyRegister)
                } else {
                  isShowEula = true
                }
              }
          }
          Spacer().frame(height: 56.h)
          HStack {
            Image(
              isAgreeEula ? "Assets/projectName_guide_checked" : "Assets/projectName_guide_uncheck"
            )
            .resizable()
            .scaledToFit()
            .frame(width: 19.r, height: 19.r)
            .onTapGesture {
              isAgreeEula.toggle()
            }
            HStack(spacing: 0) {
              Text("Agree with  ")
                .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                .font(.system(size: 14.sp))
              Text("User Agreement")
                .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                .font(.system(size: 14.sp))
                .underline()
                .onTapGesture {
                  router.projectNamePath.append(
                    RandomName16Route.wfueZroFsmnPrimary(
                      url: URL(string: "http://192.168.9.129:4000/userAgreement")!))
                }
              Text(" and ")
                .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                .font(.system(size: 14.sp))
              Text("Privacy Policy")
                .foregroundColor(Color(red: 51 / 255, green: 51 / 255, blue: 51 / 255))
                .font(.system(size: 14.sp))
                .underline()
                .onTapGesture {
                  router.projectNamePath.append(
                    RandomName16Route.wfueZroFsmnPrimary(
                      url: URL(string: "http://192.168.9.129:4000/privacyPolicy")!))
                }
            }
          }
        }
      }
      .overlay {
        if isShowEula {
          RandomName8Eula(isAgreeEula: $isAgreeEula, isShowEula: $isShowEula)
        }
      }
      .navigationDestination(for: RandomName16Route.self) { route in
        switch route {
        case .wfueZroFsmnPrimary(let url):
          RandomName27Primary(trvudfhvSsxcUrl: url)
        case .gingFfkFidqLogin:
          RandomName25Login()
        case .vccMliWsyRegister:
          RandomName20Register()
        default:
          EmptyView()
        }
      }
    }
    .environmentObject(router)
    .enableInjection()
  }
}
