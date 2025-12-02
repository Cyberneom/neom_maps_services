import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';

import '../domain/models/location.dart';
import '../domain/models/place_autocomplete_response.dart';
import '../domain/models/place_details.dart';
import '../domain/models/places_search_response.dart';
import '../domain/models/prediction.dart';
import '../utils/component.dart';
import '../utils/enums/price_level.dart';
import '../utils/neom_maps_urls.dart';
import '../utils/neom_maps_utilities.dart';

/// https://developers.google.com/places/web-service/
class GoogleMapsPlaces extends GoogleWebService {
  GoogleMapsPlaces({
    super.apiKey,
    super.baseUrl,
    super.httpClient,
    super.apiHeaders,
  }) : super(
          apiPath: NeomMapsUrls.placesAutocompleteUrl,
        );

  Future<PlacesSearchResponse> searchNearbyWithRadius(
    Location location,
    num radius, {
    String? type,
    String? keyword,
    String? language,
    PriceLevel? minprice,
    PriceLevel? maxprice,
    String? name,
    String? pagetoken,
  }) async {
    final url = buildNearbySearchUrl(
      location: location,
      language: language,
      radius: radius,
      type: type,
      keyword: keyword,
      minprice: minprice,
      maxprice: maxprice,
      name: name,
      pagetoken: pagetoken,
    );
    return _decodeSearchResponse(await doGet(url, headers: apiHeaders));
  }

  Future<PlacesSearchResponse> searchNearbyWithRankBy(
    Location location,
    String rankby, {
    String? type,
    String? keyword,
    String? language,
    PriceLevel? minprice,
    PriceLevel? maxprice,
    String? name,
    String? pagetoken,
  }) async {
    final url = buildNearbySearchUrl(
      location: location,
      language: language,
      type: type,
      rankby: rankby,
      keyword: keyword,
      minprice: minprice,
      maxprice: maxprice,
      name: name,
      pagetoken: pagetoken,
    );
    return _decodeSearchResponse(await doGet(url, headers: apiHeaders));
  }

  Future<PlacesSearchResponse> searchByText(
    String query, {
    Location? location,
    num? radius,
    PriceLevel? minprice,
    PriceLevel? maxprice,
    bool opennow = false,
    String? type,
    String? pagetoken,
    String? language,
    String? region,
  }) async {

    final url = buildTextSearchUrl(
      query: query,
      location: location,
      language: language,
      region: region,
      type: type,
      radius: radius,
      minprice: minprice,
      maxprice: maxprice,
      pagetoken: pagetoken,
      opennow: opennow,
    );
    return _decodeSearchResponse(await doGet(url, headers: apiHeaders));
  }

  Future<PlaceDetails> getDetailsByPlaceId(String placeId, {
    String? sessionToken, List<String> fields = const [],
    String? language, String? region,}) async {

    Uri uri = buildDetailsUri(placeId, language: language,
    region: region, fields: fields, sessionToken: sessionToken,);

    final headers = {
      'Content-Type': 'application/json',
      if (apiKey != null) 'X-Goog-Api-Key': apiKey!,
      'X-Goog-FieldMask': fields.isNotEmpty
          ? fields.join(',')
          : 'id,displayName,formattedAddress,location',
      ...?apiHeaders,
    };

    final res = await doGet(uri.toString(), headers: headers);

    return _decodeDetailsResponse(res);
  }

  //@Deprecated('')
  // Future<PlacesDetailsResponse> getDetailsByReference(
  //   String reference, {
  //   String? sessionToken,
  //   List<String> fields = const [],
  //   String? language,
  // }) async {
  //   final uri = buildDetailsUri(
  //     ///DEPRECATED reference: reference,
  //     sessionToken: sessionToken,
  //     fields: fields,
  //     language: language,
  //   );
  //   return _decodeDetailsResponse(await doGet(uri.toString(), headers: apiHeaders));
  // }

