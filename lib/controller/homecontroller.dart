import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:kombee/const/api.dart';

import '../model/bottomcategorymodel.dart';
import '../model/categorymodels.dart';
import '../model/middlecategorymodel.dart';
import '../model/topcategorymodel.dart';
import 'networkcontroller.dart';

class HomController extends GetxController{
  int selectedIndex = 0;
  //NetworkController networkController = Get.find();
  NetworkController networkController = Get.put(NetworkController());
  bool isCallAPi = false;
  TopCategoryModel? topCategoryModel;
  MiddleCategoryModel? middleCategoryModel;
  BottomCategoryModel? bottomCategoryModel;
  CategoryModel? categoryModel;
  int listPos = 0;
  List<String> pagerList = [];
  List<String> sliderList = [];
  //List<String> pageViewList = [];
  onItemTapped(int index) {
    selectedIndex = index;
      update();
  }

  updateScree(){
    update();
  }
  
  getPagerLists() {
    pagerList.clear();

    /*for(int i=0 ; i < middleCategoryModel!.unstitched!.length;i++){
      sliderList.add(jsonEncode(middleCategoryModel!.unstitched![i]));
    }*/

    
    for(int i=0 ; i < topCategoryModel!.mainStickyMenu![listPos].sliderImages!.length;i++){
        pagerList.add(jsonEncode(topCategoryModel!.mainStickyMenu![listPos].sliderImages![i]));
            //topCategoryModel!.mainStickyMenu![listPos].sliderImages![i].image!);
    }
  }

  callApi() async{
    try {
      var response = await networkController.callGetApi(Api.top_repository);

      if(response != null) {
        topCategoryModel = TopCategoryModel.fromJson(response);
      }

     var responceMiddle = await networkController.callGetApi(Api.middle_repository);

    if(responceMiddle != null) {
        middleCategoryModel = MiddleCategoryModel.fromJson(responceMiddle);
    }

    var responceBottom = await networkController.callGetApi(Api.bottom_repository);

    if(responceBottom != null) {
      bottomCategoryModel = BottomCategoryModel.fromJson(responceBottom);
    }

      var responseCategory = await networkController.callGetApi(Api.category_repository);

      if(responseCategory != null) {
        categoryModel = CategoryModel.fromJson(responseCategory);
      }

    getPagerLists();
    getSliderList();
    //getPageViewList();
    isCallAPi = true;

    }catch (e){
      print(e);
    }
  }

  getSliderList(){
    sliderList.clear();
    for(int i=0 ; i < middleCategoryModel!.unstitched!.length;i++){
      sliderList.add(jsonEncode(middleCategoryModel!.unstitched![i]));
    }

    for(int i = 0 ; i < middleCategoryModel!.shopByCategory!.length ; i++){
        if(i > ((middleCategoryModel!.shopByCategory!.length / 2) - 1)){
            shopByCategory2.add(middleCategoryModel!.shopByCategory![i]);
        } else {
          shopByCategory1.add(middleCategoryModel!.shopByCategory![i]);
        }
    }

    for(int i = 0 ; i < middleCategoryModel!.shopByFabric!.length ; i++){
      if(i > ((middleCategoryModel!.shopByFabric!.length / 2) - 1)){
        shopByFabric2.add(middleCategoryModel!.shopByFabric![i]);
      } else {
        shopByFabric1.add(middleCategoryModel!.shopByFabric![i]);
      }
    }

    for(int i = 0 ; i < bottomCategoryModel!.rangeOfPattern!.length ; i++) {
      if (i > ((bottomCategoryModel!.rangeOfPattern!.length / 2) - 1)) {
        rangeOfPattern2.add(bottomCategoryModel!.rangeOfPattern![i]);
      } else {
        rangeOfPattern1.add(bottomCategoryModel!.rangeOfPattern![i]);
      }
    }

  }

  List<ShopByCategory> shopByCategory1 = [];
  List<ShopByCategory> shopByCategory2 = [];
  List<ShopByFabric> shopByFabric1 = [];
  List<ShopByFabric> shopByFabric2 = [];
  List<RangeOfPattern> rangeOfPattern1 = [];
  List<RangeOfPattern> rangeOfPattern2 = [];

  // getPageViewList(){
  //   pageViewList.clear();
  //   for(int i=0 ; i < middleCategoryModel!.boutiqueCollection!.length;i++){
  //     pageViewList.add(middleCategoryModel!.boutiqueCollection![i].bannerImage!);
  //   }
  // }

}
