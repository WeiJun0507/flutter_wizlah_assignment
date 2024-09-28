enum Gender {
  none(0),
  female(1),
  male(2),
  nonBinary(3);

  const Gender(this.value);

  final int value;

  String get title {
    switch (value) {
      case 1:
        return 'Female';
      case 2:
        return 'Male';
      case 3:
        return 'Non Binary';
      case 0:
      default:
        return 'None';
    }
  }
}
