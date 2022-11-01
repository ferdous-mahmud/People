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



// Advance Encoding decoding.....
struct AdvanceUser: Codable {
    let Id: Int
    let userName: String
    let nickName: String
    let occupation: Occupation?
    let dateOfBirth: Date
    
    // CodingKey for changing variable name different form json
    enum CodingKeys: String, CodingKey {
        case Id = "userId"
        case userName
        case nickName = "nick_name"
        case occupation
        case dateOfBirth
    }
}

struct Occupation: Codable {
    let name: String
    let isActive: Bool
}


if let advancePath = Bundle.main.path(forResource: "AdvanceData", ofType: "json"),
   let advanceData = FileManager.default.contents(atPath: advancePath) {
    
    // Decoding
    let advanceDecoder = JSONDecoder()
    
    advanceDecoder.dateDecodingStrategy = .iso8601 // convert string to date format
    
    let advanceUser = try advanceDecoder.decode([AdvanceUser].self, from: advanceData)
    dump(advanceUser)
    
    // Loop through all users
    for user in advanceUser {
        print("UserId:", user.Id)
        print("UserName:", user.userName)
        print("NickName:", user.nickName)
        print("Occupation Name:", user.occupation?.name ?? "Unemployed")
        print("Occupation Status:", user.occupation?.isActive ?? "Nothing")
        print("Date of Birth:", user.dateOfBirth)
    }
        
    // Encoding
    let advanceEncoder = JSONEncoder()
    
    advanceEncoder.dateEncodingStrategy = .iso8601 // string to date conversion
    
    // Automaticly convert camelCase to snakeCase
    advanceEncoder.keyEncodingStrategy = .convertToSnakeCase
    
    let advanceEncodedUser = try advanceEncoder.encode(advanceUser)
    dump(String(data: advanceEncodedUser, encoding: .utf8))
    
}

