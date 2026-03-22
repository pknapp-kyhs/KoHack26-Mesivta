//
//  Gemini.swift
//  KoHack26
//
//  Created by Mendel W on 3/22/26.
//

import Foundation

func translate(text: String){
    let api_key = "AIzaSyAz7YFR5KH76JOmOAzk00PJmgUmzewD2Z8"
    
    let api_url = URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(api_key)")!
    
    //Format that gemini uses for API prompts
    let body: [String: Any] = [
        "contents": [[
            "parts": [["text": text]]
        ]]
    ]
    
    //Send to the API
    var api_request = URLRequest(url: api_url)
    api_request.httpMethod = "POST"
    
    //Sets the content type value to JSON
    api_request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    
}
