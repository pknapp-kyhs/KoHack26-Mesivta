//
//  TextDisplay.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI

struct TextDisplay: View {
    @State var fontSize: CGFloat = 20
    @State var lines: [String] = []
    var body: some View {
        VStack{
            Button("Clear File"){
                writeToFile(filename: "hebrew.txt", text: "")
                lines = readFile()
            }
            Slider(value: $fontSize, in: 15...30)
                .padding()
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
        .onAppear(){
            lines = readFile()
        }
    }
}

func readFile() -> [String] {
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("hebrew.txt")
    if let text = try? String(contentsOf: url, encoding: .utf8){
        let lines = text.components(separatedBy: "\n")
        return lines
    }
    return []
}
#Preview {
    TextDisplay()
}
