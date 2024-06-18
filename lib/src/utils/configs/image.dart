class Images {
  static const String logo = "assets/images/logo.png";
  static const String slider = "assets/images/slider.jpeg";
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
  static const String service11 = "assets/images/services-11.png";
  static const String service12 = "assets/images/services-12.png";
  static const String service13 = "assets/images/services-13.png";
  static const String service14 = "assets/images/services-14.png";
  static const String loading = "assets/images/loading.png";
  static const String defaultListing = "assets/images/default_image.jpeg";

  ///Singleton factory
  static final Images _instance = Images._internal();

  factory Images() {
    return _instance;
  }

  Images._internal();
}
