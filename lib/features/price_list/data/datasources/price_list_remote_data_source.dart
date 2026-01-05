import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fap/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';
import 'package:fap/features/price_list/data/models/price_list_details_model.dart';
import 'package:fap/features/price_list/data/models/price_list_model.dart';
import 'package:fap/features/price_list/data/models/create_order_request_model.dart';
import 'package:fap/features/price_list/data/models/create_order_response_model.dart';

abstract class PriceListRemoteDataSource {
  Future<List<PriceListItemModel>> getPriceLists();
  Future<List<Category>> getCategories();
  Future<List<ProductItemModel>> getPriceListDetails(int priceListId);
  Future<CreateOrderResponseModel> createOrder(CreateOrderRequestModel request);
}

class PriceListRemoteDataSourceImpl implements PriceListRemoteDataSource {
  final Dio dio;
  final SharedPreferences sharedPreferences;

  PriceListRemoteDataSourceImpl({
    required this.dio,
    required this.sharedPreferences,
  });

  @override
  Future<List<PriceListItemModel>> getPriceLists() async {
    try {
      final token = sharedPreferences.getString('auth_token');
      final response = await dio.get(
        'https://fapautoapps.com/ords/app/priceList/myPriceList',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final model = PriceListModel.fromJson(response.data);
        return model.priceLists;
      } else {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          type: DioExceptionType.badResponse,
        );
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<Category>> getCategories() async {
    // This seems to be a legacy method or duplicate.
    // If getPriceLists returns the categories, we might not need this or it should map.
    // For now, I'll leave it as unimplemented or return empty to satisfy interface.
    return [];
  }

  @override
  Future<List<ProductItemModel>> getPriceListDetails(int priceListId) async {
    final token = sharedPreferences.getString('auth_token');

    if (token == null) {
      throw Exception('User not authenticated');
    }

    try {
      final response = await dio.get(
        '${AuthRemoteDataSource.baseUrl}/priceList/itemsPriceList',
        queryParameters: {'priceListId': priceListId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200) {
        final responseModel = PriceListDetailsResponseModel.fromJson(
          response.data,
        );
        return responseModel.items;
      } else {
        throw Exception('Failed to load price list details');
      }
    } catch (e) {
      throw Exception('Failed to load price list details: $e');
    }
  }

  @override
  Future<CreateOrderResponseModel> createOrder(
    CreateOrderRequestModel request,
  ) async {
    final token = sharedPreferences.getString('auth_token');

    if (token == null) {
      throw Exception('User not authenticated');
    }

    try {
      print('=== CREATE ORDER REQUEST ===');
      print(
        'URL: ${AuthRemoteDataSource.baseUrl}/Transactions/CreateRequestInvoice',
      );
      print('Request Body: ${request.toJson()}');

      final response = await dio.post(
        '${AuthRemoteDataSource.baseUrl}/Transactions/CreateRequestInvoice',
        data: request.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      print('=== CREATE ORDER RESPONSE ===');
      print('Status Code: ${response.statusCode}');
      print('Response Data: ${response.data}');

      if (response.statusCode == 200) {
        return CreateOrderResponseModel.fromJson(response.data);
      } else {
        throw Exception('Failed to create order');
      }
    } catch (e) {
      print('=== CREATE ORDER ERROR ===');
      print('Error: $e');
      throw Exception('Failed to create order: $e');
    }
  }
}
