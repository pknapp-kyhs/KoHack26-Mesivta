//
//  PageScan.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI
import PhotosUI

struct PageScan: View {
    @Binding var selection: [PhotosPickerItem]
    @State private var image: UIImage? = nil
    @State private var response = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack{
            if isLoading {
                ProgressView("Thinking...")
            }
            PhotosPicker("Choose Image", selection: $selection)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(10)
            //This was made by Claude
                //When the selection changes
                .onChange(of: selection) {
                    Task {
                        //
                        // If it works to load the image then convert it into a usable image
                        if let data = try? await selection.first?.loadTransferable(type: Data.self) {
                            self.image = UIImage(data: data)
                            isLoading = true
                            response = await promptGemini(prompt: "Read all the Hebrew text in this image exactly as it appears, return only the text with no additional commentary. It might also be rashi script so keep that in mind, so it doesn't generate random text. Do not generate nekudos.", image: data)
                            writeToFile(filename: "hebrew.txt", text: response)
                            isLoading = false
                        }
                    }
                }
            //Until here
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}

func writeToFile(filename: String, text: String){
    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(filename)
    
    //atomically writes to a temp file to prevent corruption
    try? text.write(to: url, atomically: true, encoding: .utf8)
    
}

//#Preview {
//    PageScan()
//}
