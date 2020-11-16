import 'dart:convert';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}
final List<String> countries=["Egypt","Albania","Algeria","Andorra",
  "Angola","Anguilla",
  "Mexico","Slovakia",
  "UAE","USA",
  "Yemen","Zambia","Zimbabwe"];
final List<String> images=['assets/images/egyptimage.png','assets/images/albaniaf.png','assets/images/algeriaflag.png','assets/images/andorra.png'
,'assets/images/angola.jpg','assets/images/anguilla.jpg','assets/images/mexico.png','assets/images/slovakia.jpg'
  ,'assets/images/uae.png','assets/images/usapng.png','assets/images/yamann.png','assets/images/zambia.jpg'
  ,'assets/images/zimbabwe.jpg'
];
class _HomeScreenState extends State<HomeScreen> {
  Map data=Map<String, int>();
  String name="USA";
  fetchData() async{
    http.Response response=await http.get('https://disease.sh/v2/countries/$name');
    setState(() {
      data=json.decode(response.body);
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.white,
      body: WillPopScope(
         onWillPop: onWillPop,
        child: Container(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  child: ListView(
                    physics: const NeverScrollableScrollPhysics(),
                    children:<Widget> [
                      SizedBox(height: 15.0,),
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 180.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16/9,
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enableInfiniteScroll: true,
                          autoPlayAnimationDuration: Duration(milliseconds: 800),
                          viewportFraction: 0.8,
                        ),
                        items: [
                          Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/coronaaa.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),Container(
                            margin: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                image: AssetImage('assets/images/coronava.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                Container(
                  child: new GridView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
                    children: <Widget>[
                      StatusPanal(
                        title: 'Cases',
                        panelColor: Colors.red[100],
                        textColor: Colors.red,
                        count: data['cases'].toString(),
                      ),
                      StatusPanal(
                        title: 'Today Cases',
                        panelColor: Colors.blue[100],
                        textColor: Colors.blue[900],
                        count: data['todayCases'].toString(),
                      ),
                      StatusPanal(
                        title: 'Deaths',
                        panelColor: Colors.orange[100],
                        textColor: Colors.orange[900],
                        count: data['deaths'].toString(),
                      ),
                      StatusPanal(
                        title: 'Today Deaths',
                        panelColor: Colors.green[100],
                        textColor: Colors.green,
                        count: data['todayDeaths'].toString(),
                      ),
                      StatusPanal(
                        title: 'Recovered',
                        panelColor: Colors.purple[100],
                        textColor: Colors.purple[900],
                        count: data['recovered'].toString(),
                      ),
                      StatusPanal(
                        title: 'Today Recovered',
                        panelColor: Colors.lightBlueAccent,
                        textColor: Colors.deepPurple,
                        count: data['todayRecovered'].toString(),
                      ),
                    ],
                  ),
                ),
            Expanded(

                  //color: Colors.blueAccent,
                  child: ListView.builder(
                    itemCount: countries.length,
                    itemBuilder: (context ,i){

                        return Card(
                          elevation: 60.0,
                          child: ListTile(
                            title: Text(countries[i],style: GoogleFonts.anton(
                              textStyle: TextStyle(
                                color: Colors.black54,
                                // fontSize: 25,
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            ),
                            leading: CircleAvatar(
                                child: ClipRRect
                                  (
                                  borderRadius:BorderRadius.circular(50),
                                  child: Image.asset(
                                      images[i]),
                                )
                            ),
                            onTap: ()
                            {
                              name=countries[i];
                              fetchData();
                            },
                          ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
Future<bool> onWillPop() {
  exit(0);
}

class StatusPanal extends StatelessWidget {

  final Color panelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPanal({Key key, this.panelColor, this.textColor, this.title, this.count}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.height;
    return Container(
      margin: EdgeInsets.all(10),
      color: panelColor,
      height: 100,
      width: width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: <Widget>[Text(title,style:TextStyle(fontWeight:FontWeight.bold ,fontSize: 16,color: textColor) ,),Text(count,style: TextStyle(fontSize: 16,fontWeight:FontWeight.bold ,color: textColor),)],
      ),
    );
  }
}

