//
//  TextDisplay.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI

struct TextDisplay: View {
    @State var fontSize: CGFloat = 20
    var body: some View {
        VStack{
            Slider(value: $fontSize, in: 15...30)
                .padding()
            let lines = readFile()
            ScrollView{
                ForEach(lines, id: \.self) { line in
                    Text(line)
                        .multilineTextAlignment(.trailing)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .font(.custom("dyslexia-hebrew-extended", size: CGFloat(fontSize)))
                        .lineLimit(nil)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(2)
                        
                    //Text("Translation")
                }
                .padding()
            }
        }
    }
}

func readFile() -> [String] {
    if let url = Bundle.main.url(forResource: "hebrew", withExtension: "txt"),
       let text = try? String(contentsOf: url, encoding: .utf8) {
        let lines = text.components(separatedBy: "\n")
        return lines
    }
    return []
}

#Preview {
    TextDisplay()
}
