import 'package:flutter/cupertino.dart';

class BannerList with ChangeNotifier {
  List<SliderModel> bannerSlider = [];
  String defaultImage = "";
  updateSlider(List<SliderModel> model, String noImage) {
    bannerSlider = model;
    defaultImage = noImage;
    notifyListeners();
  }
}

class BannerModel {
  String? status;
  Data? data;

  BannerModel({status, data});

  BannerModel.fromJson(Map<String?, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> _data = new Map<String, dynamic>();
    _data['status'] = status;
    if (data != null) {
      _data['data'] = data!.toJson();
    }
    return _data;
  }
}

class Data {
  String? integration;
  int? rootcategory;
  List<SliderModel>? slider;
  String? noimg;
  List<Catimages>? catimages;
  int? storeId;
  String? currency;
  int? voucherCat;
  String? whatsapp;
  int? celebrityId;
  String? registerOtp;
  List<MobileFormats>? mobileFormats;

  Data({
    this.integration,
    this.rootcategory,
    this.slider,
    this.noimg,
    this.catimages,
    this.storeId,
    this.currency,
    this.voucherCat,
    this.whatsapp,
    this.celebrityId,
    this.registerOtp,
    this.mobileFormats,
  });

  Data.fromJson(Map<String, dynamic> json) {
    integration = json['integration'];
    rootcategory = json['rootcategory'];
    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider!.add(SliderModel.fromJson(v));
      });
    }
    noimg = json['noimg'];
    if (json['catimages'] != null) {
      catimages = [];
      json['catimages'].forEach((v) {
        catimages!.add(Catimages.fromJson(v));
      });
    }
    storeId = json['store_id'];

    currency = json['currency'];

    voucherCat = json['voucher_cat'];
    whatsapp = json['whatsapp'];
    celebrityId = json['celebrity_id'];
    registerOtp = json['register_otp'];
    if (json['mobile_formats'] != null) {
      mobileFormats = [];
      json['mobile_formats'].forEach((v) {
        mobileFormats!.add(MobileFormats.fromJson(v));
      });
    }
  }
  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['integration'] = integration;
    data['rootcategory'] = rootcategory;
    if (slider != null) {
      data['slider'] = slider!.map((v) => v.toJson()).toList();
    }
    data['noimg'] = noimg;

    data['store_id'] = storeId;
    data['currency'] = currency;
    data['voucher_cat'] = voucherCat;
    data['whatsapp'] = whatsapp;
    data['celebrity_id'] = celebrityId;
    data['register_otp'] = registerOtp;
    if (mobileFormats != null) {
      data['mobile_formats'] = mobileFormats!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SliderModel {
  String? image;
  String? type;
  String? id;
  String? sortOrder;

  SliderModel({this.image, this.type, this.id, this.sortOrder});

  SliderModel.fromJson(Map<String?, dynamic> json) {
    image = json['image'];
    type = json['type'];
    id = json['id'];
    sortOrder = json['sort_order'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = {};
    data['image'] = image;
    data['type'] = type;
    data['id'] = id;
    data['sort_order'] = sortOrder;
    return data;
  }
}

class Catimages {
  String? id;
  String? img;

  Catimages({this.id, this.img});

  Catimages.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    img = json['img'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['id'] = id;
    data['img'] = img;
    return data;
  }
}

class MobileFormats {
  String? webiste;
  int? len;
  String? countryCode;
  String? country;
  int? id;

  MobileFormats(
      {this.webiste, this.len, this.countryCode, this.country, this.id});

  MobileFormats.fromJson(Map<String?, dynamic> json) {
    webiste = json['webiste'];
    len = json['len'];
    countryCode = json['country_code'];
    country = json['country'];
    id = json['id'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['webiste'] = webiste;
    data['len'] = len;
    data['country_code'] = countryCode;
    data['country'] = country;
    data['id'] = id;
    return data;
  }
}

class Cmspages {
  int? faq;
  int? about;
  int? terms;
  int? privacy;

  Cmspages({this.faq, this.about, this.terms, this.privacy});

  Cmspages.fromJson(Map<String?, dynamic> json) {
    faq = json['faq'];
    about = json['about'];
    terms = json['terms'];
    privacy = json['privacy'];
  }

  Map<String?, dynamic> toJson() {
    final Map<String?, dynamic> data = new Map<String?, dynamic>();
    data['faq'] = faq;
    data['about'] = about;
    data['terms'] = terms;
    data['privacy'] = privacy;
    return data;
  }
}
