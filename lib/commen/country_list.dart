// lib/models/country_list.dart

/// Country model for country_flags package
class Country {
  final String name; // Country name
  final String code; // ISO 2-letter code, e.g., 'pk'
  final String dialCode; // Phone code, e.g., '+92'

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
  });
}

/// 🔹 Reusable country list with ISO code (lowercase) and dial code
const List<Country> countryList = [
  Country(name: 'Pakistan', code: 'pk', dialCode: '+92'),
  Country(name: 'India', code: 'in', dialCode: '+91'),
  Country(name: 'United States', code: 'us', dialCode: '+1'),
  Country(name: 'United Kingdom', code: 'gb', dialCode: '+44'),
  // Country(name: 'Canada', code: 'ca', dialCode: '+1'),
  Country(name: 'Australia', code: 'au', dialCode: '+61'),
  Country(name: 'Germany', code: 'de', dialCode: '+49'),
  Country(name: 'France', code: 'fr', dialCode: '+33'),
  Country(name: 'Italy', code: 'it', dialCode: '+39'),
  Country(name: 'Spain', code: 'es', dialCode: '+34'),
  Country(name: 'Brazil', code: 'br', dialCode: '+55'),
  Country(name: 'Mexico', code: 'mx', dialCode: '+52'),
  Country(name: 'China', code: 'cn', dialCode: '+86'),
  Country(name: 'Japan', code: 'jp', dialCode: '+81'),
  Country(name: 'South Korea', code: 'kr', dialCode: '+82'),
  Country(name: 'Russia', code: 'ru', dialCode: '+7'),
  Country(name: 'Turkey', code: 'tr', dialCode: '+90'),
  Country(name: 'Saudi Arabia', code: 'sa', dialCode: '+966'),
  Country(name: 'UAE', code: 'ae', dialCode: '+971'),
  Country(name: 'Egypt', code: 'eg', dialCode: '+20'),
  Country(name: 'South Africa', code: 'za', dialCode: '+27'),
  Country(name: 'Nigeria', code: 'ng', dialCode: '+234'),
  Country(name: 'Kenya', code: 'ke', dialCode: '+254'),
  Country(name: 'Argentina', code: 'ar', dialCode: '+54'),
  Country(name: 'Chile', code: 'cl', dialCode: '+56'),
  Country(name: 'Colombia', code: 'co', dialCode: '+57'),
  Country(name: 'Thailand', code: 'th', dialCode: '+66'),
  Country(name: 'Vietnam', code: 'vn', dialCode: '+84'),
  Country(name: 'Malaysia', code: 'my', dialCode: '+60'),
  Country(name: 'Indonesia', code: 'id', dialCode: '+62'),
  Country(name: 'Philippines', code: 'ph', dialCode: '+63'),
  Country(name: 'Singapore', code: 'sg', dialCode: '+65'),
  Country(name: 'New Zealand', code: 'nz', dialCode: '+64'),
  Country(name: 'Norway', code: 'no', dialCode: '+47'),
  Country(name: 'Sweden', code: 'se', dialCode: '+46'),
  Country(name: 'Finland', code: 'fi', dialCode: '+358'),
  Country(name: 'Netherlands', code: 'nl', dialCode: '+31'),
  Country(name: 'Switzerland', code: 'ch', dialCode: '+41'),
  Country(name: 'Ireland', code: 'ie', dialCode: '+353'),
  Country(name: 'Belgium', code: 'be', dialCode: '+32'),
];
const List<String> visaTypeList = ['Travel', 'Student', 'Work', 'Investment'];
