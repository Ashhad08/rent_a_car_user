class BackendConfigs {
  final _baseUrl =
      'https://auditor-server-git-main-raamishshah010s-projects.vercel.app';

  get baseUrl => _baseUrl;
  final _customer = 'customer';
  final _login = 'login-customer';
  final _signUp = 'add-customer';
  final String _vehicle = 'vehicle';
  final _vehicleAllFeatures = 'all-features';

  String get vehicle => _vehicle;
  final _vehicleAllMakes = 'all-makes';
  final _vehicleAllTypes = 'all-types';
  final _vehicleAllModels = 'all-model';
  final _availableVehicle = 'available-vehicle';

  get availableVehicle => _availableVehicle;

  get signUp => _signUp;

  get customer => _customer;

  Uri buildUri({required List<dynamic> segments}) {
    return Uri.parse(
        '$baseUrl/${segments.map((e) => Uri.encodeComponent(e.toString())).join('/')}');
  }

  get login => _login;

  get vehicleAllFeatures => _vehicleAllFeatures;

  get vehicleAllMakes => _vehicleAllMakes;

  get vehicleAllTypes => _vehicleAllTypes;

  get vehicleAllModels => _vehicleAllModels;
}
