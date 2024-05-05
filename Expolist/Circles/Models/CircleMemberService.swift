//
//  CircleMemberService.swift
//  Expolist
//
//  Created by Donald Largen on 5/5/24.
//

import Foundation

class CircleMemberService: ExpolistService {
    
    private let fileName = "CircleMemebers"
    
    func get() -> [CircleMember] {
        guard let lists: [CircleMember] = self.loadSavedContent(fromFileNamed: fileName) else {
            return [CircleMember]()
        }
        return lists
    }
    
    func add(member: CircleMember) {
        var lists = get()
        lists.append(member)
        self.saveContent(content: lists,
                         toFileNamed: fileName)
    }
    
    func update(member: CircleMember) {
        var lists = get()
        lists.removeAll { circleMember in
            circleMember.id == member.id
        }
        lists.append(member)
        self.saveContent(content: lists,
                         toFileNamed: fileName)
    }
    
    func removeAll() {
        self.removeContent(fileName: fileName)
    }
}
