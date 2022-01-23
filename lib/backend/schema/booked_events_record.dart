import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'booked_events_record.g.dart';

abstract class BookedEventsRecord
    implements Built<BookedEventsRecord, BookedEventsRecordBuilder> {
  static Serializer<BookedEventsRecord> get serializer =>
      _$bookedEventsRecordSerializer;

  @nullable
  String get eventName;

  @nullable
  String get eventDescription;

  @nullable
  DocumentReference get eventPerson;

  @nullable
  DateTime get eventDate;

  @nullable
  String get bookedUID;

  @nullable
  String get eventhosted;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(BookedEventsRecordBuilder builder) => builder
    ..eventName = ''
    ..eventDescription = ''
    ..bookedUID = ''
    ..eventhosted = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('bookedEvents');

  static Stream<BookedEventsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<BookedEventsRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then(
          (s) => serializers.deserializeWith(serializer, serializedData(s)));

  BookedEventsRecord._();
  factory BookedEventsRecord(
          [void Function(BookedEventsRecordBuilder) updates]) =
      _$BookedEventsRecord;

  static BookedEventsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createBookedEventsRecordData({
  String eventName,
  String eventDescription,
  DocumentReference eventPerson,
  DateTime eventDate,
  String bookedUID,
  String eventhosted,
}) =>
    serializers.toFirestore(
        BookedEventsRecord.serializer,
        BookedEventsRecord((b) => b
          ..eventName = eventName
          ..eventDescription = eventDescription
          ..eventPerson = eventPerson
          ..eventDate = eventDate
          ..bookedUID = bookedUID
          ..eventhosted = eventhosted));
