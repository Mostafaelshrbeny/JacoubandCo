abstract class UploadState {}

class InitialState extends UploadState {}

class UploadLoadingState extends UploadState {}

class UploadDoneState extends UploadState {}

class UploadFailedState extends UploadState {}
