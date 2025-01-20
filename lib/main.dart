import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';
import 'const/constants.dart';
import 'const/customwidget.dart';
import 'controller/homecontroller.dart';
import 'controller/networkcontroller.dart';
import 'model/middlecategorymodel.dart';
import 'model/topcategorymodel.dart';

void main() {
  runApp(const MyApp());
  HomController homeController = Get.put(HomController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  HomController homeController = Get.find();
  final PageController _pageViewController = PageController(initialPage: 0); // set the initial page you want to show
  int _activePage = 0;

  @override
  void initState() {
    super.initState();
    //addData();
    getApiData();
  }

  getApiData() async{
    if(homeController.topCategoryModel == null && homeController.middleCategoryModel == null && homeController.bottomCategoryModel == null && homeController.categoryModel == null) {
      await homeController.callApi();
    }
    homeController.updateScree();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 4,
            centerTitle: controller.selectedIndex == 0 ? false : true,
            title:  controller.selectedIndex == 0 ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(Icons.ac_unit_outlined,color: Colors.black,size: 20,),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(StringRes.FABCURATE,style: const TextStyle(fontSize: 16,color: Colors.black),),
                          Text(StringRes.OWN,style: const TextStyle(fontSize: 12,color: Colors.black),)
                        ],
                      ),
                    ),
                  ],
                )
                :
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(Icons.arrow_back_ios_new,color: Colors.black,size: 20,),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 10),
                    //color: Colors.red,
                    child: Column(
                      //mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(StringRes.CATEGORY,style: const TextStyle(fontSize: 16,color: Colors.black),),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            //Text(StringRes.CATEGORY,style: TextStyle(fontSize: 16,color: Colors.black),),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search,color: Colors.black,)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.shopping_cart,color: Colors.black,))
            ],
          ),
          body: controller.isCallAPi ? Container(
            //color: Colors.blue,
            margin: const EdgeInsets.only(bottom: 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  controller.selectedIndex == 0 ? homeWidget() : categoryWidget()
                ],
              ),
            ),
          ) : const Center(child: CircularProgressIndicator()),


          bottomNavigationBar:  SizedBox(
            height: 55,
            child: Theme(
              data: ThemeData(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                items:  <BottomNavigationBarItem>[
                  CustomWidget.bottomWidget(StringRes.HOME,Icons.home),
                  CustomWidget.bottomWidget(StringRes.CATEGORY,Icons.category),
                  CustomWidget.bottomWidget(StringRes.CURATE,Icons.currency_bitcoin),
                  CustomWidget.bottomWidget(StringRes.SALE,Icons.sd_card_alert),
                  CustomWidget.bottomWidget(StringRes.MORE,Icons.more_horiz),
                ],
                currentIndex: controller.selectedIndex,
                showSelectedLabels: true,
                unselectedFontSize: 12,
                selectedItemColor: Colors.lightGreen,
                unselectedItemColor: Colors.black,
                showUnselectedLabels: true,
                onTap: homeController.onItemTapped,
              ),
            ),
          ),
        );
      }
    );
  }

  homeWidget(){
    return  SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: Colors.transparent,
            margin: const EdgeInsets.only(left: 2),
            height: 85,
            child: ListView.builder(
              //shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: homeController.topCategoryModel!.mainStickyMenu!.length,
              itemBuilder: (context, index) {
               return CachedNetworkImage(
                 imageUrl: homeController.topCategoryModel!.mainStickyMenu![index].image!,
                 imageBuilder: (context, imageProvider) {
                   return InkWell(
                     onTap: () {
                       homeController.listPos = index;
                       homeController.getPagerLists();
                       print(homeController.pagerList);
                       homeController.updateScree();
                     },
                     child: Stack(
                       children: [
                         Container(
                           margin: const EdgeInsets.symmetric(horizontal: 5),
                           height: 80,
                           width: 110,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(5),
                           ),
                           child: Container(
                             decoration: BoxDecoration(
                                 borderRadius: const BorderRadius.all(Radius.circular(5)),
                                 image: DecorationImage(
                                   image: imageProvider,
                                   fit: BoxFit.cover,
                                 )
                             ),
                           ),
                         ),

                         Positioned(
                           bottom: 5,
                           left: 0,
                           right: 0,
                           child: Container(
                           margin: const EdgeInsets.symmetric(horizontal: 5),
                           decoration: const BoxDecoration(
                             color: Colors.white,
                             boxShadow: [
                               BoxShadow(
                                 blurRadius: 2.0,
                               ),
                             ],
                             borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5),bottomRight: Radius.circular(5)),
                           ),
                           alignment: Alignment.center,
                           child: Text(homeController.topCategoryModel!.mainStickyMenu![index].title!,style: TextStyle(color: Colors.black,fontSize: 12),),
                         ))
                       ],
                     ),
                   );
                 },
                 progressIndicatorBuilder: (context, url, downloadProgress) =>
                     Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                 errorWidget: (context, url, error) => const Icon(Icons.error),
               );
              },),
          ),

          const SizedBox(
            height: 15,
          ),

          SizedBox(
            height: 210,
            child: FlutterCarousel(items: homeController.pagerList.map((i) {
              //SliderImages sliderImages =
              SliderImages sliderImages = SliderImages.fromJson(jsonDecode(i));

              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: 200,
                    child: CachedNetworkImage(
                      imageUrl: sliderImages.image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Stack(
                              children:[
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.white70,
                                      height: 50,
                                    )),

                                Positioned(
                                    bottom: 20,
                                    left: 40,
                                    right: 40,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                     padding: const EdgeInsets.all(10),
                                     //height: 80,
                                      width: MediaQuery.of(context).size.width * 0.25,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Container(
                                              height: 40,
                                                child: Text(sliderImages.title!,style: const TextStyle(fontSize: 14,color: Colors.black,),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                                            Padding(
                                              padding: const EdgeInsets.only(top: 10),
                                              child: Text(sliderImages.cta!,style: const TextStyle(fontSize: 10,color: Colors.black),),
                                            )
                                        ],
                                      ),
                                    ))
                              ]
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                },
              );
            }).toList(),
              options:  CarouselOptions(
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  //reverse: true,
                  pageSnapping: false,
                  floatingIndicator: false,
                  height: 200),),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.SHOP_BY,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

          const SizedBox(
            height: 5,
          ),

          Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.blue,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.shopByCategory1.length,
              itemBuilder: (context, index) {
                    return Container(
                        child: CatCard(category: homeController.shopByCategory1[index]));
            },),
          ),

          const SizedBox(
            height: 10,
          ),

          Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 5),
            //color: Colors.blue,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.shopByCategory2.length,
              itemBuilder: (context, index) {
                return Container(
                    child: CatCard(category: homeController.shopByCategory2[index]));
              },),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.SHOP_BY_FABRIC,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

            //todo
          const SizedBox(
            height: 5,
          ),

          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.shopByFabric1.length,
              itemBuilder: (context, index) {
                return Container(
                    child: FabCard(category: homeController.shopByFabric1[index]));
              },),
          ),

          const SizedBox(
            height: 10,
          ),

          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.shopByFabric2.length,
              itemBuilder: (context, index) {
                return Container(
                    child: FabCard(category: homeController.shopByFabric2[index]));
              },),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.UNSTITCHED,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

          const SizedBox(
            height: 5,
          ),

          SizedBox(
            height: 310,
            child: FlutterCarousel(items: homeController.sliderList.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  Unstitched unstitched = Unstitched.fromJson(jsonDecode(i));
                  return Container(
                    height: 300,
                    child: CachedNetworkImage(
                      imageUrl: unstitched.image!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Stack(
                              children:[
                                Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),

                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      //color: Colors.white,
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20),
                                            child: Align(
                                              alignment: Alignment.center,
                                                child: Text(unstitched.description!,style: const TextStyle(color: Colors.white,fontSize: 12),)),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                                            child: Align(
                                              alignment: Alignment.center,
                                                child: Text(unstitched.name!,style: const TextStyle(color: Colors.white,fontSize: 22),)),
                                          ),
                                        ],
                                      ),
                                    ))
                              ]
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                },
              );
            }).toList(),
              options:  CarouselOptions(
                  viewportFraction: 0.8,
                  enlargeCenterPage: true,
                  pageSnapping: false,
                  floatingIndicator: false,
                  allowImplicitScrolling: true,
                  height: 300,
              ),),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.BOUTIQUE,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

          const SizedBox(
            height: 5,
          ),

          Container(
            height: 410,
            child: PageView.builder(
                controller: _pageViewController,
                onPageChanged: (int index){
                  setState(() {
                    _activePage = index;
                  });
                },
                itemCount: homeController.middleCategoryModel!.boutiqueCollection!.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 400,
                    child: CachedNetworkImage(
                      imageUrl: homeController.middleCategoryModel!.boutiqueCollection![index].bannerImage!,
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(0)
                          ),
                          child: Stack(
                              children:[
                                Container(
                                  decoration: BoxDecoration(
                                    //borderRadius: BorderRadius.all(Radius.circular(10)),
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      )
                                  ),
                                ),

                                //cmnt
                                Positioned(
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Container(
                                      color: Colors.transparent,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 20),
                                            child: Text(homeController.middleCategoryModel!.boutiqueCollection![index].name!,style: const TextStyle(color: Colors.white,fontSize: 22),),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10,right: 20,bottom: 10),
                                            child: Text(homeController.middleCategoryModel!.boutiqueCollection![index].cta!,style: const TextStyle(color: Colors.white,fontSize: 14),),
                                          ),
                                        ],
                                      ),
                                    ))
                              ]
                          ),
                        );
                      },
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                  );
                }
            ),
          ),

          const SizedBox(
            height: 10,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(
                homeController.middleCategoryModel!.boutiqueCollection!.length,
                    (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: InkWell(
                    onTap: () {
                      _pageViewController.animateToPage(index,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn);
                    },
                    child: CircleAvatar(
                      radius: 5,

                      backgroundColor: _activePage == index
                          ? Colors.black
                          : Colors.grey,
                    ),
                  ),
                )),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.Pattern,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

          const SizedBox(
            height: 5,
          ),

          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.rangeOfPattern1.length,
              itemBuilder: (context, index) {
                return Container(
                    child: PatternCard(category: homeController.rangeOfPattern1[index]));
              },),
          ),

          const SizedBox(
            height: 10,
          ),

          Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: homeController.rangeOfPattern2.length,
              itemBuilder: (context, index) {
                return Container(
                    child: PatternCard(category: homeController.rangeOfPattern2[index]));
              },),
          ),

          const SizedBox(
            height: 5,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(StringRes.OCCASSION,style: const TextStyle(fontSize: 16,color: Colors.black),),
          ),

          const SizedBox(
            height: 5,
          ),

          Flexible(
            fit: FlexFit.loose,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: homeController.bottomCategoryModel!.designOccasion!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10
                ), itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 90,
                  child: CachedNetworkImage(
                    imageUrl: homeController.bottomCategoryModel!.designOccasion![index].image!,
                    imageBuilder: (context, imageProvider) {
                      return Container(
                        child: Stack(
                            children:[
                              Container(
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),

                              Positioned(
                                      bottom: 0,
                                      left: 0,
                                      right: 0,
                                      child: Container(
                                        color: Colors.white70,
                                        alignment: Alignment.topLeft,
                                        padding: const EdgeInsets.symmetric(horizontal: 5),
                                        child: Column(
                                          children: [
                                            Text(homeController.bottomCategoryModel!.designOccasion![index].name!,style: TextStyle(fontSize: 10,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: const EdgeInsets.only(left: 0),
                                                    child: Align(
                                                        alignment: Alignment.topLeft,child: Text(homeController.bottomCategoryModel!.designOccasion![index].subName!,style: TextStyle(fontSize: 8,color: Colors.black),maxLines: 1,overflow: TextOverflow.ellipsis)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(right: 0),
                                                  child: Text(homeController.bottomCategoryModel!.designOccasion![index].cta!,style: TextStyle(fontSize: 6,color: Colors.black),),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                            ]
                        ),
                      );
                    },
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                );
              },
              ),
            ),
          )
        ],
      ),
    );
  }


  categoryWidget() {
    return SingleChildScrollView(
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: homeController.categoryModel!.categories!.length,
        itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    if(homeController.categoryModel!.categories![index].isShow){
                      homeController.categoryModel!.categories![index].isShow = false;
                    } else {
                      homeController.categoryModel!.categories![index].isShow = true;
                    }
                    homeController.updateScree();
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 3),
                    height: 150,
                    //color: Colors.red,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          homeController.categoryModel!.bannerImage!,fit: BoxFit.cover,),
                        Positioned(
                          left: 10,
                          right : 0,
                          top : 0,
                          bottom : 0,
                            child: Container(
                              height: 150,
                              alignment: Alignment.centerLeft,
                                child: Text(homeController.categoryModel!.categories![index].categoryName!,style: const TextStyle(color: Colors.white,fontSize: 14),)))
                      ],
                    ),
                  ),
                ),

                //todo
                Visibility(
                  visible: homeController.categoryModel!.categories![index].isShow,
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: homeController.categoryModel!.categories![index].child!.length,
                    itemBuilder: (context, indexMain) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 2),
                      //color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(homeController.categoryModel!.categories![index].child![indexMain].categoryName!,style: TextStyle(color: Colors.black,fontSize: 12),),
                            )
                        ],
                      ),
                    );
                  },),
                )
              ],
            );
      },)
    );
  }
}


