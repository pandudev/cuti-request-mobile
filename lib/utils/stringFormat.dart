import 'package:recase/recase.dart';

class StringFormat {
  StringFormat(this.string);
  final String string;

  String titlecase(string) {
    ReCase retVal = ReCase(string);
    return retVal.titleCase;
  }
}
