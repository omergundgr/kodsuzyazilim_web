class Post {
  late String body;
  late String date;
  late int id;
  late String title;
  late String type;
  late String userMail;
  String? image;
  String description = "";

  Post(
      {required this.body,
      required this.date,
      required this.id,
      required this.title,
      required this.type,
      required this.userMail});

  Post.fromJson(Map<String, dynamic> json) {
    body = json['body'];
    date = json['formattedDate'];
    id = json['id'];
    title = json['title'];
    type = json['type'];
    userMail = json['userMail'];
    final badCharacters = ["#", "*", "~", "[", "(", ">", "------"];
    if (body.contains("![")) {
      final split1 = body.split("![").last;
      if (split1.contains("](")) {
        image = split1.split("](").last.split(")").first;
      }
    }
    if (body.contains("\n")) {
      final bodyLines = body.split("\n");
      final descList = [];
      for (String b in bodyLines) {
        if (!badCharacters.contains(b) && b.isNotEmpty) {
          descList.add(b);
        }
      }
      if (descList.isNotEmpty) {
        description = descList.first;
        for (String d in descList) {
          if (d.length > description.length) {
            description = d;
          }
        }
      }
    }
    if (description.isEmpty) {
      bool isHaveBadCharacter = false;
      for (String i in badCharacters) {
        if (body.contains(i)) {
          isHaveBadCharacter = true;
          break;
        }
      }
      if (isHaveBadCharacter) {
        description =
            "${userMail.split("@").first} kullanıcısına ait $title paylaşımı";
      } else {
        description = body;
      }
    }
  }
}
