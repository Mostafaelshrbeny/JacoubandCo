abstract class SupportMessageState {}

class InitialState extends SupportMessageState {}

class LoadingAllSupMessageState extends SupportMessageState {}

class GotAllSupMessageState extends SupportMessageState {}

class AllSupMessageFailedState extends SupportMessageState {}

class LoadingSupMessageState extends SupportMessageState {}

class GotSupMessageState extends SupportMessageState {}

class SupMessageFailedState extends SupportMessageState {}

class LoadingCreateSupState extends SupportMessageState {}

class CreatedSupState extends SupportMessageState {}

class CreatSupFailedState extends SupportMessageState {}

class LoadingEditSupState extends SupportMessageState {}

class EditedState extends SupportMessageState {}

class EditedSupFailedState extends SupportMessageState {}
