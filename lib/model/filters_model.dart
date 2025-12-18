// lib/model/filters_model.dart

class FiltersModel {
  String selectedVisaType;
  String selectedCountry;
  String selectedRegion;
  String selectedRegion2;
  DateTime? fromDate;
  DateTime? toDate;
  Set<String> selectedStatuses;

  final List<String> countries;
  final List<String> regions;

  FiltersModel({
    this.selectedVisaType = 'Investment',
    this.selectedCountry = 'Pakistan',
    this.selectedRegion = 'Any',
    this.selectedRegion2 = 'Any',
    this.fromDate,
    this.toDate,
    Set<String>? selectedStatuses,
    List<String>? countries,
    List<String>? regions,
  }) : selectedStatuses = selectedStatuses ?? {'Payment Configuration'},
       countries =
           countries ??
           [
             'Pakistan',
             'Germany',
             'United States',
             'United Kingdom',
             'Canada',
             'Australia',
             'France',
             'Italy',
             'Spain',
             'Japan',
           ],
       regions =
           regions ??
           [
             'Any',
             'Europe',
             'Asia',
             'North America',
             'South America',
             'Africa',
             'Oceania',
           ];

  void reset() {
    selectedVisaType = '';
    selectedCountry = 'Pakistan';
    selectedRegion = 'Any';
    selectedRegion2 = 'Any';
    fromDate = null;
    toDate = null;
    selectedStatuses.clear();
  }

  FiltersModel copy() {
    return FiltersModel(
      selectedVisaType: selectedVisaType,
      selectedCountry: selectedCountry,
      selectedRegion: selectedRegion,
      selectedRegion2: selectedRegion2,
      fromDate: fromDate,
      toDate: toDate,
      selectedStatuses: Set<String>.from(selectedStatuses),
      countries: List<String>.from(countries),
      regions: List<String>.from(regions),
    );
  }
}
