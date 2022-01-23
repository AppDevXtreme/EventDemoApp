import 'package:built_value/serializer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../flutter_flow/flutter_flow_util.dart';

import 'schema/users_record.dart';
import 'schema/chats_record.dart';
import 'schema/chat_messages_record.dart';
import 'schema/eventposts_record.dart';
import 'schema/post_comments_record.dart';
import 'schema/friends_record.dart';
import 'schema/booked_events_record.dart';
import 'schema/serializers.dart';

export 'package:cloud_firestore/cloud_firestore.dart';
export 'schema/index.dart';
export 'schema/serializers.dart';

export 'schema/users_record.dart';
export 'schema/chats_record.dart';
export 'schema/chat_messages_record.dart';
export 'schema/eventposts_record.dart';
export 'schema/post_comments_record.dart';
export 'schema/friends_record.dart';
export 'schema/booked_events_record.dart';

/// Functions to query UsersRecords (as a Stream and as a Future).
Stream<List<UsersRecord>> queryUsersRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<UsersRecord>> queryUsersRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(UsersRecord.collection, UsersRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query ChatsRecords (as a Stream and as a Future).
Stream<List<ChatsRecord>> queryChatsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(ChatsRecord.collection, ChatsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<ChatsRecord>> queryChatsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(ChatsRecord.collection, ChatsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query ChatMessagesRecords (as a Stream and as a Future).
Stream<List<ChatMessagesRecord>> queryChatMessagesRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        ChatMessagesRecord.collection, ChatMessagesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<ChatMessagesRecord>> queryChatMessagesRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        ChatMessagesRecord.collection, ChatMessagesRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query EventpostsRecords (as a Stream and as a Future).
Stream<List<EventpostsRecord>> queryEventpostsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(EventpostsRecord.collection, EventpostsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<EventpostsRecord>> queryEventpostsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        EventpostsRecord.collection, EventpostsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query PostCommentsRecords (as a Stream and as a Future).
Stream<List<PostCommentsRecord>> queryPostCommentsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        PostCommentsRecord.collection, PostCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<PostCommentsRecord>> queryPostCommentsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        PostCommentsRecord.collection, PostCommentsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query FriendsRecords (as a Stream and as a Future).
Stream<List<FriendsRecord>> queryFriendsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(FriendsRecord.collection, FriendsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<FriendsRecord>> queryFriendsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(FriendsRecord.collection, FriendsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

/// Functions to query BookedEventsRecords (as a Stream and as a Future).
Stream<List<BookedEventsRecord>> queryBookedEventsRecord(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollection(
        BookedEventsRecord.collection, BookedEventsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Future<List<BookedEventsRecord>> queryBookedEventsRecordOnce(
        {Query Function(Query) queryBuilder,
        int limit = -1,
        bool singleRecord = false}) =>
    queryCollectionOnce(
        BookedEventsRecord.collection, BookedEventsRecord.serializer,
        queryBuilder: queryBuilder, limit: limit, singleRecord: singleRecord);

Stream<List<T>> queryCollection<T>(
    CollectionReference collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
    int limit = -1,
    bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.snapshots().map((s) => s.docs
      .map(
        (d) => safeGet(
          () => serializers.deserializeWith(serializer, serializedData(d)),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .toList());
}

Future<List<T>> queryCollectionOnce<T>(
    CollectionReference collection, Serializer<T> serializer,
    {Query Function(Query) queryBuilder,
    int limit = -1,
    bool singleRecord = false}) {
  final builder = queryBuilder ?? (q) => q;
  var query = builder(collection);
  if (limit > 0 || singleRecord) {
    query = query.limit(singleRecord ? 1 : limit);
  }
  return query.get().then((s) => s.docs
      .map(
        (d) => safeGet(
          () => serializers.deserializeWith(serializer, serializedData(d)),
          (e) => print('Error serializing doc ${d.reference.path}:\n$e'),
        ),
      )
      .where((d) => d != null)
      .toList());
}

// Creates a Firestore record representing the logged in user if it doesn't yet exist
Future maybeCreateUser(User user) async {
  final userRecord = UsersRecord.collection.doc(user.uid);
  final userExists = await userRecord.get().then((u) => u.exists);
  if (userExists) {
    return;
  }

  final userData = createUsersRecordData(
    email: user.email,
    displayName: user.displayName,
    photoUrl: user.photoURL,
    uid: user.uid,
    phoneNumber: user.phoneNumber,
    createdTime: getCurrentTimestamp,
  );

  await userRecord.set(userData);
}
