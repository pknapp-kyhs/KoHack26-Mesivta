# KoHack26-Mesivta

Function 1 - Uploads an image to the Gemini API and gets the hebrew text from the image
 - `PageScan.swift` The UI and function call for the prompt and where the user uploads the image from. Writes the response from AI to "hebrew.txt"
 - `Gemini.swift` Where the function for prompting and getting the AI response is
 
Function 2 - Displays the text from the scanned document
 - `TextDisplay.swift` reads from "hebrew.txt" and displays in a dyslexic friendly font
