import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:http/http.dart' as http;
import 'package:parcial_two/model/appointment_model.dart';
import 'package:parcial_two/repository/appointment_repository.dart';
import 'package:parcial_two/repository/patient_repository.dart';

class AppointmentBloc implements Bloc {
  Future<List<Appointment>> blocListAppointment(http.Client client) {
    return listAppointment(client);
  }

  @override
  void dispose() {}
}
