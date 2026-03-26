import Kingfisher
import SwiftData
import SwiftUI

struct RandomName24Found: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: RandomName16Router
  @Query private var dynamics: [RandomName2DynamicModel]
  @Query private var users: [RandomName3UserModel]
  var filteredVideoDynamics: [RandomName2DynamicModel] {
    guard let blockList = appState.wfzqCubCpmUser?.blockList else {
      return dynamics.filter { $0.dynamicType == 1 }
    }
    return dynamics.filter {
      !blockList.contains($0.user?.userId ?? "") && $0.dynamicType == 1
    }
  }
  var filteredUsers: [RandomName3UserModel] {
    let blockSet = Set(appState.wfzqCubCpmUser?.blockList ?? [])
    return users.filter { model in
      if blockSet.contains(model.userId) {
        return false
      }
      if let currentUserId = appState.wfzqCubCpmUser?.userId {
        return currentUserId != model.userId
      }
      return true
    }
  }

  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Color.white.ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 20.h)
        HStack(spacing: 0) {
          Text("FOR YOU")
            .foregroundColor(.red)
            .font(.system(size: 27.sp, weight: .black))

          Spacer()
          HStack {
            Image("Assets/projectName_video_add_icon")
              .resizable().scaledToFit().frame(width: 18.r, height: 18.r)
              .frame(width: 34.r, height: 34.r)
              .background(.white.opacity(0.6))
              .clipShape(Circle())
              .overlay(Circle().stroke(.white.opacity(0.2), lineWidth: 3))
            Text("SHARE")
              .foregroundColor(.white)
              .font(.system(size: 14.sp, weight: .bold))
          }
          .onTapGesture {
            router.projectNamePath.append(
              RandomName16MainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:4000/publishVideoPost")!
              ))
          }
        }
        .padding(.horizontal, 15.w).padding(.leading, 5.w)
        Spacer().frame(height: 13.h)
        ScrollView(.horizontal) {
          HStack(spacing: 20.w) {
            ForEach(filteredUsers, id: \.self) { user in
              let followed = appState.wfzqCubCpmUser?.follow.contains(user.userId) ?? false
              VStack(spacing: 19.h) {
                KFImage(URL(string: user.avatar))
                  .fade(duration: 0.2)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 64.r, height: 64.r)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(.white.opacity(0.1), lineWidth: 2.0))
                  .overlay(
                    Image(
                      followed ? "Assets/projectName_gou_icon" : "Assets/projectName_video_add_icon"
                    )
                    .resizable().scaledToFit().frame(width: 8.r, height: 8.r)
                    .frame(width: 14.r, height: 14.r)
                    .background(.white)
                    .clipShape(Circle()),
                    alignment: .bottomTrailing)
                Text(user.name)
                  .padding(.vertical, 6.h)
                  .padding(.horizontal, 10.w)
                  .frame(width: 80.w)
                  .background(.white.opacity(0.2))
                  .background(.ultraThinMaterial)
                  .lineLimit(1)
                  .cornerRadius(100.r)
                  .overlay(
                    RoundedRectangle(cornerRadius: 100.r)
                      .stroke(
                        LinearGradient(
                          gradient: Gradient(stops: [
                            .init(color: Color.white, location: 0),
                            .init(color: Color.white.opacity(0), location: 0.5381),
                            .init(color: Color.white.opacity(0.75), location: 1),
                          ]),
                          startPoint: .topLeading,
                          endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                      )
                  )
              }
              .padding(.horizontal, 11.w)
              .padding(.vertical, 14.h)
              .background(.white)
              .cornerRadius(30.r)
              .overlay(
                RoundedRectangle(cornerRadius: 30.r)
                  .stroke(
                    LinearGradient(
                      gradient: Gradient(stops: [
                        .init(color: .white, location: 0),
                        .init(color: Color.gray.opacity(0), location: 0.5757),
                        .init(color: .white, location: 1),
                      ]),
                      startPoint: .topLeading,
                      endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                  )
              )
            }
          }
        }
        .scrollIndicators(.hidden)
        .padding(.leading, 20.w)
        Spacer().frame(height: 24.h)
        ScrollView(.vertical) {
          VStack(spacing: 12.h) {
            ForEach(filteredVideoDynamics, id: \.self) { dynamicEntity in
              VStack(spacing: 0) {
                HStack(spacing: 8.w) {
                  KFImage(URL(string: dynamicEntity.user?.avatar ?? ""))
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 44.r, height: 44.r)
                    .clipShape(Circle())
                  Text("\(dynamicEntity.user?.name ?? "")")
                    .font(.system(size: 16.sp, weight: .bold))
                    .foregroundColor(.white)
                  Spacer()
                }
                Text(dynamicEntity.dynamicDesc)
                  .foregroundColor(Color(red: 0.13, green: 0.13, blue: 0.13))
                  .lineLimit(1)
                  .font(.system(size: 14.sp))
                  .frame(maxWidth: .infinity, alignment: .leading)
                  .padding(.vertical, 10.h)
                KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                  .fade(duration: 0.25)
                  .resizable()
                  .scaledToFill()
                  .frame(width: .infinity, height: 235.h)
                  .cornerRadius(12.r)
                  .overlay(
                    Image("Assets/projectName_item_play")
                      .resizable().scaledToFit().frame(width: 36.r, height: 36.r).offset(
                        x: -10.r, y: -10.r),
                    alignment: .bottomTrailing
                  )
              }
              .padding(.all, 10)
              .background(.white.opacity(0.6))
              .cornerRadius(20.r)
              .overlay(
                RoundedRectangle(cornerRadius: 20.r)
                  .stroke(
                    LinearGradient(
                      gradient: Gradient(stops: [
                        .init(color: .white, location: 0),
                        .init(color: .white.opacity(0), location: 0.5677),
                        .init(color: .white, location: 1),
                      ]),
                      startPoint: .topLeading,
                      endPoint: .bottomTrailing
                    ),
                    lineWidth: 1
                  )
              )
              .onTapGesture {
                router.projectNamePath.append(
                  RandomName16MainRoute.wfueZroFsmnPrimary(
                    url: URL(
                      string:
                        "http://192.168.9.129:4000/videoPostDetails/\(dynamicEntity.dynamicId)"
                    )!
                  ))
              }
            }
          }
        }
        .scrollIndicators(.hidden)
        .padding(.horizontal, 20.w)
        .padding(.bottom, 40.h)
      }
    }
    .enableInjection()
  }
}
