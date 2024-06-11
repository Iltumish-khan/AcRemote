import 'dart:math';

class Version implements Comparable<Version> {
  String? version;

  String? get() {
    return version;
  }

  Version(String? version) {
    if (version == null) throw ArgumentError("Version can not be null");
    if (!version.contains(RegExp(r'[0-9]+(\\.[0-9]+)*'))) {
      throw ArgumentError("Invalid version format");
    } else {
      this.version = version;
    }
  }

  @override
  int compareTo(Version? that) {
    if (that == null) return 1;
    List<String> thisParts = get()!.split('.');
    List<String> thatParts = that.get()!.split('.');
    int length = max(thisParts.length, thatParts.length);
    for (int i = 0; i < length; i++) {
      int thisPart = i < thisParts.length ? int.parse(thisParts[i]) : 0;
      int thatPart = i < thatParts.length ? int.parse(thatParts[i]) : 0;
      if (thisPart < thatPart) return -1;
      if (thisPart > thatPart) return 1;
    }
    return 0;
  }

  bool equals(Version? that) {
    if (this == that) return true;
    if (that == null) return false;
    if (get() != that.get()) return false;
    return compareTo(that) == 0;
  }
}
