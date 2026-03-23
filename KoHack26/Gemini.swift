//
//  Gemini.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.

// Made with the help of Claude

import Foundation



func promptGemini(prompt: String, image: Data? = nil) async -> String{
    
    //uses the api key from the secrets.plist - to get an api key go to: https://aistudio.google.com/api-keys?project=gen-lang-client-0982756025
    let path = Bundle.main.path(forResource: "Secrets", ofType: "plist")!
    let dict = NSDictionary(contentsOfFile: path)!
    let api_key = dict["API_Key"] as! String //Claude
    
    let api_url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=\(api_key)")!
    
    // Make the parts sections of the dict for the prompt - if there is an image it will be different than for just text
    var parts: [[String: Any]] = []
    
    if let image = image{
        parts.append([
            "inline_data": [
                //image type
                "mime_type": "image/jpeg",
                //makes the image bytes into text
                "data": image.base64EncodedString()
            ]
        ])
    }
    
    //There will always be a prompt
    parts.append(["text": prompt])
    
    //Format that gemini uses for API prompts
    let body: [String: Any] = [
        "contents":
            [
                ["parts": parts]
            ]
    ]
    
    
    //Send to the API
    var api_request = URLRequest(url: api_url)
    api_request.httpMethod = "POST"
    
    //Sets the content type value to JSON
    api_request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
    //Makes the swift dict into JSON
    api_request.httpBody = try? JSONSerialization.data(withJSONObject: body)
    
    //Make the request, and gets the raw byte response as the variable data
    guard let (data, _) = try? await URLSession.shared.data(for: api_request) else {
            return "Request failed"
        }

    //turns the data into json so we can use it, not just raw bytes
    //as? [String: ... makes sure that it is a dict
    guard let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
        //looks for the candidates key of the output - an array of arrays
          let candidates = json["candidates"] as? [[String: Any]],
        //gets the first item, if there is one
          let content = candidates.first?["content"] as? [String: Any],
        //gets the "parts" of the content
          let parts = content["parts"] as? [[String: Any]],
            //gets the "text" - the actual output of the AI
          let text = parts.first?["text"] as? String else {
        return String(data: data, encoding: .utf8) ?? "Couldn't Parse the Data"
    }
        
    return text
}

