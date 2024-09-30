//
//  Booking.swift
//  BookMaster
//
//  Created by Mac mini on 30.09.2024.
//

import Foundation


class Timeslot: Identifiable{
    var id: UUID = .init()
    var clientID: UUID?
    var masterID: UUID
    var date: Date
    var endDate: Date
    init(masterID: UUID, date: Date) {
        self.masterID = masterID
        self.date = date
        self.endDate = self.date.addingTimeInterval(7200)
    }
    
}
extension Timeslot{
    
    static let mockasterID = UUID()
    static var mockData: [Timeslot] = [
        Timeslot(masterID: mockasterID, date: .init(timeIntervalSince1970: 1)),
        Timeslot(masterID: mockasterID, date: .init(timeIntervalSince1970: 2)),
        Timeslot(masterID: mockasterID, date: .init(timeIntervalSince1970: 3)),
        Timeslot(masterID: mockasterID, date: .init(timeIntervalSince1970: 3))
    ]
}
