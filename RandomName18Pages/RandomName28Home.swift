import Kingfisher
import SwiftData
import SwiftUI

struct RandomName28Home: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: RandomName16Router
  @Query private var dynamics: [RandomName2DynamicModel]
  @Query private var users: [RandomName3UserModel]
  @State private var postTitleTypes = ["All", "Round", "Square", "Oval"]
  @State private var showPostTitleType = -1
  var filteredPictureDynamics: [RandomName2DynamicModel] {
    let blockSet = Set(appState.wfzqCubCpmUser?.blockList ?? [])
    return dynamics.filter { model in
      if let userId = model.user?.userId, blockSet.contains(userId) {
        return false
      }
      guard model.dynamicType == 0 else {
        return false
      }
      return showPostTitleType == -1 || model.dynamicTitleType == showPostTitleType
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
    GeometryReader { g in
      Image("Assets/projectName_home_bg").resizable().scaledToFill().ignoresSafeArea()
      Image("Assets/projectName_home_rw").resizable().scaledToFill()
        .frame(width: 121.w, height: 238.h)
        .frame(maxWidth: .infinity, alignment: .top)
        .offset(y: 41.h)
      VStack(spacing: 0) {
        Spacer().frame(height: 10.h)
        HStack(alignment: .top, spacing: 0) {
          Text("SHARE YOUR\nBEAUTY！")
            .foregroundColor(Color(red: 211 / 255, green: 238 / 255, blue: 241 / 255))
            .font(.system(size: 24.sp, weight: .black))
          Spacer()
          VStack(spacing: 5.h) {
            Image("Assets/projectName_home_share").resizable().scaledToFit().frame(
              width: 76.r, height: 76.r)
            Text("SHARE")
              .foregroundColor(Color(red: 8 / 255, green: 115 / 255, blue: 255 / 255))
              .font(.system(size: 14.sp, weight: .bold))
          }
          .onTapGesture {
            router.projectNamePath.append(
              RandomName16MainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:4000/publishPicPost")!
              ))
          }
          .padding(.top, 15.h)
        }
        .padding(.horizontal, 13.w)
        .padding(.leading, 7.w)
        Spacer().frame(height: 101.h)
        HStack(spacing: 10.w) {
          Text("AI Photo Inspiration")
            .foregroundColor(Color("fzs1"))
            .font(.system(size: 16.sp, weight: .semibold))
          Image("Assets/projectName_item_forward")
            .resizable().scaledToFit()
            .frame(width: 18.r, height: 18.r)
            .frame(width: 30.r, height: 30.r)
            .background(.black)
            .clipShape(Circle())
        }
        .padding(.horizontal, 10.w)
        .padding(.vertical, 6.h)
        .background(.white.opacity(0.2))
        .background(.ultraThinMaterial)
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
        .onTapGesture {
          router.projectNamePath.append(
            RandomName16MainRoute.wfueZroFsmnPrimary(
              url: URL(
                string:
                  "http://192.168.9.129:4000/aiDetails")!
            ))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        Spacer().frame(height: 12.h)
        ScrollView(.vertical) {
          VStack(spacing: 0) {
            Text("POPULAR PHOTO")
              .foregroundColor(.red)
              .font(.system(size: 18.sp, weight: .black))

              .padding(.leading, 20.w)
              .frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 16.h)
            ScrollView(.horizontal) {
              HStack(spacing: 10.w) {
                ForEach(filteredPictureDynamics, id: \.self) { dynamicEntity in
                  KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 137.w, height: 172.h)
                    .cornerRadius(40.r)
                    .overlay(
                      HStack(spacing: 10.w) {
                        Text("Check")
                          .foregroundColor(.white)
                          .font(.system(size: 16.sp, weight: .semibold))
                        Image("Assets/projectName_item_forward")
                          .resizable().scaledToFit()
                          .frame(width: 18.r, height: 18.r)
                          .frame(width: 30.r, height: 30.r)
                          .background(.black)
                          .clipShape(Circle())
                      }
                      .padding(.horizontal, 10.w)
                      .padding(.vertical, 6.h)
                      .background(.white.opacity(0.2))
                      .background(.ultraThinMaterial)
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
                      .offset(y: -10.h), alignment: .bottom
                    )
                    .onTapGesture {
                      router.projectNamePath.append(
                        RandomName16MainRoute.wfueZroFsmnPrimary(
                          url: URL(
                            string:
                              "http://192.168.9.129:4000/picPostDetails/\(dynamicEntity.dynamicId)"
                          )!
                        ))
                    }
                }
              }
            }
            .padding(.leading, 20.w)
            Spacer().frame(height: 24.h)
            ForEach(filteredUsers, id: \.self) { userModel in
              HStack(spacing: 16.w) {
                KFImage(URL(string: userModel.avatar))
                  .fade(duration: 0.2)
                  .resizable()
                  .scaledToFill()
                  .frame(width: 62.r, height: 62.r)
                  .clipShape(Circle())
                  .overlay(Circle().stroke(.white.opacity(0.1), lineWidth: 4.0))
                VStack(spacing: 7.h) {
                  Text(userModel.name)
                    .foregroundColor(.white)
                    .font(.system(size: 16.sp, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                  Text(userModel.about)
                    .foregroundColor(Color(red: 229 / 255, green: 229 / 255, blue: 229 / 255))
                    .font(.system(size: 13.sp, weight: .semibold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .frame(maxWidth: .infinity)
              }
              .padding(.all, 6.w)
              .frame(maxWidth: .infinity)
              .background(.white)
              .cornerRadius(41.r)
              .padding(.horizontal, 20.w)
              .padding(.bottom, 8.h)
            }
          }
        }
        .scrollIndicators(.hidden)
        .padding(.top, 20.h)
        .padding(.bottom, 80.h)
        .frame(maxWidth: .infinity)
        .background(.white)
        .clipShape(RandomName11RoundedCorner(radius: 20, corners: [.topLeft, .topRight]))
        .ignoresSafeArea()
      }
    }
    .enableInjection()
  }
}
