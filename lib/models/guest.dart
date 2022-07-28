class Guest {
  List<GuestData>? data;

  Guest({this.data});

  Guest.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <GuestData>[];
      json['data'].forEach((v) {
        data!.add(GuestData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GuestData {
  String? name;
  String? imgUrl;
  String? location;
  String? email;
  int? phoneNumber;
  DateTime? guestSince;
  List<Bookings>? bookings;

  GuestData({this.name, this.imgUrl, this.location, this.email, this.phoneNumber, this.guestSince, this.bookings});

  GuestData.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imgUrl = json['img_url'];
    location = json['location'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    guestSince = DateTime.parse(json['guest_since'] as String);
    if (json['bookings'] != null) {
      bookings = <Bookings>[];
      json['bookings'].forEach((v) {
        bookings!.add(Bookings.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['img_url'] = imgUrl;
    data['location'] = location;
    data['email'] = email;
    data['phone_number'] = phoneNumber;
    data['guest_since'] = guestSince;
    if (bookings != null) {
      data['bookings'] = bookings!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Bookings {
  String? id;
  String? placeName;
  String? status;
  DateTime? checkIn;
  DateTime? checkOut;
  String? numberGuest;
  String? bookingValue;
  String? host;
  String? profileName;
  String? propertyUnit;
  String? listingName;

  Bookings(
      {this.id,
      this.placeName,
      this.status,
      this.checkIn,
      this.checkOut,
      this.numberGuest,
      this.bookingValue,
      this.host,
      this.profileName,
      this.propertyUnit,
      this.listingName});

  Bookings.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeName = json['place_name'];
    status = json['status'];
    checkIn = DateTime.parse(json['check_in'] as String);
    checkOut = DateTime.parse(json['check_out'] as String);
    numberGuest = json['number_guest'];
    bookingValue = json['booking_value'];
    host = json['host'];
    profileName = json['profile_name'];
    propertyUnit = json['property_unit'];
    listingName = json['listing_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['place_name'] = placeName;
    data['status'] = status;
    data['check_in'] = checkIn;
    data['check_out'] = checkOut;
    data['number_guest'] = numberGuest;
    data['booking_value'] = bookingValue;
    data['host'] = host;
    data['profile_name'] = profileName;
    data['property_unit'] = propertyUnit;
    data['listing_name'] = listingName;

    return data;
  }
}
