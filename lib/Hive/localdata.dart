import 'package:hive/hive.dart';

Box? loginbox;
Future<Box> openbox(String boxname) async {
  return await Hive.openBox(boxname);
}
