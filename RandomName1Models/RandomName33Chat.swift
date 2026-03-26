import Foundation
import SwiftData

@Model
final class RandomName33ChatModel {

  @Attribute(.unique)
  var chatId: String

  var chatUserIds: [String]
  var lastSendContent: String
  var lastSendTime: String?
  var unreadMsgCount: Int?
  var lastSendUserId: String?

  init(
    chatId: String,
    chatUserIds: [String],
    lastSendContent: String,
    lastSendTime: String? = nil,
    unreadMsgCount: Int? = nil,
    lastSendUserId: String? = nil
  ) {
    self.chatId = chatId
    self.chatUserIds = chatUserIds
    self.lastSendContent = lastSendContent
    self.lastSendTime = lastSendTime
    self.unreadMsgCount = unreadMsgCount
    self.lastSendUserId = lastSendUserId
  }
}

// MARK: - JSON Support
extension RandomName33ChatModel {
  func update(from new: RandomName33ChatModel) {
    chatUserIds = new.chatUserIds
    lastSendContent = new.lastSendContent
    lastSendTime = new.lastSendTime
    unreadMsgCount = new.unreadMsgCount
    lastSendUserId = new.lastSendUserId
  }
  /// 转 Dictionary
  func toJson() -> [String: Any] {
    return [
      "chatId": chatId,
      "chatUserIds": chatUserIds,
      "lastSendContent": lastSendContent,
      "lastSendTime": lastSendTime as Any,
      "unreadMsgCount": unreadMsgCount as Any,
      "lastSendUserId": lastSendUserId as Any,
    ]
  }

  /// 转 JSON String
  func toJsonString() -> String? {
    guard let data = try? JSONSerialization.data(withJSONObject: toJson()) else {
      return nil
    }
    return String(data: data, encoding: .utf8)
  }

  /// 从 JSON 创建对象
  static func fromJson(_ json: [String: Any]) -> RandomName33ChatModel? {
    guard
      let chatId = json["chatId"] as? String,
      let chatUserIds = json["chatUserIds"] as? [String],
      let lastSendContent = json["lastSendContent"] as? String
    else {
      return nil
    }

    return RandomName33ChatModel(
      chatId: chatId,
      chatUserIds: chatUserIds,
      lastSendContent: lastSendContent,
      lastSendTime: json["lastSendTime"] as? String,
      unreadMsgCount: json["unreadMsgCount"] as? Int,
      lastSendUserId: json["lastSendUserId"] as? String
    )
  }
}
