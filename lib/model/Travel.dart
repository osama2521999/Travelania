// ignore_for_file: file_names

class Travel {
  int id = 0;
  String travelName = "";
  String travelDescription = "";
  String imagePass = "";
  String price = "";
  String country = "";
  String time = "";

  Travel(
      {required this.id,
      required this.travelName,
      required this.travelDescription,
      required this.imagePass,
      required this.price,
      required this.country,
      required this.time
      });

  factory Travel.fromJson(Map<String, dynamic> json) => Travel(
        id: json["id"],
        travelName: json["name"],
        travelDescription: json["description"],
        imagePass: json["imagePass"],
        price: json["price"],
        country: json["country"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": travelName,
        "description": travelDescription,
        "imagePass": imagePass,
        "price": price,
        "country": country,
        "time": time,
      };
}
