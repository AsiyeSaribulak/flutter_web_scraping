import 'package:flutter/material.dart';

class SiirModelGetir with ChangeNotifier {
  late String resim;
  late String baslik;
  late String SairAd;
  late String icerik;
  late String video;
  late String tarih;
  late String buton;

  SiirModelGetir.with1({
    required this.baslik,
    required this.icerik,
    required this.video,
  });

  SiirModelGetir(
      {required this.resim,
      required this.baslik,
      required this.SairAd,
      required this.icerik,
      required this.buton});

  SiirModelGetir.withButon({required this.buton});
}
