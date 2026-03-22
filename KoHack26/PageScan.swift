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
    
    var body: some View {
        VStack{
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

//#Preview {
//    PageScan()
//}