  Future<PlacesAutocompleteResponse> autocomplete(
    String input, {
    String? sessionToken,
    num? offset,
    Location? origin,
    Location? location,
    num? radius,
    String? language,
    List<String> types = const [],
    List<Component> components = const [],
    bool strictBounds = false,
    String? region,
  }) async {

    // 2. body JSON
    final body = {
      'input': input,
      if (language != null) 'languageCode': language,
      if (region != null) 'regionCode': region,
      /// if (offset != null) 'offset': offset,
      if (sessionToken != null) 'sessionToken': sessionToken,
      if (location != null && radius != null)
        'locationBias': {
          'circle': {
            'center': {'latitude': location.latitude, 'longitude': location.longitude},
            'radius': radius.toDouble(),
          },
        },
      if (types.isNotEmpty) 'types': types,
    };

    // 3. headers
    final headers = {
      'Content-Type': 'application/json',
      if (apiKey != null) 'X-Goog-Api-Key': apiKey!,
      ...?apiHeaders,
    };

    // 4. POST
    final res = await doPost(url.toString(), jsonEncode(body), headers: headers);

    // 5. adapta respuesta nueva a tu DTO viejo
    return _decodeAutocompleteResponseNew(res);
  }

  Future<PlacesAutocompleteResponse> queryAutocomplete(
    String input, {
    num? offset,
    Location? location,
    num? radius,
    String? language,
  }) async {
    final url = buildQueryAutocompleteUrl(
      input: input,
      location: location,
      offset: offset,
      radius: radius,
      language: language,
    );
    return _decodeAutocompleteResponse(await doGet(url, headers: apiHeaders));
  }

  PlacesAutocompleteResponse _decodeAutocompleteResponseNew(Response res) {
    if (res.body.isEmpty) {
      return PlacesAutocompleteResponse(
        predictions: [],
        status: 'REQUEST_DENIED',
        errorMessage: 'Empty response (new Places API)',
      );
    }
    final jsonMap = jsonDecode(res.body) as Map<String, dynamic>;
    final suggestions = (jsonMap['suggestions'] as List<dynamic>?)
        ?.map((s) => Prediction.fromJson(s['placePrediction']))
        .toList() ??
        [];
    return PlacesAutocompleteResponse(
      status: suggestions.isEmpty ? 'ZERO_RESULTS' : 'OK',
      predictions: suggestions,
    );
  }

  String buildNearbySearchUrl({
    Location? location,
    num? radius,
    String? type,
    String? keyword,
    String? language,
    PriceLevel? minprice,
    PriceLevel? maxprice,
    String? name,
    String? rankby,
    String? pagetoken,
  }) {
    if (radius != null && rankby != null) {
      throw ArgumentError(
          "'rankby' must not be included if 'radius' is specified.");
    }

    if (rankby == 'distance' &&
        keyword == null &&
        type == null &&
        name == null) {
      throw ArgumentError(
          "If 'rankby=distance' is specified, then one or more of 'keyword', 'name', or 'type' is required.");
    }

    final params = <String, String>{};

    if (location != null) {
      params['location'] = location.toString();
    }

    if (keyword != null) {
      params['keyword'] = keyword;
    }

    if (name != null) {
      params['name'] = name;
    }

    if (rankby != null) {
      params['rankby'] = rankby;
    }

    if (minprice != null) {
      params['minprice'] = minprice.index.toString();
    }

    if (maxprice != null) {
      params['maxprice'] = maxprice.index.toString();
    }

    if (type != null) {
      params['type'] = type;
    }

    if (pagetoken != null) {
      params['pagetoken'] = pagetoken;
    }

    if (language != null) {
      params['language'] = language;
    }

    if (radius != null) {
      params['radius'] = radius.toString();
    }

    if (apiKey != null) {
      params['key'] = apiKey!;
    }
    return url
        .replace(
          path: '${url.path}$NeomMapsUrls.nearbySearchUrl',
          queryParameters: params,
        )
        .toString();
  }

  String buildTextSearchUrl({
    required String query,
    Location? location,
    num? radius,
    PriceLevel? minprice,
    PriceLevel? maxprice,
    bool opennow = false,
    String? type,
    String? pagetoken,
    String? language,
    String? region,
  }) {
    final params = <String, String>{
      'query': query,
    };

    if (minprice != null) {
      params['minprice'] = minprice.index.toString();
    }

    if (maxprice != null) {
      params['maxprice'] = maxprice.index.toString();
    }

    if (opennow) {
      params['opennow'] = opennow.toString();
    }

    if (type != null) {
      params['type'] = type;
    }

    if (pagetoken != null) {
      params['pagetoken'] = pagetoken;
    }

    if (language != null) {
      params['language'] = language;
    }

    if (region != null) {
      params['region'] = region;
    }

    if (location != null) {
      params['location'] = location.toString();
    }

    if (radius != null) {
      params['radius'] = radius.toString();
    }

    if (apiKey != null) {
      params['key'] = apiKey!;
    }

    return url
        .replace(
          path: '${url.path}${NeomMapsUrls.textSearchUrl}',
          queryParameters: params,
        )
        .toString();
  }

