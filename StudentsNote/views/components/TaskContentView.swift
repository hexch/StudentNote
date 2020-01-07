////  TaskContentView.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct TaskContentView: View {
    var genre :String = "予定"
    var event :String
    var company:String
    var edit:String
    var timerange :String
    var body: some View {
        GeometryReader{proxy in
            HStack{
                VStack {
                    VStack {
                        Text(self.genre)
                            .font(.caption)
                    }
                    .frame(width:50, height:proxy.size.height*2/3)
                    .background(ArcTagView())
                    Spacer()
                }
                
                
                ZStack(alignment:.leading){
                    Text(self.event)
                    
                    VStack{
                        Spacer()
                        Text(self.company)
                            .font(.footnote)
                    }
                    HStack{
                        Spacer()
                        VStack(alignment:.trailing){
                            Text("編集:"+self.edit)
                                .font(.caption)
                                .foregroundColor(.red)
                            Spacer()
                            Text(self.timerange)
                                .font(.footnote)
                                .foregroundColor(.red)
                        }.padding(.trailing,2)
                    }
                }
                Spacer()
                
            }.frame(height:proxy.size.height)
            .roundBorder()
            .shadow(radius: 5)
        }
    
        
    }
}

struct TaskContentView_Previews: PreviewProvider {
    static var previews: some View {
        TaskContentView(event: "説明会", company: "日立ソリューション", edit: "2019.10.02 10:31", timerange: "10:00~11:00")
        .frame(width: 400, height: 80)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
