//
//  CircleMemberViewModel.swift
//  Expolist
//
//  Created by Donald Largen on 5/5/24.
//

import Foundation
import Combine

class CircleMemberViewModel {
    
    private var memberService = CircleMemberService()
    private var members = [CircleMember]()
    var membersSubject = PassthroughSubject<(), Never>()
    
    var numberOfItems: Int {
        return members.count
    }
    
    func load() {
        members = memberService.get()
        membersSubject.send(())
    }
    
    func item(at index: Int) -> CircleMember {
        return members[index]
    }
    
    func addMember(member: CircleMember){
        memberService.add(member: member)
        load()
    }
}
