//
//  PageScan.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import SwiftUI
import PhotosUI

struct PageScan: View {
    let firebase = fBaseAPI()
    
    @AppStorage("loggedIn") var loggedIn = false
    
    @Binding var selection: [PhotosPickerItem]
    @State private var image: UIImage? = nil
    @State private var imageData: Data? = nil
    @State private var response = ""
    @State private var isLoading = false
    
    var body: some View {
        VStack{
            HStack{
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
                            //Data type conversion
                            if let data = try? await selection.first?.loadTransferable(type: Data.self) {
                                self.imageData = data
                                self.image = UIImage(data: data)
                                
                            }
                        }
                    }
                Button("Send to AI"){
                    Task{
                        isLoading = true
                        response = await promptGemini(prompt: "Read all the Hebrew text in this image exactly as it appears, return only the text with no additional commentary. It might also be rashi script so keep that in mind, so it doesn't generate random text. Do not generate nekudos.", image: imageData!)
                        firebase.writeToFB(text: response, filename: "hebrew.txt", document: "files")
                        isLoading = false
                    }
                }
                .disabled(imageData == nil)
                .padding()
                .foregroundColor(.black)
                .background(imageData == nil ? Color.gray : Color.yellow)
                .cornerRadius(10)
            }
            //basic conditionals
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            }
            Button("Logout"){
                loggedIn = false
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
