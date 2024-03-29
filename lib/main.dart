import 'package:hello_world/custom_appbar.dart';
import 'package:hello_world/custom_shape_clipper.dart';
import 'package:hello_world/flight_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

Color firstColor = Colors.teal;
Color secondColor = Colors.cyan;

ThemeData appTheme =
    ThemeData(primaryColor: Colors.teal, fontFamily: "Oxygen",);

List<String> locations = ['Boston [BOS]', 'New York City [JFK]'];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
              child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            homeScreenBottom,
            homeScreenBottom
          ],
        ),
      ),
    );
  }
}

const TextStyle dropdownLableStyle =
    TextStyle(color: Colors.white, fontSize: 16);
const TextStyle dropdownMenuItemStyle =
    TextStyle(color: Colors.black, fontSize: 16,fontWeight: FontWeight.bold);

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 400,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [firstColor, secondColor])),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.location_on, color: Colors.white),
                      SizedBox(
                        width: 16,
                      ),
                      PopupMenuButton(
                          onSelected: (index) {
                            setState(() {
                              selectedLocationIndex = index;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Text(
                                locations[selectedLocationIndex],
                                style: dropdownLableStyle,
                              ),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.white,
                              )
                            ],
                          ),
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuItem<int>>[
                                PopupMenuItem(
                                  child: Text(
                                    locations[0],
                                    style: dropdownMenuItemStyle,
                                  ),
                                  value: 0,
                                ),
                                PopupMenuItem(
                                  child: Text(
                                    locations[1],
                                    style: dropdownMenuItemStyle,
                                  ),
                                  value: 1,
                                )
                              ]),
                      Spacer(),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Text(
                  "Where would\nyou want to go?",
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: TextField(
                      controller: TextEditingController(text: locations[1]),
                      style: dropdownMenuItemStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 32, vertical: 13),
                          suffixIcon: Material(
                            elevation: 2.0,
                            borderRadius:
                                BorderRadius.all(Radius.circular(30.0)),
                            child: InkWell(
                        child: Icon(
                                Icons.search,
                                color: Colors.black,
                              ),

                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder:(BuildContext context)=> FlightListScreen() ));
                              },
                            ),
                          ),
                          border: InputBorder.none),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: ChoiceChip(
                          Icons.flight_takeoff, "Flights", isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = true;
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(
                      child:
                          ChoiceChip(Icons.hotel, "Hotels", isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = false;
                        });
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiceChip(this.icon, this.text, this.isSelected);

  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 8.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(Radius.circular(20)))
          : null,
      child: Row(
        children: <Widget>[
          Icon(
            widget.icon,
            size: 20,
            color: Colors.white,
          ),
          SizedBox(
            width: 8,
          ),
          Text(widget.text, style: TextStyle(color: Colors.white, fontSize: 16))
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14, color: appTheme.primaryColor,fontWeight: FontWeight.w900);

var homeScreenBottom = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Text("Currently Wtached Items", style: dropdownMenuItemStyle),
          Spacer(),
          Text("VIEW ALl", style: viewAllStyle),
        ],
      ),
    ),
    Container(
      height: 240,
      child: ListView(scrollDirection: Axis.horizontal, children: cityCards),
    )
  ],
);

List<CityCard> cityCards = [
  CityCard("Las Vegas", "45", "assets/images/lasvegas.jpg", "Feb 2019", 2250,
      4299),
  CityCard(
      "Athens", "50", "assets/images/athens.jpg", "Apr 2019", 4359, 9999),
  CityCard(
      "Sydney", "48", "assets/images/sydney.jpeg", "Dec 2019", 2399, 5999),
];

final formatCurrency = NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount;
  int oldPrice, newPrice;

  CityCard(this.cityName, this.discount, this.imagePath, this.monthYear,
      this.newPrice, this.oldPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210,
                  width: 160,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0,
                  bottom: 0,
                  width: 160,
                  height: 60,
                  child: Container(
                    decoration: BoxDecoration(  
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black,
                          Colors.black.withOpacity(0.1)
                        ]
                      )
                    ),
                  ),

                ),
                Positioned(
                  left: 10,
                  bottom: 10,
                  right: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(cityName,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 18)),
                          Text(monthYear,
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                  fontSize: 14))
                        ],
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          '$discount%',
                          style: TextStyle(fontSize: 14.0, color: Colors.black,),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
         Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(
                  '${formatCurrency.format(newPrice)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 14.0),
                ),
              ),
              SizedBox(
                width: 6.0,
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0),
                child: Text(
                  "(${formatCurrency.format(oldPrice)})",
                  style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.0),
                ),
              ),
            ],
          )  
        ],
      ),
    );
  }
}
