class SessionUser {
  String? tokenJwt;
  String? refreshToken;
  SessionUser({required this.tokenJwt, required this.refreshToken});
  factory SessionUser.fromJsonApi(Map<String, dynamic> object) => SessionUser(
      tokenJwt: object['token'], refreshToken: object['refresh_token']);
}

class UserResult {
  bool? status;
  String? alert;
  User? dataUser;
  UserResult(
      {required this.status, required this.alert, required this.dataUser});
  factory UserResult.fromJson(Map<String, dynamic> object) => UserResult(
      status: object['status'],
      alert: object['alert'],
      dataUser: User.fromJson(object['data']));
}

class User {
  String? noWa;
  String? email;
  String? latitude;
  String? longitude;
  String? token;
  String? kodeDesa;
  User(
      {required this.noWa,
      required this.email,
      required this.latitude,
      required this.longitude,
      required this.token,
      required this.kodeDesa});

  factory User.fromJson(Map<String, dynamic> object) => User(
      noWa: object['noWa'],
      email: object['email'],
      latitude: object['latitude'],
      longitude: object['longitude'],
      token: object['token'],
      kodeDesa: object['kodeDesa']);
  Map<String, dynamic> toJson() {
    return {
      "noWa": noWa,
      "email": email,
      "latitude": latitude,
      "longitude": longitude,
      "token": token,
      "kodeDesa": kodeDesa
    };
  }
}

class ProfileUserGet {
  bool? success;
  ProfileUser? data;

  ProfileUserGet({this.success, this.data});

  ProfileUserGet.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = ProfileUser.fromJson(json['data']);
  }
}

class ProfileUser {
  String? id;
  String? username;
  String? phoneNumber;
  String? nik;
  String? email;
  String? fullname;
  String? description;
  String? avatarId;
  String? kodeDesa;
  String? imei;
  String? registeredDate;
  String? updatedDate;
  String? lastLoggedIn;
  String? confirmedAt;
  String? active;
  String? slug;
  String? name;
  String? avatarUrl;
  String? namaDesa;
  String? namaKec;

  ProfileUser(
      {this.id,
      this.username,
      this.phoneNumber,
      this.nik,
      this.email,
      this.fullname,
      this.description,
      this.avatarId,
      this.kodeDesa,
      this.imei,
      this.registeredDate,
      this.updatedDate,
      this.lastLoggedIn,
      this.confirmedAt,
      this.active,
      this.slug,
      this.name,
      this.avatarUrl,
      this.namaDesa,
      this.namaKec});

  ProfileUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    phoneNumber = json['phone_number'];
    nik = json['nik'];
    email = json['email'];
    fullname = json['fullname'];
    description = json['description'];
    avatarId = json['avatar_id'];
    kodeDesa = json['kode_desa'];
    imei = json['imei'];
    registeredDate = json['registered_date'];
    updatedDate = json['updated_date'];
    lastLoggedIn = json['last_logged_in'];
    confirmedAt = json['confirmed_at'];
    active = json['active'];
    slug = json['slug'];
    name = json['name'];
    avatarUrl = json['avatar'];
    namaDesa = json['nama_desa'];
    namaKec = json['nama_kecamatan'];
  }
}
