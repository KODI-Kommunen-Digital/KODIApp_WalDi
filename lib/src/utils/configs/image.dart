class Images {
  static const String intro1 = "assets/images/intro_1.png";
  static const String intro2 = "assets/images/intro_2.png";
  static const String intro3 = "assets/images/intro_3.png";
  static const String logo = "assets/images/logo.png";
  static const String slide = "assets/images/slide.png";
  static const String whatsapp = "assets/images/whatsapp.png";
  static const String telegram = "assets/images/telegram.png";
  static const String viber = "assets/images/viber.png";
  static const String facebook = "assets/images/facebook.png";
  static const String flickr = "assets/images/flickr.png";
  static const String google = "assets/images/google.png";
  static const String linkedin = "assets/images/linkedin.png";
  static const String pinterest = "assets/images/pinterest.png";
  static const String youtube = "assets/images/youtube.png";
  static const String twitter = "assets/images/twitter.png";
  static const String tumblr = "assets/images/tumblr.png";
  static const String instagram = "assets/images/instagram.png";
  static const String service1 = "assets/images/services-1.png";
  static const String service2 = "assets/images/services-2.png";
  static const String service3 = "assets/images/services-3.png";
  static const String service4 = "assets/images/services-4.png";
  static const String service5 = "assets/images/services-5.png";
  static const String service6 = "assets/images/services-6.png";
  static const String service7 = "assets/images/services-7.png";
  static const String service8 = "assets/images/services-8.png";
  static const String service9 = "assets/images/services-9.png";
  static const String service10 = "assets/images/services-10.png";
  static const String defaultListing = "assets/images/default_image.jpeg";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
