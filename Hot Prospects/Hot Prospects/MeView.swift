import SwiftUI
import CoreImage.CIFilterBuiltins

struct MeView: View {
    @AppStorage("name") private var name = "Anonymous"
    @AppStorage("emailAddress") private var emailAddress = "you@yoursite.com"
    
    let context = CIContext() // Core Image context
    let filter = CIFilter.qrCodeGenerator() // QR code generator
    
    // Generates a sharp QR code image by upscaling
    func generate(from string: String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            // Define a larger size for the QR code to ensure it's sharp
            let transform = CGAffineTransform(scaleX: 10, y: 10) // Upscale by 10x
            
            let scaledImage = outputImage.transformed(by: transform)
            
            if let cgImage = context.createCGImage(scaledImage, from: scaledImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                
                TextField("Email Address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                
                // Display the generated sharp QR code
                Image(uiImage: generate(from: "\(name)\n\(emailAddress)"))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
            .navigationTitle("Your QR Code")
        }
    }
}

#Preview {
    MeView()
}

