import 'package:bloc/bloc.dart';
import 'package:chatjob/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'edit_company_state.dart';

class EditCompanyCubit extends Cubit<EditCompanyState> {
  EditCompanyCubit() : super(EditCompanyInitial());
  static EditCompanyCubit get(context) => BlocProvider.of(context);
  showCompany(int option) async {
    if (option == 1) {
      pref.setString('comshow', "Shown");
    } else {
      pref.setString('comshow', 'Hide');
    }
    pref.setInt('comnum', option);

    emit(Companyshow());
  }

  shownewCompany(int option) async {
    if (option == 1) {
      pref.setString('newcomshow', "Shown");
    } else {
      pref.setString('newcomshow', 'Hide');
    }
    pref.setInt('newcomnum', option);

    emit(NewCompanyshow());
  }
}
