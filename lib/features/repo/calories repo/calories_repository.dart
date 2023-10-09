import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:mygymbuddy/data/models/food_model.dart';

class CaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(
      {String? foodName}) async {
    var client = http.Client();

    try {
      var response =
          await client.get(Uri.parse("http://10.0.2.2:8000/foods/$foodName/"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final Map<String, dynamic> foodData = json.decode(response.body);

        // Map the single food data object to a FoodModel
        FoodModel foodInfo = FoodModel.fromMap(foodData);

        return [foodInfo]; // Return a list containing the single FoodModel
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}



class MultiCaloriesRepository {
  static Future<List<FoodModel>> getCaloricInformation(
      {String? foodName}) async {
    var client = http.Client();
    try {
      var response = await client.get(
          Uri.parse("http://10.0.2.2:8000/foods/get/$foodName/"));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final List<dynamic> foodDataList = json.decode(response.body);

        // Map each JSON object in the list to a FoodModel
        List<FoodModel> foodInfoList = foodDataList
            .map((foodData) => FoodModel.fromMap(foodData))
            .toList();

            

        return foodInfoList;
      } else {
        return [];
      }
    } catch (e) {
      log(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}

// class MultiCaloriesRepository {
//   static LocalStorage foodsLocalStorage = new LocalStorage("foods");

//   static Future<List<FoodModel>> getCaloricInformation({String? foodName}) async {
//     var client = http.Client();
//     try {
//       var response = await client.get(Uri.parse("http://10.0.2.2:8000/foods/"));

//       if (response.statusCode >= 200 && response.statusCode < 300) {
//         final decodedResponse = json.decode(response.body);

//         // Map each JSON object in the list to a FoodModel
//         List<FoodModel> foodInfoList = (decodedResponse as List)
//             .map((foodData) => FoodModel.fromMap(foodData))
//             .toList();

//         // Save the list of FoodModel objects to the cache
//         savePosts(foodInfoList);

//         return foodInfoList;
//       } else {
//         return [];
//       }
//     } catch (e) {
//       log(e.toString());
//       return [];
//     } finally {
//       client.close();
//     }
//   }

//   static void savePosts(List<FoodModel> foodModels) async {
//     await foodsLocalStorage.ready; //create instance
//    //set value mapping to json and convert to list
//     foodsLocalStorage.setItem("foods", foodModels.map((model) => model.toJson()).toList());
//   }

//   static Future<List<FoodModel>> getPostsFromCache() async {
//   await foodsLocalStorage.ready;
//   List<dynamic>? cachedData = foodsLocalStorage.getItem('foods');

//   if (cachedData == null) {
//     return [];
//   }

//   try {
//     List<FoodModel> cachedModels = cachedData
//         .map((data) => FoodModel.fromJson(data))
//         .toList();

//     return cachedModels;
//   } catch (e) {
//     log(e.toString());
//     return [];
//   }
// }

// }