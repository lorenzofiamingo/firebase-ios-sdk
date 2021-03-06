/*
 * Copyright 2020 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import FirebaseFirestore

@available(swift 5.0)
extension WriteBatch {
  /// Commits all of the writes in this write batch as a single atomic unit.
  ///
  /// - Parameter completion: A block to be called once all of the writes in the batch have been
  ///  successfully written to the backend as an atomic unit. This block will only execute when the
  ///  client is online and the commit has completed against the server.
  ///  The changes will be visible immediately.
  func commit(completion: @escaping (Result<Void, Error>) -> Void) {
    commit(completion: mapResultCompletion(completion))
  }
}

/// Returns a closure mapped from the a given closure with a `Result` parameter.
///
/// - Parameters:
///   - completion: The closure to map.
///   - result: The parameter of the closure to map.
/// - Returns: A closure mapped from the given closure.
private func mapResultCompletion(_ completion: @escaping (_ result: Result<Void, Error>) -> Void)
  -> ((Error?) -> Void) {
  return { error in
    if let error = error {
      completion(.failure(error))
    } else {
      completion(.success(()))
    }
  }
}
