enum MessageType {
  inbox("收件箱", "inbox"),
  outbox("发件箱", "outbox"),
  unread("未读消息", "unread");

  final String label;
  final String path;

  const MessageType(this.label, this.path);
}