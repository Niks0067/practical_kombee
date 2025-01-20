import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/bottomcategorymodel.dart';
import '../model/middlecategorymodel.dart';

class CustomWidget {

 static bottomWidget(String name,IconData icon){
    return BottomNavigationBarItem(
      icon: Icon(icon),
      label: (name),
    );
  }
}

class FabCard extends StatelessWidget {
  final ShopByFabric? category;

  FabCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(90)),
              image: DecorationImage(image: NetworkImage(category!.image!),fit: BoxFit.cover,)
            ),
          ),

          Positioned(
            left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 15),
                //height: 20,
                alignment: Alignment.center,
                //color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(category!.name!, textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 14),maxLines: 2),
                ),
              ))
        ],
      ),
    );
  }
}

class PatternCard extends StatelessWidget {
  final RangeOfPattern? category;

  PatternCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(90)),
                image: DecorationImage(image: NetworkImage(category!.image!),fit: BoxFit.cover,)
            ),
          ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 15),
                height: 20,
                alignment: Alignment.center,
                //color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(category!.name!,textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 14),maxLines: 2),
                ),
              ))
        ],
      ),
    );
  }
}

class CatCard extends StatelessWidget {
  final ShopByCategory? category;

  CatCard({required this.category});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      margin: EdgeInsets.symmetric(horizontal: 7.5),
      child: Stack(
        children: [
          Container(
            decoration:  BoxDecoration(
                //color: Colors.red,
                //borderRadius: BorderRadius.all(Radius.circular(90)),
                image: DecorationImage(image: NetworkImage(category!.image!),fit: BoxFit.cover,)
            ),

          ),

          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                //margin: EdgeInsets.symmetric(horizontal: 10),
                //height: 20,
                alignment: Alignment.topLeft,
                color: Colors.white,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.topLeft,
                          child: Text(category!.name!,style: TextStyle(color: Colors.black,fontSize: 12),)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(category!.name!,style: TextStyle(color: Colors.black,fontSize: 10),)),
                    ),
                  ],
                ),
              ))
        ],
      ),
    );
  }
}


class FabricItem extends StatelessWidget {
  final String name;
  final String image;

  FabricItem({required this.name, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipOval(
          child: Image.network(
            image,
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(height: 5),
        Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}