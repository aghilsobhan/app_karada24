
import 'dart:convert';

Payload payloadFromJson(String str) => Payload.fromJson(json.decode(str));

String payloadToJson(Payload data) => json.encode(data.toJson());

class Payload {
  int id;
  String link;
  Title title;
  Content content;
  Content excerpt;
  int author;

  Payload({
    required  this.id,
    required this.link,
    required this.title,
    required this.content,
    required  this.excerpt,
    required  this.author,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    id: json["id"],
    link: json["link"],
    title: Title.fromJson(json["title"]),
    content: Content.fromJson(json["content"]),
    excerpt: Content.fromJson(json["excerpt"]),
    author: json["author"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "link": link,
    "title": title.toJson(),
    "content": content.toJson(),
    "excerpt": excerpt.toJson(),
    "author": author,
  };
}
class Content {
  String rendered;
  bool protected;

  Content({
    required this.rendered,
    required this.protected,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    rendered: json["rendered"],
    protected: json["protected"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
    "protected": protected,
  };
}

class Title {
  String rendered;

  Title({
    required this.rendered,
  });

  factory Title.fromJson(Map<String, dynamic> json) => Title(
    rendered: json["rendered"],
  );

  Map<String, dynamic> toJson() => {
    "rendered": rendered,
  };
}