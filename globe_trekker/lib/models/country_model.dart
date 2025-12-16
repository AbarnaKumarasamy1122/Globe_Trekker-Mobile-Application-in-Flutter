import 'package:hive/hive.dart';

part 'country_model.g.dart';

@HiveType(typeId: 0)
class Country {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String capital;
  @HiveField(2)
  final int population;
  @HiveField(3)
  final String flag;
  @HiveField(4)
  final String abbreviation;
  @HiveField(5)
  final String currency;
  @HiveField(6)
  final String phone;
  @HiveField(7)
  final String? emblem;
  @HiveField(8)
  final String? orthographic;
  @HiveField(9)
  final int id;
  @HiveField(10)
  final String region;

  Country({
    required this.name,
    required this.capital,
    required this.population,
    required this.flag,
    required this.abbreviation,
    required this.currency,
    required this.phone,
    this.emblem,
    this.orthographic,
    required this.id,
    required this.region,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final media = json['media'] as Map<String, dynamic>? ?? {};
    final abbreviation = json['abbreviation'] ?? '';
    final flagUrl = media['flag'] ?? '';
    final emblemUrl = media['emblem'];
    final orthoUrl = media['orthographic'];

    return Country(
      name: json['name'] ?? '',
      capital: json['capital'] ?? '',
      population: json['population'] ?? 0,
      flag: _fixImageUrl(flagUrl),
      abbreviation: abbreviation,
      currency: json['currency'] ?? '',
      phone: json['phone'] ?? '',
      emblem: emblemUrl != null ? _fixImageUrl(emblemUrl) : null,
      orthographic: orthoUrl != null ? _fixImageUrl(orthoUrl) : null,
      id: json['id'] ?? 0,
      region: _detectRegion(abbreviation, json['name'] ?? ''),
    );
  }

  static String _fixImageUrl(String url) {
    if (url.isEmpty) return url;

    // Check if URL is malformed (missing protocol or domain)
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      // If it starts with upload.wikimedia.org or similar, add https://
      if (url.startsWith('upload.wikimedia.org') ||
          url.startsWith('//upload.wikimedia.org')) {
        return 'https://upload.wikimedia.org${url.replaceFirst('//', '/')}';
      }
      // If it looks like just a path, return empty string to trigger placeholder
      return '';
    }

    // Check if domain is invalid (like "bissau.svg")
    final uri = Uri.tryParse(url);
    if (uri == null || uri.host.isEmpty || !uri.host.contains('.')) {
      return '';
    }

    // Check for obviously invalid domains (single word followed by file extension)
    if (uri.host.split('.').length == 2 &&
        ['svg', 'png', 'jpg', 'jpeg'].contains(uri.host.split('.').last)) {
      return '';
    }

    return url;
  }

  static String _detectRegion(String abbr, String name) {
    // Africa
    const africa = [
      'DZ',
      'AO',
      'BJ',
      'BW',
      'BF',
      'BI',
      'CM',
      'CV',
      'CF',
      'TD',
      'KM',
      'CG',
      'CD',
      'CI',
      'DJ',
      'EG',
      'GQ',
      'ER',
      'ET',
      'GA',
      'GM',
      'GH',
      'GN',
      'GW',
      'KE',
      'LS',
      'LR',
      'LY',
      'MG',
      'MW',
      'ML',
      'MR',
      'MU',
      'YT',
      'MA',
      'MZ',
      'NA',
      'NE',
      'NG',
      'RE',
      'RW',
      'ST',
      'SN',
      'SC',
      'SL',
      'SO',
      'ZA',
      'SS',
      'SD',
      'SZ',
      'TZ',
      'TG',
      'TN',
      'UG',
      'EH',
      'ZM',
      'ZW',
    ];
    // Americas
    const americas = [
      'AI',
      'AG',
      'AR',
      'AW',
      'BS',
      'BB',
      'BZ',
      'BM',
      'BO',
      'BQ',
      'BR',
      'CA',
      'KY',
      'CL',
      'CO',
      'CR',
      'CU',
      'CW',
      'DM',
      'DO',
      'EC',
      'SV',
      'FK',
      'GF',
      'GL',
      'GD',
      'GP',
      'GT',
      'GY',
      'HT',
      'HN',
      'JM',
      'MQ',
      'MX',
      'MS',
      'NI',
      'PA',
      'PY',
      'PE',
      'PR',
      'BL',
      'KN',
      'LC',
      'MF',
      'PM',
      'VC',
      'SX',
      'GS',
      'SR',
      'TT',
      'TC',
      'US',
      'UY',
      'VE',
      'VG',
      'VI',
    ];
    // Asia
    const asia = [
      'AF',
      'AM',
      'AZ',
      'BH',
      'BD',
      'BT',
      'BN',
      'KH',
      'CN',
      'CX',
      'CC',
      'IO',
      'GE',
      'HK',
      'IN',
      'ID',
      'IR',
      'IQ',
      'IL',
      'JP',
      'JO',
      'KZ',
      'KP',
      'KR',
      'KW',
      'KG',
      'LA',
      'LB',
      'MO',
      'MY',
      'MV',
      'MN',
      'MM',
      'NP',
      'OM',
      'PK',
      'PS',
      'PH',
      'QA',
      'SA',
      'SG',
      'LK',
      'SY',
      'TW',
      'TJ',
      'TH',
      'TL',
      'TR',
      'TM',
      'AE',
      'UZ',
      'VN',
      'YE',
    ];
    // Europe
    const europe = [
      'AX',
      'AL',
      'AD',
      'AT',
      'BY',
      'BE',
      'BA',
      'BG',
      'HR',
      'CY',
      'CZ',
      'DK',
      'EE',
      'FO',
      'FI',
      'FR',
      'DE',
      'GI',
      'GR',
      'GG',
      'HU',
      'IS',
      'IE',
      'IM',
      'IT',
      'JE',
      'XK',
      'LV',
      'LI',
      'LT',
      'LU',
      'MK',
      'MT',
      'MD',
      'MC',
      'ME',
      'NL',
      'NO',
      'PL',
      'PT',
      'RO',
      'RU',
      'SM',
      'RS',
      'SK',
      'SI',
      'ES',
      'SJ',
      'SE',
      'CH',
      'UA',
      'GB',
      'VA',
    ];
    // Oceania
    const oceania = [
      'AS',
      'AU',
      'CK',
      'FJ',
      'PF',
      'GU',
      'KI',
      'MH',
      'FM',
      'NR',
      'NC',
      'NZ',
      'NU',
      'NF',
      'MP',
      'PW',
      'PG',
      'PN',
      'WS',
      'SB',
      'TK',
      'TO',
      'TV',
      'UM',
      'VU',
      'WF',
    ];

    if (africa.contains(abbr)) return 'Africa';
    if (americas.contains(abbr)) return 'Americas';
    if (asia.contains(abbr)) return 'Asia';
    if (europe.contains(abbr)) return 'Europe';
    if (oceania.contains(abbr)) return 'Oceania';

    // Antarctica
    if (abbr == 'AQ' || abbr == 'BV' || abbr == 'HM' || abbr == 'TF')
      return 'Antarctica';

    return 'Other';
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'capital': capital,
      'population': population,
      'abbreviation': abbreviation,
      'currency': currency,
      'phone': phone,
      'id': id,
      'region': region,
      'media': {'flag': flag, 'emblem': emblem, 'orthographic': orthographic},
    };
  }
}
