//
//  HomeView.swift
//  BookMaster
//
//  Created by Mac mini on 28.09.2024.
//

import SwiftUI

struct HomeView: View {
    
    // Свойства календаря
    @State private var currentDate: Date = .init()
    @State private var currentWeekIndex: Int = 1
    @State private var createWeek: Bool = true
    @State private var weekSlider = [[Date.WeekDay]]()
    
    // Свойства View
    @Namespace private var animation
    @State private var showApproweView: Bool = false
     
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
            //Header
            HeaderView()
            //Timeslots
            ScrollView{
                
                VStack(spacing: 19){
                    ForEach(Timeslot.mockData) { slot in
                        TimeslotCell(observed: .init(timeslot: slot))
                    }
                }
                
            }
        
        }
        .onAppear{
            let currentWeek = Date().fethWeek()
            if let firstDate = currentWeek.first?.date {
                weekSlider.append(firstDate.createPreviousWeek())
            }
            weekSlider.append(currentWeek)
            if let lastDate = currentWeek.last?.date {
                weekSlider.append(lastDate.createNextWeek())
            }
        }
    }
    @ViewBuilder func HeaderView() -> some View {
        VStack(alignment: .leading, spacing: 0){
            HStack(spacing: 5){
                Text(currentDate.format("MMMM"))
                    .foregroundStyle(.darkBlue )
                Text(currentDate.format("YYYY"))
                    .foregroundStyle(.darkGray)
            }.font(.title.bold())
            Text(currentDate.formatted(date: .complete, time: .omitted)).font(.callout).fontWeight(.semibold).textScale(.secondary).foregroundStyle(.lightGray )
            
            TabView(selection: $currentWeekIndex) {
                ForEach(weekSlider.indices, id: \.self) { index  in
                     WeekView(weekSlider[index]) 
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(height: 100)
            
            
        }.hSpacing(.leading )
            .padding()
            .background(.white)
            .overlay(alignment: .topTrailing) {
                Image("face")
                    .resizable()
                    .frame(width: 52, height: 52)
                    .scaledToFill()
                    .clipShape(.circle)
                    .offset(x: -19)
            }
    }
    
    
    @ViewBuilder func WeekView(_ week: [Date.WeekDay]) -> some View {
        HStack(spacing: 0){
            
            ForEach(week) { weekDay in
                VStack(spacing: 8){
                    Text(weekDay.date.format("E"))
                        .font(.callout)
                        .fontWeight(.medium)
                        .textScale(.secondary)
                        .foregroundStyle(.lightGray)
                    
                    Text(weekDay.date.format("dd"))
                        .font(.callout)
                        .fontWeight(.bold)
                        .foregroundStyle(isSameDay(weekDay.date, currentDate) ? .white : .darkGray)
                        .frame(width: 36, height:  36)
                        .background {
                            if isSameDay(weekDay.date, currentDate) {
                                Circle()
                                    .fill(.darkBlue)
                            }else {
                                
                            }
                           
                            if weekDay.date.isToday {
                                Circle().fill(.darkBlue).frame(width: 6, height: 6).vSpacing(.bottom).offset (y: 12)
                            }
                        }
                }
                .hSpacing(.center)
                .onTapGesture {
                    withAnimation {
                        currentDate = weekDay.date
                    }
                }
            }
        }
        .background{
            GeometryReader { proxy in
                let minX = proxy.frame(in: .global).minX
                
                Color
                    .clear
                    .preference(key: OffSetKey.self, value: minX)
                    .onPreferenceChange(OffSetKey.self) { value in
                        if value.rounded() == 15 && createWeek{
                            paginateWeek()
                        }
                    }
                
            }
        }
        
    }
    
    func paginateWeek() {
        
        if weekSlider.indices.contains(currentWeekIndex){
            if let firstDate = weekSlider[currentWeekIndex].first?.date, currentWeekIndex == 0{
                weekSlider.insert( firstDate.createPreviousWeek(), at: 0)
                weekSlider.removeLast()
                currentWeekIndex = 1
            }
        }
        
        if let lastDate = weekSlider[currentWeekIndex].last?.date, currentWeekIndex == weekSlider.count-1{
            weekSlider.append(lastDate.createNextWeek())
            currentWeekIndex = weekSlider.count - 2
        }
        
    }
    
}

#Preview {
    HomeView()
}
