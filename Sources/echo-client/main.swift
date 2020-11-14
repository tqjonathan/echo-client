/* Client echo UDP.... */

import Socket
import Glibc
import Foundation

// let server = "localhost"
// let port: Int32 = 7667
// let message = "Hello, world! Again!"

do {

    let clientInfo = CommandLine.arguments
    let server = clientInfo[1]
    let port = Int32(clientInfo[2])!

    guard let serverAddress = Socket.createAddress(for: server, on: port) else {
        print("Error creating Address")
        exit(1)
        
    }
    let clientSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
    var quit = false
    repeat {
        let message = readLine()!
        if message == ".quit" {
            quit = true

        }else{
            try clientSocket.write(from: message, to: serverAddress)
        }
        
    }while !quit

} catch let error {
    print("Connection error \(error)")
    
}
