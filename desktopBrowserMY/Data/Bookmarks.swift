//
//  Bookmarks.swift
//  desktopBrowserMY
//
//  Created by Chan Thai Thong on 23/2/25.
//

import Foundation
import RealmSwift

class Bookmark: Object {
    @objc dynamic var url = ""
    @objc dynamic var title = ""
}
