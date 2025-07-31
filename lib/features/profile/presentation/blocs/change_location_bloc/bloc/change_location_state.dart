class ChangeLocationState {
  final String country;
  final String city;
  final String zip;
  final String address;
  final bool isUpdating;
  final bool updateSuccess;
  final String? error;

  ChangeLocationState({
    this.country = '',
    this.city = '',
    this.zip = '',
    this.address = '',
    this.isUpdating = false,
    this.updateSuccess = false,
    this.error,
  });

  ChangeLocationState copyWith({
    String? country,
    String? city,
    String? zip,
    String? address,
    bool? isUpdating,
    bool? updateSuccess,
    String? error,
  }) {
    return ChangeLocationState(
      country: country ?? this.country,
      city: city ?? this.city,
      zip: zip ?? this.zip,
      address: address ?? this.address,
      isUpdating: isUpdating ?? this.isUpdating,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      error: error,
    );
  }
}
