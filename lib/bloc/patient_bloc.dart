import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/model/patient_model.dart';
import 'package:parcial_two/repository/patient_repository.dart';

class PatientBloc implements Bloc {
  Future<List<Patient>> blocListPatient(http.Client client) {
    return listPatient(client);
  }

  @override
  void dispose() {}
}
