import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'eventposts_record.g.dart';

abstract class EventpostsRecord
    implements Built<EventpostsRecord, EventpostsRecordBuilder> {
  static Serializer<EventpostsRecord> get serializer =>
      _$eventpostsRecordSerializer;

  @nullable
  String get eventname;

  @nullable
  DateTime get date;

  @nullable
  LatLng get location;

  @nullable
  String get description;

  @nullable
  String get coverimage;

  @nullable
  BuiltList<String> get category;

  @nullable
  BuiltList<String> get province;

  @nullable
  String get userID;

  @nullable
  String get profileimage;

  @nullable
  String get hostedby;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventpostsRecordBuilder builder) => builder
    ..eventname = ''
    ..description = ''
    ..coverimage = ''
    ..category = ListBuilder()
    ..province = ListBuilder()
    ..userID = ''
    ..profileimage = ''
    ..hostedby = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('eventposts');

  static Stream<EventpostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static EventpostsRecord fromAlgolia(AlgoliaObjectSnapshot snapshot) =>
      EventpostsRecord(
        (c) => c
          ..eventname = snapshot.data['eventname']
          ..date = safeGet(
              () => DateTime.fromMillisecondsSinceEpoch(snapshot.data['date']))
          ..location = safeGet(() => LatLng(
                snapshot.data['_geoloc']['lat'],
                snapshot.data['_geoloc']['lng'],
              ))
          ..description = snapshot.data['description']
          ..coverimage = snapshot.data['coverimage']
          ..category = safeGet(() => ListBuilder(snapshot.data['category']))
          ..province = safeGet(() => ListBuilder(snapshot.data['province']))
          ..userID = snapshot.data['userID']
          ..profileimage = snapshot.data['profileimage']
          ..hostedby = snapshot.data['hostedby']
          ..reference = EventpostsRecord.collection.doc(snapshot.objectID),
      );

  static Future<List<EventpostsRecord>> search(
          {String term,
          FutureOr<LatLng> location,
          int maxResults,
          double searchRadiusMeters}) =>
      FFAlgoliaManager.instance
          .algoliaQuery(
            index: 'eventposts',
            term: term,
            maxResults: maxResults,
            location: location,
            searchRadiusMeters: searchRadiusMeters,
          )
          .then((r) => r.map(fromAlgolia).toList());

  EventpostsRecord._();
  factory EventpostsRecord([void Function(EventpostsRecordBuilder) updates]) =
      _$EventpostsRecord;

  static EventpostsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createEventpostsRecordData({
  String eventname,
  DateTime date,
  LatLng location,
  String description,
  String coverimage,
  String userID,
  String profileimage,
  String hostedby,
}) =>
    serializers.toFirestore(
        EventpostsRecord.serializer,
        EventpostsRecord((e) => e
          ..eventname = eventname
          ..date = date
          ..location = location
          ..description = description
          ..coverimage = coverimage
          ..category = null
          ..province = null
          ..userID = userID
          ..profileimage = profileimage
          ..hostedby = hostedby));
