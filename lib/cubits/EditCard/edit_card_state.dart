part of 'edit_card_cubit.dart';

@immutable
sealed class EditCardState {}

final class EditCardInitial extends EditCardState {}

final class EditCard extends EditCardState {}

final class LoadSaveChangeCard extends EditCardState {}

final class SaveChangeDoneCard extends EditCardState {}

final class FailSaveChangeCard extends EditCardState {}
