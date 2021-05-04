import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/model/attention_staff_model.dart';
import 'package:parcial_two/repository/attention_staff_repository.dart';

class AttentionStaffBloc implements Bloc {
  Future<List<AttentionStaff>> blocListAttention(http.Client client) {
    return listAttentionStaff(client);
  }

  @override
  void dispose() {}
}
