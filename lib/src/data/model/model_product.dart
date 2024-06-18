import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:heidi/src/data/model/model.dart';
import 'package:heidi/src/data/model/model_category.dart';
import 'package:heidi/src/data/model/model_file.dart';
import 'package:heidi/src/data/model/model_image.dart';
import 'package:heidi/src/data/model/model_open_time.dart';
import 'package:heidi/src/data/model/model_setting.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class ProductModel {
  final int id;
  final int userId;
  final int? subcategoryId;
  final int? categoryId;
  final int? cityId;
  final int? villageId;
  final int? statusId;
  final int? sourceId;
  final String title;
  final String image;
  final String? pdf;
  final int? showExternal;
  final String? videoURL;
  final String? category;
  final String expiryDate;
  final String startDate;
  final String endDate;
  final String createDate;
  final String? username;
  final String? firstname;
  final String? lastname;
  final String? profileImage;
  final String? dateEstablish;
  final double? rate;
  final num? numRate;
  final String? rateText;
  final String? status;
  @Default(false)
  bool favorite;
  final String address;
  final String? zipCode;
  final String phone;
  final String? fax;
  final String email;
  final String website;
  final String externalId;
  final String description;
  final String? color;
  final String? icon;
  final List<CategoryModel>? tags;
  final String? price;
  final String? priceMin;
  final String? priceMax;
  final CategoryModel? country;
  final CategoryModel? city;
  final CategoryModel? state;
  final UserModel? author;
  final List<ImageModel>? galleries;
  final List<CategoryModel>? features;
  final List<ProductModel>? related;
  final List<ProductModel>? latest;
  final List<OpenTimeModel>? openHours;
  final Map<String, dynamic>? socials;
  final List<FileModel>? attachments;
  final LocationData? location;
  final String? link;
  final bool? bookingUse;
  final String? bookingStyle;
  final String? priceDisplay;
  List<ImageListModel>? imageLists;
  int? timeless;

  ProductModel(
      {required this.id,
      required this.title,
      required this.image,
      this.pdf,
      this.videoURL,
      this.category,
      required this.expiryDate,
      required this.startDate,
      required this.endDate,
      required this.createDate,
      this.username,
      this.firstname,
      this.lastname,
      this.profileImage,
      this.dateEstablish,
      this.rate,
      this.numRate,
      this.rateText,
      this.status,
      required this.favorite,
      required this.address,
      this.zipCode,
      required this.phone,
      this.fax,
      required this.email,
      required this.website,
      required this.externalId,
      required this.description,
      this.color,
      this.icon,
      this.tags,
      this.price,
      this.priceMin,
      this.priceMax,
      this.country,
      this.city,
      this.state,
      this.author,
      this.galleries,
      this.features,
      this.related,
      this.latest,
      this.openHours,
      this.socials,
      this.location,
      this.attachments,
      this.link,
      this.bookingUse,
      this.bookingStyle,
      this.priceDisplay,
      this.categoryId,
      this.subcategoryId,
      required this.userId,
      this.cityId,
      this.villageId,
      this.imageLists,
      this.statusId,
      this.timeless,
      this.sourceId,
      this.showExternal});

  factory ProductModel.fromJson(Map<String, dynamic> json,
      {SettingModel? setting, int? cityId}) {
    List<ImageModel> galleries = [];
    List<CategoryModel> features = [];
    List<OpenTimeModel> openHours = [];
    List<FileModel> attachments = [];
    List<CategoryModel> tags = [];
    Map<String, dynamic> socials = {};
    UserModel? author;
    String? category;
    String? externalId;
    LocationData? location;
    CategoryModel? country;
    CategoryModel? state;
    CategoryModel? city;
    String status = '';
    String videoURL = '';
    String expiryDate = '';
    String startDate = '';
    String endDate = '';
    String createDate = '';
    String priceMin = '';
    String priceMax = '';
    int? timeless;
    String priceDisplay = '';

    if (json['author'] != null) {
      author = UserModel.fromJson(json['author']);
    }
    if ((json['expiryDate']) != null) {
      timeless = 0;
    } else {
      timeless = 1;
    }

    if (json['categoryId'] == 1) {
      category = "Nachricht";
      final parsedDateTime = DateTime.parse(json['createdAt']);
      createDate = DateFormat('dd.MM.yyyy').format(parsedDateTime);
      if ((json['expiryDate']) != null) {
        final parsedExpiryDateTime = DateTime.parse(json['expiryDate']);
        expiryDate =
            DateFormat('dd.MM.yyyy HH:mm').format(parsedExpiryDateTime);
      }
    } else if (json['categoryId'] == 3) {
      category = "Veranstaltungen";
      final parsedDateTime = DateTime.parse(json['startDate']);
      startDate = DateFormat('dd.MM.yyyy HH:mm').format(parsedDateTime);
      if ((json['endDate']) != null) {
        final parsedEDateTime = DateTime.parse(json['endDate']);
        if (parsedDateTime.year == parsedEDateTime.year &&
            parsedDateTime.month == parsedEDateTime.month &&
            parsedDateTime.day == parsedEDateTime.day) {
          endDate = DateFormat('HH:mm').format(parsedEDateTime);
        } else {
          endDate = DateFormat('dd.MM.yyyy HH:mm').format(parsedEDateTime);
        }
      } else {
        endDate = "";
      }
    } else if (json['categoryId'] == 4) {
      category = "Vereine";
    } else if (json['categoryId'] == 5) {
      category = "Regionale Produkte";
    } else if (json['categoryId'] == 6) {
      category = "Biete/Suche";
    } else if (json['categoryId'] == 7) {
      category = "Bürgerinfo";
    } else if (json['categoryId'] == 9) {
      category = "Verloren gefunden";
    } else if (json['categoryId'] == 10) {
      category = "Unternehmen";
    } else if (json['categoryId'] == 11) {
      category = "Fahrgemeinschaften/Öffentliche Verkehrsmittel";
    } else if (json['categoryId'] == 12) {
      category = "Angebote";
    } else if (json['categoryId'] == 13) {
      category = "Essen";
    } else if (json['categoryId'] == 14) {
      category = "Rathaus";
    } else if (json['categoryId'] == 15) {
      category = "Mitteilungsblatt";
    } else if (json['categoryId'] == 16) {
      category = "Amtliche Mitteilungen";
    }

    if (json['sourceId'] == 3 && json['externalId'] != null) {
      Uri uri = Uri.parse(json['externalId']);
      externalId = uri.authority;
    } else {
      externalId = json['externalId'];
    }

    final listRelated = List.from(json['related'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    final listLatest = List.from(json['lastest'] ?? []).map((item) {
      return ProductModel.fromJson(item, setting: setting);
    }).toList();

    final imagesList = List.from(json['otherlogos'] ?? []).map((item) {
      return ImageListModel.fromJson(item);
    }).toList();

    final bookingUse = json['booking_use'] == true;
    if (bookingUse) {
      priceDisplay = json['booking_price_display'];
    }

    return ProductModel(
      id: json['id'],
      userId: json['userId'] ?? 0,
      title: json['title'] ?? '',
      image: (json['logo'] is List<dynamic> && json['logo'].isNotEmpty)
          ? json['logo'][0]?.toString() ?? 'admin/News.jpeg'
          : (json['logo']?.toString() ?? 'admin/News.jpeg'),
      videoURL: videoURL,
      category: category ?? '',
      expiryDate: expiryDate,
      timeless: timeless,
      createDate: createDate,
      startDate: startDate,
      endDate: endDate,
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      profileImage: json['image'] ?? '',
      pdf: json['pdf'] ?? '',
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      numRate: json['rating_count'] ?? 0,
      rateText: json['post_status'] ?? '',
      status: status,
      favorite: json['wishlist'] ?? false,
      address: json['address'] ?? '',
      zipCode: json['zip_code'] ?? '',
      phone: json['phone'] ?? '',
      fax: json['fax'] ?? '',
      email: json['email'] ?? '',
      website: json['website'] ?? '',
      externalId: externalId ?? '',
      description: json['description'],
      color: json['color'] ?? '',
      categoryId: json['categoryId'] ?? 1,
      subcategoryId: json['subcategoryId'] ?? 1,
      cityId: cityId ?? int.parse(json['cityId']?.toString() ?? '0'),
      villageId: json['villageId'] ?? 0,
      statusId: json['statusId'] ?? 0,
      sourceId: json['sourceId'] ?? 1,
      showExternal: json['showExternal'] ?? 0,
      icon: json['icon'] ?? '',
      tags: tags,
      price: json['booking_price'] ?? '',
      priceMin: priceMin,
      priceMax: priceMax,
      country: country,
      state: state,
      city: city,
      features: features,
      author: author,
      galleries: galleries,
      related: listRelated,
      latest: listLatest,
      openHours: openHours,
      socials: socials,
      location: location,
      attachments: attachments,
      link: json['guid'] ?? '',
      bookingUse: bookingUse,
      bookingStyle: json['booking_style'] ?? '',
      priceDisplay: priceDisplay,
      imageLists: imagesList,
    );
  }

  factory ProductModel.fromNotification(Map<String, dynamic> json) {
    return ProductModel(
      id: int.tryParse('${json['id']}') ?? 0,
      userId: json['userId'] ?? 0,
      title: json['post_title'] ?? '',
      image: json['logo'],
      // image: ImageModel.fromJson(json['image'] ?? {'full': {}, 'thumb': {}}),
      videoURL: '',
      expiryDate: '',
      createDate: '',
      startDate: '',
      endDate: '',
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      profileImage: json['image'],
      rate: double.tryParse('${json['rating_avg']}') ?? 0.0,
      numRate: 0,
      categoryId: 0,
      subcategoryId: 0,
      statusId: 0,
      sourceId: 0,
      showExternal: 0,
      cityId: 0,
      villageId: 0,
      rateText: '',
      status: '',
      favorite: false,
      address: '',
      zipCode: '',
      phone: '',
      fax: '',
      email: '',
      website: '',
      externalId: '',
      description: '',
      color: '',
      icon: '',
      tags: [],
      price: '',
      priceMin: '',
      priceMax: '',
      features: [],
      galleries: [],
      related: [],
      latest: [],
      openHours: [],
      socials: {},
      attachments: [],
      link: '',
      bookingUse: false,
      bookingStyle: '',
      priceDisplay: '',
      imageLists: json['otherlogos'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "title": title,
      "image": {
        "id": 0,
        "full": {},
        "thumb": {},
      },
    };
  }
}

class ImageListModel {
  int? id;
  int? imageOrder;
  int? listingId;
  String? logo;

  ImageListModel({this.id, this.imageOrder, this.listingId, this.logo});

  ImageListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imageOrder = json['imageOrder'];
    listingId = json['listingId'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['imageOrder'] = imageOrder;
    data['listingId'] = listingId;
    data['logo'] = logo;
    return data;
  }
}
