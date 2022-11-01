import UIKit


// Setp: 1 - Make codable struct for mapping json
struct User: Codable {
    let userName: String
    let occupation: String
}


// Step: 2 - Find path for Data.json file
if let path = Bundle.main.path(forResource: "Data", ofType: "json"),
    
    // Step: 3 - Get the content of data file we can use it
    let data = FileManager.default.contents(atPath: path) {
    
        // Step: 4 - Define decoder
        let decoder = JSONDecoder()
    
        // Step: 5 - Map json using decoder
        let users = try decoder.decode([User].self, from: data)
        
        // Decoding successful!
        dump(users)
    
        // Encoding ---------
        let encoder = JSONEncoder()
        let encodedUser = try encoder.encode(users)
        
        // Encoding successful! (json)
        dump(String(data: encodedUser, encoding: .utf8))
}
