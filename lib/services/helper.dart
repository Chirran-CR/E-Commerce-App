import "package:flutter/services.dart" as the_bundle;
import 'package:e_commerce_app/models/sneaker_model.dart';

class Helper {
  //all Male Sneakers
  Future<List<Sneakers>> getMaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    return maleList;
  }

  //all female Sneakers
  Future<List<Sneakers>> getFemaleSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakersFromJson(data);
    return femaleList;
  }

  //all kids Sneakers
  Future<List<Sneakers>> getKidSneakers() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidsList = sneakersFromJson(data);
    return kidsList;
  }

  //get single male sneakers
  Future<Sneakers> getMaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");
    final maleList = sneakersFromJson(data);
    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //get single female sneakers
  Future<Sneakers> getFenaleSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");
    final femaleList = sneakersFromJson(data);
    final sneaker = femaleList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }

  //get single kid sneakers
  Future<Sneakers> getKidSneakersById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");
    final kidList = sneakersFromJson(data);
    final sneaker = kidList.firstWhere((sneaker) => sneaker.id == id);
    return sneaker;
  }
}
