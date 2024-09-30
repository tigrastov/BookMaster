//
//  ViewExtantion.swift
//  BookMaster
//
//  Created by Mac mini on 22.09.2024.
//
import SwiftUI
import Foundation
extension View{
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View{
         self.frame(maxWidth: .infinity, alignment: alignment)
    }
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View{
        self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
    func isSameDay(_ date1: Date, _ date2: Date )->Bool{
        Calendar.current.isDate(date1, inSameDayAs: date2)
    }
    
}
 
