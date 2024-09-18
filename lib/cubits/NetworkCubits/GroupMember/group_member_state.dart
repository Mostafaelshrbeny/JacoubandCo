abstract class GroupMemberState {}

class InitialState extends GroupMemberState {}

class LoadOptionState extends GroupMemberState {}

class OptionDoneState extends GroupMemberState {}

class FailedOptionState extends GroupMemberState {}

class LoadingExitState extends GroupMemberState {}

class ExitDoneState extends GroupMemberState {}

class FailedToExitState extends GroupMemberState {}
