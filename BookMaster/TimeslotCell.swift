//
//  TimeslotCell.swift
//  BookMaster
//
//  Created by Mac mini on 30.09.2024.
//

import SwiftUI

struct TimeslotCell: View {
    
    @State var observed: Observed
    
    var body: some View {
        VStack(alignment: .leading, spacing: 7){
            Text(observed.timeLabel)
                .font(.title3).bold().padding()
           Text(observed.isFreeDescription)
        }.frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 19)
            .padding(.vertical, 12)
            .background(.bgGreen)
            .clipShape(.rect(cornerRadius: 14))
            .offset(x: 42)
            
    }
}

extension TimeslotCell{
    @Observable
    class Observed{
        var timeslot: Timeslot
        var timeLabel: String{
            "\(timeslot.date.formatted(date: .omitted, time: .shortened)) - \(timeslot.endDate.formatted(date: .omitted, time: .shortened))"
        }
            
            var isFreeDescription: String{
                guard timeslot.clientID != nil else {
                    return "Свободно"
                }
                if timeslot.clientID == currentUserID{
                    return "Ваше время"
                }
                return "Занято"
            }
            
            var bgColor: Color{
                if timeslot.clientID == nil {
                    return .bgGreen
                }
                return timeslot.clientID == currentUserID ? .bgYellow : .bgRed
            }
            
        init(timeslot: Timeslot) {
            self.timeslot = timeslot
        }
    }
    
    #Preview {
        TimeslotCell(observed: .init(timeslot: .init(masterID: Timeslot.mockasterID, date: .now)))
    }
}
