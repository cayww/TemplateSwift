import Kingfisher
import SwiftData
import SwiftUI

struct RandomName26Message: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: RandomName16Router
  @Query private var chats: [RandomName33ChatModel]
  var filteredChats: [RandomName33ChatModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return []
    }
    return chats.filter {
      !blockList.contains($0.chatUserIds.first ?? "")
        && !blockList.contains($0.chatUserIds.last ?? "")
        && !$0.lastSendContent.isEmpty
        && $0.chatUserIds.contains(appState.wfzqCubCpmUser?.userId ?? "")
    }
  }
  func formatTime(_ iso: String) -> String {
    let f = ISO8601DateFormatter()
    f.formatOptions = [.withInternetDateTime, .withFractionalSeconds]

    guard let d = f.date(from: iso) else { return "" }

    let out = DateFormatter()
    out.dateFormat = "hh:mm a"
    out.locale = Locale(identifier: "en_US")

    return out.string(from: d)
  }
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Color.white.ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 10.h)
        Text("MESSAGE")
          .foregroundColor(.red)
          .font(.system(size: 24.sp, weight: .black))

          .frame(maxWidth: .infinity, alignment: .leading)
        Spacer().frame(height: 16.h)
        if filteredChats.isEmpty {
          VStack {
            Image("Assets/projectName_empty").resizable().scaledToFill().frame(
              width: 152.r, height: 152.r)
            Text("No Data")
              .font(.system(size: 16.sp))
              .foregroundColor(.black)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
          ScrollView {
            VStack {
              ForEach(filteredChats) { chat in

                let otherUserId =
                  chat.chatUserIds.filter { $0 != appState.wfzqCubCpmUser?.userId }
                  .first ?? ""
                let userDescriptor = FetchDescriptor<RandomName3UserModel>(
                  predicate: #Predicate { $0.userId == otherUserId }
                )
                if let otherUser = try? modelContext.fetch(userDescriptor).first {
                  HStack(spacing: 12.w) {
                    KFImage(URL(string: otherUser.avatar))
                      .fade(duration: 0.2)
                      .resizable()
                      .scaledToFill()
                      .frame(width: 62.r, height: 62.r)
                      .clipShape(Circle())
                      .overlay(Circle().stroke(.white.opacity(0.1), lineWidth: 4.0))
                    VStack(spacing: 5.h) {
                      HStack {
                        Text(otherUser.name)
                          .foregroundColor(.white)
                          .lineLimit(1)
                          .font(.system(size: 16.sp, weight: .bold))
                        Spacer()
                        Text(formatTime(chat.lastSendTime ?? ""))
                          .foregroundColor(.white.opacity(0.6))
                          .lineLimit(1)
                          .font(.system(size: 10.sp, weight: .semibold))
                      }
                      Text(chat.lastSendContent)
                        .foregroundColor(Color(red: 0.9, green: 0.9, blue: 0.9))
                        .lineLimit(1)
                        .font(.system(size: 13.sp, weight: .semibold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(maxWidth: .infinity)
                  }
                  .padding(.all, 6)
                  .background(.white)
                  .cornerRadius(41.r)
                  .onTapGesture {
                    router.projectNamePath.append(
                      RandomName16MainRoute.wfueZroFsmnPrimary(
                        url: URL(
                          string:
                            "http://192.168.9.129:4000/chat/\(chat.chatId)"
                        )!
                      ))
                  }
                }
              }
            }
          }
        }
      }
      .padding(.horizontal, 20.w)
    }
    .enableInjection()
  }
}
