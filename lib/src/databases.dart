// Copyright (c) 2022, Paurini Taketakehikuroa Wiringi. All rights reserved.
// See LICENSE file for licensing details.

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';

extension DatabasesExtension on Databases {
  /// Performs an "upsert" operation which is to say that if a document doesn't
  /// already exist, it will be created with the data provided.
  /// Otherwise if it does exist, it gets updated with the data provided.
  /// Returns a `Document` of the upserted docuemnt.
  ///
  /// Rethrows on exceptions other than a 404 (Document doesn't exist).
  ///
  /// ## Example
  /// ```dart
  /// database.upsert(
  ///   collectionId: 'users',
  ///   documentId: 'userId',
  ///   data: {'firstName': 'Paka'});
  /// ```
  ///
  /// **Note**: This operation is far from optimal and more or less only saves
  /// on syntax verbosity. This is until of course appwrite supports upsert out
  /// of the box.
  Future<Document> upsert(
      {required String collectionId,
      required String documentId,
      required Map<String, dynamic> data}) async {
    try {
      return await updateDocument(
          collectionId: collectionId, documentId: documentId, data: data);
    } on AppwriteException catch (e) {
      if (e.code == 404) {
        return await updateDocument(
            collectionId: collectionId, documentId: documentId, data: data);
      } else {
        rethrow;
      }
    }
  }

  // TODO - Implement `getDocumentFile`.
  /// Gets a document as a file.
  getDocumentFile() {}
}
