import 'package:flutter/material.dart';
import 'package:flutter_web_scraping/model/siirGetirModel.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:provider/provider.dart';

class SiirGetirDetay extends StatefulWidget {
  @override
  State<SiirGetirDetay> createState() => _SiirGetirDetayState();
}

class _SiirGetirDetayState extends State<SiirGetirDetay> {
  /*
baslik:element.children[0].children[1].text.toString(),
video:element.children[1].attributes['src'].toString(),
icerik:element.children[3].text.toString(),

  */

  /* var url1 = Uri.parse("https://www.antoloji.com/siir/");

  Future getDataButon() async {
    var res = await http.get(url1);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("row")[1]
        .getElementsByClassName("poem-detail-box box")
        .forEach((element) {
      setState(() {
        siir.add(SiirModelGetir.withButon(
          buton: element.children[3].children[1].attributes['href'].toString(),
        ));
      });
    });
  }*/

  var data;
  bool isloading = false;
  List<SiirModelGetir> siir = [];
  var url = Uri.parse("https://www.antoloji.com/baskalasan-ask-siiri/");

  Future getDataDetay() async {
    setState(() {
      isloading = true;
    });
    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    var response = document
        .getElementsByClassName("content-bar")[0]
        .getElementsByClassName("poem-detail box")
        .forEach((element) {
      setState(() {
        siir.add(SiirModelGetir.with1(
          baslik: element.children[0].children[1].text.toString(),
          icerik: element.children[3].text.toString(),
          video: element.children[1].attributes['src'].toString(),
        ));
      });
    });
    setState(() {
      isloading = false;
    });
  }

  void initState() {
    super.initState();
    getDataDetay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Şiir Göster'),
        backgroundColor: Colors.purple,
      ),
      body: ListView.builder(
          itemCount: siir.length,
          itemBuilder: (BuildContext context, index) {
            String videoId;
            videoId = YoutubePlayer.convertUrlToId(siir[index].video)!;

            late YoutubePlayerController _controller = YoutubePlayerController(
              initialVideoId: videoId,
              flags: YoutubePlayerFlags(
                autoPlay: false,
                mute: false,
              ),
            );
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  YoutubePlayer(
                    controller: _controller,
                    liveUIColor: Colors.amber,
                    showVideoProgressIndicator: true, //ilerleme çubuğu
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 6,
                    child: Container(
                      width: 500,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            siir[index].baslik,
                            style: TextStyle(
                                color: Colors.purple,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            siir[index].icerik,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
