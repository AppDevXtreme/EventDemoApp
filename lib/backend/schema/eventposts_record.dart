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
  String get userID;

  @nullable
  String get profileimage;

  @nullable
  BuiltList<DocumentReference> get likes;

  @nullable
  int get comments;

  @nullable
  DateTime get timePosted;

  @nullable
  @BuiltValueField(wireName: 'LocationName')
  String get locationName;

  @nullable
  String get hostedBy;

  @nullable
  String get province;

  @nullable
  String get category;

  @nullable
  DocumentReference get userAgent;

  @nullable
  String get email;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  bool get postOwner;

  @nullable
  DateTime get endDate;

  @nullable
  bool get isPrivate;

  @nullable
  BuiltList<DocumentReference> get eventfollows;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(EventpostsRecordBuilder builder) => builder
    ..eventname = ''
    ..description = ''
    ..coverimage = ''
    ..userID = ''
    ..profileimage = ''
    ..likes = ListBuilder()
    ..comments = 0
    ..locationName = ''
    ..hostedBy = ''
    ..province = ''
    ..category = ''
    ..email = ''
    ..displayName = ''
    ..photoUrl = ''
    ..uid = ''
    ..phoneNumber = ''
    ..postOwner = false
    ..isPrivate = false
    ..eventfollows = ListBuilder();

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('eventposts');

  static Stream<EventpostsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<EventpostsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

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
          ..userID = snapshot.data['userID']
          ..profileimage = snapshot.data['profileimage']
          ..likes = safeGet(
              () => ListBuilder(snapshot.data['likes'].map((s) => toRef(s))))
          ..comments = snapshot.data['comments']
          ..timePosted = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['timePosted']))
          ..locationName = snapshot.data['LocationName']
          ..hostedBy = snapshot.data['hostedBy']
          ..province = snapshot.data['province']
          ..category = snapshot.data['category']
          ..userAgent = safeGet(() => toRef(snapshot.data['userAgent']))
          ..email = snapshot.data['email']
          ..displayName = snapshot.data['display_name']
          ..photoUrl = snapshot.data['photo_url']
          ..uid = snapshot.data['uid']
          ..createdTime = safeGet(() => DateTime.fromMillisecondsSinceEpoch(
              snapshot.data['created_time']))
          ..phoneNumber = snapshot.data['phone_number']
          ..postOwner = snapshot.data['postOwner']
          ..endDate = safeGet(() =>
              DateTime.fromMillisecondsSinceEpoch(snapshot.data['endDate']))
          ..isPrivate = snapshot.data['isPrivate']
          ..eventfollows = safeGet(() =>
              ListBuilder(snapshot.data['eventfollows'].map((s) => toRef(s))))
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
  int comments,
  DateTime timePosted,
  String locationName,
  String hostedBy,
  String province,
  String category,
  DocumentReference userAgent,
  String email,
  String displayName,
  String photoUrl,
  String uid,
  DateTime createdTime,
  String phoneNumber,
  bool postOwner,
  DateTime endDate,
  bool isPrivate,
}) =>
    serializers.toFirestore(
        EventpostsRecord.serializer,
        EventpostsRecord((e) => e
          ..eventname = eventname
          ..date = date
          ..location = location
          ..description = description
          ..coverimage = coverimage
          ..userID = userID
          ..profileimage = profileimage
          ..likes = null
          ..comments = comments
          ..timePosted = timePosted
          ..locationName = locationName
          ..hostedBy = hostedBy
          ..province = province
          ..category = category
          ..userAgent = userAgent
          ..email = email
          ..displayName = displayName
          ..photoUrl = photoUrl
          ..uid = uid
          ..createdTime = createdTime
          ..phoneNumber = phoneNumber
          ..postOwner = postOwner
          ..endDate = endDate
          ..isPrivate = isPrivate
          ..eventfollows = null));
