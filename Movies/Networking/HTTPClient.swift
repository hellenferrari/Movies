//
// Copyright (c) Hellen Ferrari. All rights reserved.
//

import Foundation

protocol HTTPClient {
    func get(url: URL) async throws -> Result<Data, Error>
}
