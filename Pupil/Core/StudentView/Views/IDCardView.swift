//
//  IDCardView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 1/12/23.
//

import SwiftUI
import SwiftVue
import CoreImage.CIFilterBuiltins

struct IDCardView: View {
    let info: StudentInfo
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                if let data = Data(base64Encoded: info.base64Photo), let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .clipShape(Circle())
                        .frame(width: 60, height: 60)
                } else {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.blue)
                }
                VStack(alignment: .leading) {
                    Text(info.formattedName)
                        .font(.title.weight(.semibold))
                    Text("Grade \(info.grade)")
                }
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.leading)
            Rectangle()
                .frame(height: 8)
                .padding(.vertical, 5)
                .foregroundColor(.green)
            Image(uiImage: generateQRCode(from: info.permId))
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
                .frame(height: 80)
            Text(info.permId)
        }
        .padding(.vertical)
        .background(Color.init(.systemGray5))
        .cornerRadius(30)
        .padding()
        .frame(maxWidth: 450)
        
    }
    
    func generateQRCode(from string: String) -> UIImage {
        if string.isEmpty { return UIImage() }
        let filter = CIFilter.code128BarcodeGenerator()
        let context = CIContext()
        filter.message = Data(string.utf8)
        filter.quietSpace = 5
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage (outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage()
    }
}

struct IDCardView_Previews: PreviewProvider {
    static var previews: some View {
        IDCardView(info: dev.studentInfo)
    }
}
