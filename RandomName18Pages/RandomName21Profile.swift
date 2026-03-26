import Kingfisher
import SwiftData
import SwiftUI

struct RandomName21Profile: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var appState: RandomName32State
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: RandomName16Router
  @Query private var dynamics: [RandomName2DynamicModel]
  var filteredPictureDynamics: [RandomName2DynamicModel] {
    return dynamics.filter {
      $0.dynamicType == 0
        && $0.user?.userId == appState.wfzqCubCpmUser?.userId
    }
  }
  let columns = [
    GridItem(.flexible(), spacing: 25),
    GridItem(.flexible(), spacing: 25),
  ]
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { _ in
      Image("Assets/projectName_profile_bg").resizable().scaledToFill().ignoresSafeArea()
      VStack(spacing: 0) {
        Spacer().frame(height: 12.h)
        HStack(alignment: .top, spacing: 0) {
          HStack(spacing: 10.w) {
            KFImage(URL(string: appState.wfzqCubCpmUser?.avatar ?? ""))
              .fade(duration: 0.2)
              .resizable()
              .scaledToFill()
              .frame(width: 62.r, height: 62.r)
              .clipShape(Circle())
              .overlay(Circle().stroke(.white.opacity(0.1), lineWidth: 4.0))
            Text(appState.wfzqCubCpmUser?.name ?? "")
              .foregroundColor(.black)
              .font(.system(size: 16.sp, weight: .black))

            Image("Assets/projectName_edit_icon")
              .resizable().scaledToFit().frame(
                width: 12.r, height: 12.r)
          }
          .onTapGesture {
            router.projectNamePath.append(
              RandomName16MainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:4000/edit")!
              ))
          }
          .padding(.top, 4.h)
          Spacer()
          Image("Assets/projectName_setting_icon")
            .resizable().scaledToFit().frame(
              width: 24.r, height: 24.r
            )
            .onTapGesture {
              router.projectNamePath.append(
                RandomName16MainRoute.wfueZroFsmnPrimary(
                  url: URL(
                    string:
                      "http://192.168.9.129:4000/setting"
                  )!
                ))
            }
        }
        .padding(.horizontal, 20.w)
        HStack(spacing: 0) {
          VStack(alignment: .leading, spacing: 6.h) {
            Text(
              "\(appState.wfzqCubCpmUser?.follow.count ?? 0)"
            )
            .foregroundColor(
              .white
            )
            .font(.system(size: 16.sp, weight: .bold))
            Text(
              "Following"
            ).foregroundColor(
              .white
            )
            .font(.system(size: 12.sp))
          }
          .onTapGesture {
            router.projectNamePath.append(
              RandomName16MainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:4000/follow"
                )!
              ))
          }
          Spacer()
          VStack(alignment: .leading, spacing: 6.h) {
            Text(
              "\(appState.wfzqCubCpmUser?.fans.count ?? 0)"
            )
            .foregroundColor(
              .white
            )
            .font(.system(size: 16.sp, weight: .bold))
            Text(
              "Followers"
            ).foregroundColor(
              .white
            )
            .font(.system(size: 12.sp))
          }
          .onTapGesture {
            router.projectNamePath.append(
              RandomName16MainRoute.wfueZroFsmnPrimary(
                url: URL(
                  string:
                    "http://192.168.9.129:4000/fan"
                )!
              ))
          }
        }
        .padding(.leading, 102.w)
        .padding(.trailing, 138.w)
        Spacer().frame(height: 14.h)
        HStack(spacing: 12.w) {
          Image("Assets/projectName_wallet_icon")
            .resizable().scaledToFit().frame(
              width: 40.r, height: 40.r)
          Text("WALLET")
            .foregroundColor(.black)
            .font(.system(size: 20.sp, weight: .black))

          Spacer()
        }
        .padding(.horizontal, 25.w)
        .frame(maxWidth: .infinity)
        .frame(height: 70.h)
        .background(.white.opacity(0.2))
        .background(.ultraThinMaterial)
        .cornerRadius(40.r)
        .onTapGesture {
          router.projectNamePath.append(
            RandomName16MainRoute.wfueZroFsmnPrimary(
              url: URL(
                string:
                  "http://192.168.9.129:4000/coins"
              )!
            ))
        }
        .padding(.horizontal, 30.w)
        Spacer().frame(height: 16.h)
        if filteredPictureDynamics.isEmpty {
          VStack {
            Spacer().frame(height: 20.h)
            Text("POST")
              .foregroundColor(.red)
              .font(.system(size: 24.sp, weight: .black))

              .padding(.leading, 20.w)
              .frame(maxWidth: .infinity, alignment: .leading)
            VStack {
              Image("Assets/projectName_empty").resizable().scaledToFit().frame(
                width: 152.r, height: 152.r)
              Text("No Data")
                .foregroundColor(.black)
                .font(.system(size: 18.sp))
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(.white)
          .clipShape(RandomName11RoundedCorner(radius: 40.r, corners: [.topLeft, .topRight]))
          .ignoresSafeArea()
        } else {
          VStack {
            Spacer().frame(height: 20.h)
            Text("POST")
              .foregroundColor(.red)
              .font(.system(size: 24.sp, weight: .black))

              .padding(.leading, 20.w)
              .frame(maxWidth: .infinity, alignment: .leading)
            LazyVGrid(columns: columns) {
              ForEach(filteredPictureDynamics, id: \.self) { dynamicEntity in
                GeometryReader { geometry in
                  KFImage(URL(string: dynamicEntity.dynamicPic.first!))
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width)
                    .frame(height: 211.h)
                    .clipped()
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
          }
          .padding(.horizontal, 20.w)
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
          .background(.white)
          .clipShape(RandomName11RoundedCorner(radius: 40.r, corners: [.topLeft, .topRight]))
          .ignoresSafeArea()
        }
      }
    }
    .enableInjection()
  }
}
