/* Client echo UDP.... */

import Socket
import Glibc
import Foundation



do {

    let clientInfo = CommandLine.arguments
    let server = clientInfo[1]
    let port = Int32(clientInfo[2])!

    guard let serverAddress = Socket.createAddress(for: server, on: port) else {
        print("Error creating Address")
        exit(1)
        
    }
    // Crea el socket de cliente, no cambiar parametros
    let clientSocket = try Socket.create(family: .inet, type: .datagram, proto: .udp)
    var quit = false
    var buffer = Data(capacity: 1000) //
    repeat {
        let message = readLine()!
        if message == ".quit" {
            quit = true

        }else{
            // escribe en el socket, el mensaje y el destino
            try clientSocket.write(from: message, to: serverAddress)
            let (_, _) = try clientSocket.readDatagram(into: &buffer) //coge los datos recibidos
            let message = String(decoding: buffer, as: UTF8.self)
            print(message)
            buffer.removeAll()
        
        }
        
    }while !quit

} catch let error {
    print("Connection error \(error)")
    
}
