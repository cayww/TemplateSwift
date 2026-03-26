import StoreKit
import SwiftData
import SwiftUI
import WebKit

// MARK: - JS Handlers 名称（✅ 已全部对齐前端）
struct JsHandlers {
  static let jsConsole = "jsConsole"
  static let close = "close"

  static let userListUpdate = "userListUpdate"
  static let postsUpdate = "postsUpdate"
  static let commentsUpdate = "commentsUpdate"
  static let chatsUpdate = "chatsUpdate"
  static let messagesUpdate = "messagesUpdate"

  static let logout = "logout"
  static let payment = "payment"
}

// MARK: - WebView 内容
struct RandomName27PrimaryContent: UIViewRepresentable {
  let appState: RandomName32State
  let trvudfhvSsxcUrl: URL
  let modelContext: ModelContext
  let router: RandomName16Router
  let purchaseManager: RandomName14Purchase

  func makeUIView(context: Context) -> WKWebView {

    let preferences = WKWebpagePreferences()
    preferences.allowsContentJavaScript = true

    let configuration = WKWebViewConfiguration()
    configuration.defaultWebpagePreferences = preferences
    configuration.allowsInlineMediaPlayback = true
    configuration.allowsAirPlayForMediaPlayback = false
    configuration.allowsPictureInPictureMediaPlayback = false
    if #available(iOS 10.0, *) {
      configuration.mediaTypesRequiringUserActionForPlayback = []
    }

    let userController = WKUserContentController()

    // ✅ 注册 handler（新）
    let handlers = [
      JsHandlers.close,
      JsHandlers.userListUpdate,
      JsHandlers.postsUpdate,
      JsHandlers.commentsUpdate,
      JsHandlers.chatsUpdate,
      JsHandlers.messagesUpdate,
      JsHandlers.logout,
      JsHandlers.payment,
    ]

    handlers.forEach {
      userController.add(context.coordinator, name: $0)
    }

    // console 注入
    let consoleScript = """
      (function() {
        const oldLog = console.log;
        console.log = function(...args) {
          window.webkit.messageHandlers.jsConsole.postMessage({type: 'log', message: args});
          oldLog.apply(console, args);
        };
        const oldError = console.error;
        console.error = function(...args) {
          window.webkit.messageHandlers.jsConsole.postMessage({type: 'error', message: args});
          oldError.apply(console, args);
        };
      })();
      """

    userController.addUserScript(
      WKUserScript(
        source: consoleScript,
        injectionTime: .atDocumentStart,
        forMainFrameOnly: true
      ))

    userController.add(context.coordinator, name: JsHandlers.jsConsole)

    // 初始数据注入
    userController.addUserScript(
      WKUserScript(
        source: generateUserScript(),
        injectionTime: .atDocumentStart,
        forMainFrameOnly: false
      ))

    configuration.userContentController = userController

    let webView = WKWebView(frame: .zero, configuration: configuration)

    webView.isOpaque = false
    webView.backgroundColor = .clear
    webView.scrollView.backgroundColor = .clear
    webView.scrollView.showsVerticalScrollIndicator = false
    webView.scrollView.showsHorizontalScrollIndicator = false
    webView.scrollView.bounces = false
    webView.scrollView.pinchGestureRecognizer?.isEnabled = false
    context.coordinator.webView = webView
    webView.navigationDelegate = context.coordinator
    webView.uiDelegate = context.coordinator
    webView.load(URLRequest(url: trvudfhvSsxcUrl))

