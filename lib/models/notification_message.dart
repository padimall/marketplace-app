class NotificationMessage {
  Notif notification;
  Data data;

  NotificationMessage({this.notification, this.data});

  factory NotificationMessage.fromJson(Map<dynamic, dynamic> json) => NotificationMessage(
    notification: json["notification"] == null ? null : Notif.fromJson(json["notification"]),
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );
}

class Notif {
  Notif({
    this.title,
    this.body,
  });

  String title;
  String body;

  factory Notif.fromJson(Map<dynamic, dynamic> json) => Notif(
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
  );

  Map<dynamic, dynamic> toJson() => {
    "title": title == null ? null : title,
    "body": body == null ? null : body,
  };
}

class Data {
  Data({
    this.title,
    this.body,
    this.sound,
    this.androidChannelId,
  });

  String title;
  String body;
  String sound;
  String androidChannelId;

  factory Data.fromJson(Map<dynamic, dynamic> json) => Data(
    title: json["title"] == null ? null : json["title"],
    body: json["body"] == null ? null : json["body"],
    sound: json["sound"] == null ? null : json["sound"],
    androidChannelId: json["android_channel_id"] == null ? null : json["android_channel_id"],
  );

  Map<dynamic, dynamic> toJson() => {
    "title": title == null ? null : title,
    "body": body == null ? null : body,
    "sound": sound == null ? null : sound,
    "android_channel_id": androidChannelId == null ? null : androidChannelId,
  };
}