import SwiftUI
import WebKit

struct RandomName22AgreAgreeContent: UIViewRepresentable {

  var trvudfhvSsxcUrl: URL

  func makeUIView(context: Context) -> WKWebView {
    let webView = WKWebView()
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    let request = URLRequest(url: trvudfhvSsxcUrl)
    webView.load(request)
  }
}

struct RandomName22AgreAgree: View {
  #if DEBUG
    @ObserveInjection var forceRedraw
  #endif
  @EnvironmentObject var router: RandomName16Router
  let trvudfhvSsxcUrl: URL
  var body: some View {
    #if DEBUG
      let _ = forceRedraw
    #endif
    GeometryReader { geo in
      Image("Assets/projectName_splash_bg").resizable().scaledToFill().ignoresSafeArea()
      ProgressView()
        .progressViewStyle(CircularProgressViewStyle(tint: Color("text1")))
      RandomName22AgreAgreeContent(trvudfhvSsxcUrl: trvudfhvSsxcUrl)
        .edgesIgnoringSafeArea(.bottom)
    }
    .navigationBarBackButtonHidden(true)
    .toolbar {
      ToolbarItem(placement: .navigationBarLeading) {
        Button {
          router.projectNamePath.removeLast()
        } label: {
          Image("Assets/projectName_back")
            .resizable()
            .scaledToFit()
            .frame(width: 40.r, height: 40.r)
        }
      }
    }
    .enableInjection()
  }
}
