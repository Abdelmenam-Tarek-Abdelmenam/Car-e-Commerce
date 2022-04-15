enum CarTransmission {
  all,
  automatic,
  manual,
}

extension ExtensionCarTransmission on CarTransmission {
  String get name {
    switch (this) {
      case CarTransmission.all:
        return 'all';
      case CarTransmission.automatic:
        return 'automatic';
      case CarTransmission.manual:
        return 'manual';
    }
  }
}
