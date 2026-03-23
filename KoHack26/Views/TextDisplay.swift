//
//  TextDisplay.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI

struct TextDisplay: View {
    @State var fontSize: CGFloat = 20
    //Appropriate use of Lists/Arrays
    @State var lines: [String] = []
    let firebase = fBaseAPI()

    var body: some View {
        VStack{
            HStack{
                Text("Font Size: \(String(format: "%.0f", fontSize))")
                Slider(value: $fontSize, in: 15...30)
                    .padding()
            }
            ScrollView{
                //Correct use of Data Sort Algorithm on list/array
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
            Button("Clear File"){
                firebase.writeToFB(text: "", filename: "hebrew.txt", document: "files")
                lines = []
            }
            .padding()
            .foregroundColor(.white) 
            .background(Color.red)
            .cornerRadius(10)
            .shadow(radius: 2)
        }
        .onAppear() {
            firebase.readFromFB(filename: "hebrew.txt", document: "files") { result in
                lines = result
            }
        }
    }
}


#Preview {
    TextDisplay()
}