    return webView
  }

  func updateUIView(_ webView: WKWebView, context: Context) {
    if webView.url == nil {
      webView.load(URLRequest(url: trvudfhvSsxcUrl))
    }
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(
      modelContext: modelContext,
      router: router,
      appState: appState,
      purchaseManager: purchaseManager
    )
  }

  private func generateUserScript() -> String {
    func arr<T>(_ array: [T]?, map: (T) -> String) -> String {
      guard let array else { return "[]" }
      return "[" + array.map(map).joined(separator: ",") + "]"
    }

    let users = try? modelContext.fetch(FetchDescriptor<RandomName3UserModel>())
    let posts = try? modelContext.fetch(FetchDescriptor<RandomName2DynamicModel>())
    let comments = try? modelContext.fetch(FetchDescriptor<RandomName4CommentModel>())
    let chats = try? modelContext.fetch(FetchDescriptor<RandomName33ChatModel>())
    let messages = try? modelContext.fetch(FetchDescriptor<RandomName5MessageModel>())

    return """
      window.currentUser = \(appState.wfzqCubCpmUser?.toJsonString() ?? "{}");
      window.userList = \(arr(users) { $0.toJsonString() ?? "{}" });
      window.postList = \(arr(posts) { $0.toJsonString() ?? "{}" });
      window.commentList = \(arr(comments) { $0.toJsonString() ?? "{}" });
      window.chatList = \(arr(chats) { $0.toJsonString() ?? "{}" });
      window.messageList = \(arr(messages) { $0.toJsonString() ?? "{}" });
      """
  }

  // MARK: - Coordinator
  class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate, WKScriptMessageHandler {

    let modelContext: ModelContext
    let router: RandomName16Router
    let appState: RandomName32State
    let purchaseManager: RandomName14Purchase
    weak var webView: WKWebView?

    init(
      modelContext: ModelContext,
      router: RandomName16Router,
      appState: RandomName32State,
      purchaseManager: RandomName14Purchase
    ) {
      self.modelContext = modelContext
      self.router = router
      self.appState = appState
      self.purchaseManager = purchaseManager
    }
    private func decode<T: Decodable>(_ type: T.Type, from json: [String: Any]) throws -> T {
      let data = try JSONSerialization.data(withJSONObject: json)
      return try JSONDecoder().decode(T.self, from: data)
    }
    func userContentController(
      _ userContentController: WKUserContentController,
      didReceive message: WKScriptMessage
    ) {

      print("JS CALL -> \(message.name)")
      Task { @MainActor in
        switch message.name {

        // MARK: console
        case JsHandlers.jsConsole:
          print("JS:", message.body)

        // MARK: close
        case JsHandlers.close:
          if router.projectNamePath.count > 0 {
            router.projectNamePath.removeLast()
          }

        // MARK: users
        case JsHandlers.userListUpdate:
          guard
            let body = message.body as? [String: Any],
            let list = body["users"] as? [[String: Any]]
          else { return }

          list.forEach { json in
            guard let dto = try? decode(UserDTO.self, from: json) else { return }

            let fd = FetchDescriptor<RandomName3UserModel>(
              predicate: #Predicate { $0.userId == dto.userId }
            )

            if let old = try? modelContext.fetch(fd).first {
              old.email = dto.email
              old.password = dto.password
              old.avatar = dto.avatar
              old.name = dto.name
              old.about = dto.about
              old.coins = dto.coins
              old.follow = dto.follow
              old.fans = dto.fans
              old.blockList = dto.blockList
              old.picPostLikeIds = dto.picPostLikeIds
              old.videoPostLikeIds = dto.videoPostLikeIds
            } else {
              modelContext.insert(dto.toModel())
            }
          }

          try? modelContext.save()
        // MARK: posts
        case JsHandlers.postsUpdate:
          guard
            let body = message.body as? [String: Any],
            let list = body["posts"] as? [[String: Any]]
          else { return }

          list.forEach { json in
            guard let dto = try? decode(DynamicDTO.self, from: json) else { return }

            let fd = FetchDescriptor<RandomName2DynamicModel>(
              predicate: #Predicate { $0.dynamicId == dto.dynamicId }
            )

            // 查 user（只用 ID）
            let userFD = FetchDescriptor<RandomName3UserModel>(
              predicate: #Predicate { $0.userId == dto.userId }
            )
            let user = try? modelContext.fetch(userFD).first

            if let old = try? modelContext.fetch(fd).first {
              old.dynamicType = dto.dynamicType
              old.dynamicDesc = dto.dynamicDesc
              old.dynamicTitleType = dto.dynamicTitleType
              old.dynamicPic = dto.dynamicPic
              old.dynamicVideo = dto.dynamicVideo
              old.dynamicLikeCount = dto.dynamicLikeCount
              old.dynamicCommentCount = dto.dynamicCommentCount

              // ✅ 只用 context 内的 user
              if old.user?.userId != dto.userId {
                old.user = user
              }
            } else {
              let new = RandomName2DynamicModel(
                dynamicId: dto.dynamicId,
                user: user,
                dynamicType: dto.dynamicType,
                dynamicDesc: dto.dynamicDesc,
                dynamicTitleType: dto.dynamicTitleType,
                dynamicPic: dto.dynamicPic,
                dynamicVideo: dto.dynamicVideo,
                dynamicLikeCount: dto.dynamicLikeCount,
                dynamicCommentCount: dto.dynamicCommentCount
              )
              modelContext.insert(new)
            }
          }

          try? modelContext.save()

        // MARK: comments
        case JsHandlers.commentsUpdate:
          guard
            let body = message.body as? [String: Any],
            let list = body["comments"] as? [[String: Any]]
          else { return }

          list.forEach { json in
            guard let new = RandomName4CommentModel.fromJson(json) else { return }
            let commentId = new.commentId
            let fd = FetchDescriptor<RandomName4CommentModel>(
              predicate: #Predicate { $0.commentId == commentId }
            )

            if let old = try? modelContext.fetch(fd).first {
              old.dynamicId = new.dynamicId
              old.userId = new.userId
              old.content = new.content
            } else {
              modelContext.insert(new)  // ✅ 这里是安全的（无关系）
            }
          }

          try? modelContext.save()

        // MARK: chats
        case JsHandlers.chatsUpdate:
          guard
            let body = message.body as? [String: Any],
            let list = body["chats"] as? [[String: Any]]
          else { return }

          list.forEach { json in
            guard let new = RandomName33ChatModel.fromJson(json) else { return }
            let id = new.chatId

            let fd = FetchDescriptor<RandomName33ChatModel>(
              predicate: #Predicate { $0.chatId == id }
            )

            if let old = try? modelContext.fetch(fd).first {
              old.update(from: new)
            } else {
              modelContext.insert(new)
            }
          }

          try? modelContext.save()

        // MARK: messages
        case JsHandlers.messagesUpdate:
          guard
            let body = message.body as? [String: Any],
            let list = body["messages"] as? [[String: Any]]
          else { return }

          list.forEach { json in
            guard let new = RandomName5MessageModel.fromJson(json) else { return }
            let id = new.msgId

            let fd = FetchDescriptor<RandomName5MessageModel>(
              predicate: #Predicate { $0.msgId == id }
            )

            if let old = try? modelContext.fetch(fd).first {
              old.update(from: new)
            } else {
              modelContext.insert(new)
            }
          }

          try? modelContext.save()

        // MARK: logout
        case JsHandlers.logout:
          appState.hzglZtiFzlLogout()

        // MARK: payment
        case JsHandlers.payment:
          guard
            let body = message.body as? [String: Any],
            let key = body["payKey"] as? String
          else { return }
          guard
            let product = purchaseManager.products.first(where: {
              $0.productIdentifier == key
            })
          else { return }
          RandomName7Toast.shared.showLoading()
          purchaseManager.purchase(product) { result in
            if result > 0 {
              self.appState.tnngDfrhGkgtAddCoins(result)
              if let user = self.appState.wfzqCubCpmUser, let json = user.toJsonString() {
                let js = "window.updateCurrentUser(\(json))"
                DispatchQueue.main.async {
                  self.webView?.evaluateJavaScript(js)
                }
              }
            }
            RandomName7Toast.shared.hideLoading()
          }
        default:
          print("未知 JS 调用")
        }
      }
    }
  }
}
struct RandomName27Primary: View {
  @EnvironmentObject var purchaseManager: RandomName14Purchase
  let trvudfhvSsxcUrl: URL
  @Environment(\.modelContext) private var modelContext
  @EnvironmentObject var router: RandomName16Router
  @EnvironmentObject var appState: RandomName32State
  var body: some View {
    GeometryReader { geo in
      Image("Assets/projectName_default_bg")
        .resizable()
        .scaledToFill()
        .ignoresSafeArea()
      RandomName27PrimaryContent(
        appState: appState,
        trvudfhvSsxcUrl: trvudfhvSsxcUrl,
        modelContext: modelContext,
        router: router,
        purchaseManager: purchaseManager
      )
      .edgesIgnoringSafeArea(.all)
    }
    .navigationBarBackButtonHidden(true)
  }
}
