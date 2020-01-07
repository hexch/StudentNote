////  TitleInput.swift
//  StudentsNote
//
//  Created by hexch on 2020/01/07.
//  github:https://github.com/hexch
//
//  Copyright © 2020 Hexch. All rights reserved.
//

import SwiftUI

struct TitleInput: View {
    var title:String
    @Binding var value :String
    
    var body: some View {
        VStack {
            HStack {
                Text(self.title)
                    .font(.caption)
                Spacer()
            }
            TextField("", text: self.$value, onEditingChanged: {changed in
                
            }, onCommit: {})
                .background(UnderLine())
        }
        .padding(.leading)
        .padding(.trailing)
    }
}

struct TitleInput_Previews: PreviewProvider {
    static var previews: some View {
        TitleInput(title:"会社",value:.constant(""))
    }
}
