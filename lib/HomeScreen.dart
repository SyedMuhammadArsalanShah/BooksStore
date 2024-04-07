import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'Cart.dart';
import 'utils/CustomWidget.dart';
import 'utils/sharedPreferencelogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  int indexname;
  HomeScreen(this.indexname, {super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CustomWidget cus = CustomWidget();
  List<dynamic> nameuser = [];
  List<dynamic> cimage = [
    'assets/c1.jpg',
    'assets/c2.PNG',
    'assets/c3.PNG',
    'assets/c4.PNG',
    'assets/c5.PNG',
  ];
  List<dynamic> cname = [
    'Mukhtasir Sahih Al-Bukhari',
    'The Sealed Nectar',
    'Enjoy Your Life - English',
    'Uswah Tul Alam',
    'BMaani ul Quran'
  ];
  List<dynamic> cprice = ['12.00', '12.00', '12.00', '12.00', '12.00'];

  List<dynamic> dimage = [
    'assets/p1.jpg',
    'assets/p2.jpg',
    'assets/p3.jpg',
    'assets/p4.jpg',
    'assets/p5.jpg',
  ];
  List<dynamic> dname = [
    'Riyad us Saliheen',
    'Qassasul ul Anbiya'
    'Balughul Maraam',
    'Hazrat Umar R.A',
    'The Noble Quran',
    'Mukhtasir Sahih Al-Bukhari',
  ];
  List<dynamic> dprice = ['12.00', '12.00', '12.00', '12.00', '12.00'];

  var name1;
  int _currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferenceLogin().getnameList().then((name) {
      setState(() {
        nameuser = name;
        name1 = nameuser[widget.indexname];
      });
    });
    updateCartItemCount();
  }

  Future<void> updateCartItemCount() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      // Retrieve the current lists from SharedPreferences
      List<String> ccimageList = prefs.getStringList('ccimage') ?? [];
      List<String> ccnameList = prefs.getStringList('ccname') ?? [];
      List<String> ccpriceList = prefs.getStringList('ccprice') ?? [];
      itemcount = ccimageList.length.toString();
    });
  }

  List<dynamic> ccimage = [];
  List<dynamic> ccname = [];
  List<dynamic> ccprice = [];
  var itemcount = "";
  Future<void> addtocardC(int index) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the current lists from SharedPreferences
    List<String> ccimageList = prefs.getStringList('ccimage') ?? [];
    List<String> ccnameList = prefs.getStringList('ccname') ?? [];
    List<String> ccpriceList = prefs.getStringList('ccprice') ?? [];

    // Add the new elements to the lists
    ccimageList.add(cimage.elementAt(index).toString());
    ccnameList.add(cname.elementAt(index).toString());
    ccpriceList.add(cprice.elementAt(index).toString());

    // Save the updated lists back to SharedPreferences
    prefs.setStringList('ccimage', ccimageList);
    prefs.setStringList('ccname', ccnameList);
    prefs.setStringList('ccprice', ccpriceList);

    // Update the local state if needed
    setState(() {
      ccimage = ccimageList;
      ccname = ccnameList;
      ccprice = ccpriceList;
      updateCartItemCount();
    });

    print(ccimage);
    print(ccname);
    print(ccprice);
  }

  Future<void> addtocardD(int index) async {
    final prefs = await SharedPreferences.getInstance();

    // Retrieve the current lists from SharedPreferences
    List<String> ccimageList = prefs.getStringList('ccimage') ?? [];
    List<String> ccnameList = prefs.getStringList('ccname') ?? [];
    List<String> ccpriceList = prefs.getStringList('ccprice') ?? [];

    // Add the new elements to the lists
    ccimageList.add(dimage.elementAt(index).toString());
    ccnameList.add(dname.elementAt(index).toString());
    ccpriceList.add(dprice.elementAt(index).toString());

    // Save the updated lists back to SharedPreferences
    prefs.setStringList('ccimage', ccimageList);
    prefs.setStringList('ccname', ccnameList);
    prefs.setStringList('ccprice', ccpriceList);

    // Update the local state if needed
    setState(() {
      ccimage = ccimageList;
      ccname = ccnameList;
      ccprice = ccpriceList;
      updateCartItemCount();
    });

    print(ccimage);
    print(ccname);
    print(ccprice);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey[100],
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.person_alt_circle,
                  color: Colors.black,
                  size: 40,
                ),
                SizedBox(
                  width: 7,
                ),
                Text(
                  name1,
                  style: TextStyle(fontSize: 26, color: Colors.black),
                ),
              ],
            ),
            actions: [
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Cart(
                          ccimage.toList(),
                          ccname.toList(),
                          ccprice.toList(),
                          updateCartItemCount,
                          name1,
                        ),
                      ),
                    );
                    print(ccimage);
                    print(ccname);
                    print(ccprice);
                  },
                  child: badges.Badge(
                    badgeContent: Text(
                      itemcount.isEmpty ? '0' : '$itemcount',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    child: Icon(
                      CupertinoIcons.shopping_cart,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(CupertinoIcons.bell),
                color: Colors.black,
              ),
            ]),
        body: Container(
          child: Column(
            children: [
              CarouselSlider(
                items: [
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/5480095.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/4056272.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Card(
                    elevation: 2,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      'assets/5483988.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ],
                options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 3), // Adjust as needed
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  3, // Number of carousel items
                  (index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                ),
              ),
              cus.padd(EdgeInsets.symmetric(horizontal: 10),
                  cus.Alignn(Alignment.topLeft, cus.Textt("New Arrival", 25))),
              SizedBox(
                height: 5,
              ),
              cus.listview(cimage, cname, cprice, addtocardC),
              SizedBox(
                height: 10,
              ),
              cus.padd(
                  EdgeInsets.symmetric(horizontal: 10),
                  cus.Alignn(
                      Alignment.topLeft, cus.Textt("Top Books Trend", 25))),
              SizedBox(
                height: 5,
              ),
              cus.listview(dimage, dname, dprice, addtocardD),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
