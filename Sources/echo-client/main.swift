/* Client echo UDP.... */

import Socket
import Glibc
import Foundation

// let server = "localhost"
// let port: Int32 = 7667

// struct Point {
//     var x: Double
//     var y: Double
// }

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
    var buffer = Data(capacity: 1000)

        ///PARTE NUEVA
    //accede a memoria y el contenido lo vuelca en buffer
    // "hello".utf8CString.withUnsafeBytes { buffer.append(contentsOf: $0) }
    // withUnsafeBytes(of: Point(x: 0.7, y: -1.25)) { buffer.append(contentsOf: $0) }
    // withUnsafeBytes(of: 42) { buffer.append(contentsOf: $0) }
    // envia el contenido del buffer al server
    // try clientSocket.write(from: buffer, to: serverAddress)

    repeat {
        let message = readLine()!
        if message == ".quit" {
            quit = true

        }else{
            // escribe en el socket, el mensaje y el destino
            try clientSocket.write(from: message, to: serverAddress)
            (_, _) = try clientSocket.readDatagram(into: &buffer) //coge los datos recibidos
            let message = String(decoding: buffer, as: UTF8.self)
            print(message)
            buffer.removeAll()
        
        }
        
    }while !quit

} catch let error {
    print("Connection error \(error)")
    
}