  Uri buildDetailsUri(String placeId, {
    String? sessionToken, List<String> fields = const [],
    String? language, String? region,}) {


    Uri baseUri = Uri.parse(NeomMapsUrls.kGMapsUrl);
    final queryParams = <String, String>{};
    if (language != null) queryParams['languageCode'] = language;
    if (region != null) queryParams['regionCode'] = region;
    if (sessionToken != null) queryParams['sessionToken'] = sessionToken;

    return baseUri.replace(
      path: '${baseUri.path}/places/$placeId',
      queryParameters: queryParams.isEmpty ? null : queryParams,
    );

  }

  ///DEPRECATED
  // String buildAutocompleteUrl({
  //   required String input,
  //   String? sessionToken,
  //   num? offset,
  //   Location? origin,
  //   Location? location,
  //   num? radius,
  //   String? language,
  //   List<String> types = const [],
  //   List<Component> components = const [],
  //   bool strictBounds = false,
  //   String? region,
  // }) {
  //   final params = <String, String>{
  //     'input': input,
  //   };
  //
  //   if (language != null) {
  //     params['language'] = language;
  //   }
  //
  //   if (origin != null) {
  //     params['origin'] = origin.toString();
  //   }
  //
  //   if (location != null) {
  //     params['location'] = location.toString();
  //   }
  //
  //   if (radius != null) {
  //     params['radius'] = radius.toString();
  //   }
  //
  //   if (types.isNotEmpty) {
  //     params['types'] = types.join('|');
  //   }
  //
  //   if (components.isNotEmpty) {
  //     params['components'] = components.join('|');
  //   }
  //
  //   if (strictBounds) {
  //     params['strictbounds'] = strictBounds.toString();
  //   }
  //
  //   if (offset != null) {
  //     params['offset'] = offset.toString();
  //   }
  //
  //   if (region != null) {
  //     params['region'] = region;
  //   }
  //
  //   if (apiKey != null) {
  //     params['key'] = apiKey!;
  //   }
  //
  //   if (sessionToken != null) {
  //     params['sessiontoken'] = sessionToken;
  //   }
  //
  //   return url
  //       .replace(
  //         path: '${url.path}${NeomMapsUrls.placesAutocompleteUrl}',
  //         queryParameters: params,
  //       )
  //       .toString();
  // }

  String buildQueryAutocompleteUrl({
    required String input,
    num? offset,
    Location? location,
    num? radius,
    String? language,
  }) {
    final params = <String, String>{
      'input': input,
    };

    if (language != null) {
      params['language'] = language;
    }

    if (location != null) {
      params['location'] = location.toString();
    }

    if (radius != null) {
      params['radius'] = radius.toString();
    }

    if (offset != null) {
      params['offset'] = offset.toString();
    }

    if (apiKey != null) {
      params['key'] = apiKey!;
    }

    return url
        .replace(
          path: '${url.path}${NeomMapsUrls.queryAutocompleteUrl}',
          queryParameters: params,
        )
        .toString();
  }

  String buildPhotoUrl({
    required String photoReference,
    int? maxWidth,
    int? maxHeight,
  }) {
    if (maxWidth == null && maxHeight == null) {
      throw ArgumentError("You must supply 'maxWidth' or 'maxHeight'");
    }

    final params = <String, String>{
      'photoreference': photoReference,
    };

    if (maxWidth != null) {
      params['maxwidth'] = maxWidth.toString();
    }

    if (maxHeight != null) {
      params['maxheight'] = maxHeight.toString();
    }

    if (apiKey != null) {
      params['key'] = apiKey!;
    }

    return url
        .replace(
          path: '${url.path}${NeomMapsUrls.photoUrl}',
          queryParameters: params,
        )
        .toString();
  }

  PlacesSearchResponse _decodeSearchResponse(Response res) =>
      PlacesSearchResponse.fromJson(json.decode(res.body));

  PlaceDetails _decodeDetailsResponse(Response res) =>
      PlaceDetails.fromJson(json.decode(res.body));

  PlacesAutocompleteResponse _decodeAutocompleteResponse(Response res) =>
      PlacesAutocompleteResponse.fromJson(json.decode(res.body));
}
