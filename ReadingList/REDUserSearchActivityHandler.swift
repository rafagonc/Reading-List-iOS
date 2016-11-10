//
//  REDUserSearchActivityHandler.swift
//  ReadingList
//
//  Created by Rafael Gonzalves on 9/5/16.
//  Copyright © 2016 Rafael Gonzalves. All rights reserved.
//

import Foundation

class REDUserSearchActivity : NSUserActivity {
    
    //MARK:  constructor
    public init(bookProtocol : REDBookProtocol) {
        super.init(activityType : "com.rafagonc.ReadingList")
        self.title = bookProtocol.name
        self.userInfo = ["id" : bookProtocol.identifier!]
        if #available(iOS 9.0, *) {
            self.keywords = [bookProtocol.name!, (bookProtocol.author!()?.name)!]
        }
    }
    
    
}