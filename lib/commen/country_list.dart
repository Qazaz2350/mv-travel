// lib/models/country_list.dart
import 'package:country_icons/country_icons.dart';

class Country {
  final String name; // Country name
  final String code; // ISO 2-letter code, e.g., 'pk'
  final String dialCode; // Phone code, e.g., '+92'
  final String flagAsset; // Path to flag asset in country_icons

  const Country({
    required this.name,
    required this.code,
    required this.dialCode,
    required this.flagAsset,
  });
}

/// 🔹 Reusable country list with flag and dial code
const List<Country> countryList = [
  Country(
    name: 'Pakistan',
    code: 'pk',
    dialCode: '+92',
    flagAsset: 'flags/png/pk.png',
  ),
  Country(
    name: 'India',
    code: 'in',
    dialCode: '+91',
    flagAsset: 'flags/png/in.png',
  ),
  Country(
    name: 'United States',
    code: 'us',
    dialCode: '+1',
    flagAsset: 'flags/png/us.png',
  ),
  Country(
    name: 'United Kingdom',
    code: 'gb',
    dialCode: '+44',
    flagAsset: 'flags/png/gb.png',
  ),
  Country(
    name: 'Canada',
    code: 'ca',
    dialCode: '+1',
    flagAsset: 'flags/png/ca.png',
  ),
  Country(
    name: 'Australia',
    code: 'au',
    dialCode: '+61',
    flagAsset: 'flags/png/au.png',
  ),
  Country(
    name: 'Germany',
    code: 'de',
    dialCode: '+49',
    flagAsset: 'flags/png/de.png',
  ),
  Country(
    name: 'France',
    code: 'fr',
    dialCode: '+33',
    flagAsset: 'flags/png/fr.png',
  ),
  Country(
    name: 'Italy',
    code: 'it',
    dialCode: '+39',
    flagAsset: 'flags/png/it.png',
  ),
  Country(
    name: 'Spain',
    code: 'es',
    dialCode: '+34',
    flagAsset: 'flags/png/es.png',
  ),
  Country(
    name: 'Brazil',
    code: 'br',
    dialCode: '+55',
    flagAsset: 'flags/png/br.png',
  ),
  Country(
    name: 'Mexico',
    code: 'mx',
    dialCode: '+52',
    flagAsset: 'flags/png/mx.png',
  ),
  Country(
    name: 'China',
    code: 'cn',
    dialCode: '+86',
    flagAsset: 'flags/png/cn.png',
  ),
  Country(
    name: 'Japan',
    code: 'jp',
    dialCode: '+81',
    flagAsset: 'flags/png/jp.png',
  ),
  Country(
    name: 'South Korea',
    code: 'kr',
    dialCode: '+82',
    flagAsset: 'flags/png/kr.png',
  ),
  Country(
    name: 'Russia',
    code: 'ru',
    dialCode: '+7',
    flagAsset: 'flags/png/ru.png',
  ),
  Country(
    name: 'Turkey',
    code: 'tr',
    dialCode: '+90',
    flagAsset: 'flags/png/tr.png',
  ),
  Country(
    name: 'Saudi Arabia',
    code: 'sa',
    dialCode: '+966',
    flagAsset: 'flags/png/sa.png',
  ),
  Country(
    name: 'UAE',
    code: 'ae',
    dialCode: '+971',
    flagAsset: 'flags/png/ae.png',
  ),
  Country(
    name: 'Egypt',
    code: 'eg',
    dialCode: '+20',
    flagAsset: 'flags/png/eg.png',
  ),
  Country(
    name: 'South Africa',
    code: 'za',
    dialCode: '+27',
    flagAsset: 'flags/png/za.png',
  ),
  Country(
    name: 'Nigeria',
    code: 'ng',
    dialCode: '+234',
    flagAsset: 'flags/png/ng.png',
  ),
  Country(
    name: 'Kenya',
    code: 'ke',
    dialCode: '+254',
    flagAsset: 'flags/png/ke.png',
  ),
  Country(
    name: 'Argentina',
    code: 'ar',
    dialCode: '+54',
    flagAsset: 'flags/png/ar.png',
  ),
  Country(
    name: 'Chile',
    code: 'cl',
    dialCode: '+56',
    flagAsset: 'flags/png/cl.png',
  ),
  Country(
    name: 'Colombia',
    code: 'co',
    dialCode: '+57',
    flagAsset: 'flags/png/co.png',
  ),
  Country(
    name: 'Thailand',
    code: 'th',
    dialCode: '+66',
    flagAsset: 'flags/png/th.png',
  ),
  Country(
    name: 'Vietnam',
    code: 'vn',
    dialCode: '+84',
    flagAsset: 'flags/png/vn.png',
  ),
  Country(
    name: 'Malaysia',
    code: 'my',
    dialCode: '+60',
    flagAsset: 'flags/png/my.png',
  ),
  Country(
    name: 'Indonesia',
    code: 'id',
    dialCode: '+62',
    flagAsset: 'flags/png/id.png',
  ),
  Country(
    name: 'Philippines',
    code: 'ph',
    dialCode: '+63',
    flagAsset: 'flags/png/ph.png',
  ),
  Country(
    name: 'Singapore',
    code: 'sg',
    dialCode: '+65',
    flagAsset: 'flags/png/sg.png',
  ),
  Country(
    name: 'New Zealand',
    code: 'nz',
    dialCode: '+64',
    flagAsset: 'flags/png/nz.png',
  ),
  Country(
    name: 'Norway',
    code: 'no',
    dialCode: '+47',
    flagAsset: 'flags/png/no.png',
  ),
  Country(
    name: 'Sweden',
    code: 'se',
    dialCode: '+46',
    flagAsset: 'flags/png/se.png',
  ),
  Country(
    name: 'Finland',
    code: 'fi',
    dialCode: '+358',
    flagAsset: 'flags/png/fi.png',
  ),
  Country(
    name: 'Netherlands',
    code: 'nl',
    dialCode: '+31',
    flagAsset: 'flags/png/nl.png',
  ),
  Country(
    name: 'Switzerland',
    code: 'ch',
    dialCode: '+41',
    flagAsset: 'flags/png/ch.png',
  ),
  Country(
    name: 'Ireland',
    code: 'ie',
    dialCode: '+353',
    flagAsset: 'flags/png/ie.png',
  ),
  Country(
    name: 'Belgium',
    code: 'be',
    dialCode: '+32',
    flagAsset: 'flags/png/be.png',
  ),
];
