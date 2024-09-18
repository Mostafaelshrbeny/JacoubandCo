part of 'edit_company_cubit.dart';

@immutable
sealed class EditCompanyState {}

final class EditCompanyInitial extends EditCompanyState {}

final class Companyshow extends EditCompanyState {}

final class NewCompanyshow extends EditCompanyState {}
