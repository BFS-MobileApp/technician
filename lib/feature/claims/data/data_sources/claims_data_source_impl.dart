import 'package:technician/core/api/api_consumer.dart';
import 'package:technician/core/api/end_points.dart';
import 'package:technician/feature/claims/data/data_sources/claims_data_source.dart';

class ClaimsDataSourceImpl extends ClaimsDataSource{

  ApiConsumer consumer;


  ClaimsDataSourceImpl({required this.consumer});

  @override
  Future<Map<String, dynamic>> getAllClaims(Map<String, dynamic> data) async {
    print("Data being sent: $data");

    String queryString = data.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');

    print("Query String: $queryString");

    final res = await consumer.get('${EndPoints.claims}?$queryString');

    print("Response: $res");

    return res;
  }


  @override
  Future<Map<String, dynamic>> getAllTechnician(String claimId) async{
    final data = {
      "claim_id":claimId
    };
    final res = await consumer.get(EndPoints.claimTechnicians , queryParams: data);
    return res;
  }

}