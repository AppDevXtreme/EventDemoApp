import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'users_record.g.dart';

abstract class UsersRecord implements Built<UsersRecord, UsersRecordBuilder> {
  static Serializer<UsersRecord> get serializer => _$usersRecordSerializer;

  @nullable
  String get email;

  @nullable
  String get uid;

  @nullable
  @BuiltValueField(wireName: 'created_time')
  DateTime get createdTime;

  @nullable
  String get password;

  @nullable
  String get imageURL;

  @nullable
  String get yourSurname;

  @nullable
  String get userName;

  @nullable
  String get bio;

  @nullable
  String get userRole;

  @nullable
  String get status;

  @nullable
  @BuiltValueField(wireName: 'photo_url')
  String get photoUrl;

  @nullable
  @BuiltValueField(wireName: 'phone_number')
  String get phoneNumber;

  @nullable
  @BuiltValueField(wireName: 'display_name')
  String get displayName;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(UsersRecordBuilder builder) => builder
    ..email = ''
    ..uid = ''
    ..password = ''
    ..imageURL = ''
    ..yourSurname = ''
    ..userName = ''
    ..bio = ''
    ..userRole = ''
    ..status = ''
    ..photoUrl = ''
    ..phoneNumber = ''
    ..displayName = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('users');

  static Stream<UsersRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  UsersRecord._();
  factory UsersRecord([void Function(UsersRecordBuilder) updates]) =
      _$UsersRecord;

  static UsersRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createUsersRecordData({
  String email,
  String uid,
  DateTime createdTime,
  String password,
  String imageURL,
  String yourSurname,
  String userName,
  String bio,
  String userRole,
  String status,
  String photoUrl,
  String phoneNumber,
  String displayName,
}) =>
    serializers.toFirestore(
        UsersRecord.serializer,
        UsersRecord((u) => u
          ..email = email
          ..uid = uid
          ..createdTime = createdTime
          ..password = password
          ..imageURL = imageURL
          ..yourSurname = yourSurname
          ..userName = userName
          ..bio = bio
          ..userRole = userRole
          ..status = status
          ..photoUrl = photoUrl
          ..phoneNumber = phoneNumber
          ..displayName = displayName));
