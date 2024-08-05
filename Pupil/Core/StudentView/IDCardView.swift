//
//  IDCardView.swift
//  Pupil
//
//  Created by Evan Kaneshige on 1/12/23.
//

import SwiftUI
import SwiftVue
import CoreImage.CIFilterBuiltins
import Defaults
import PhotosUI

struct IDCardView: View {
    @Default(.accentColor) private var accentColor
    @Default(.customIDPhoto) private var customIDPhoto
    @State private var usingBarCode: Bool = true
    @State private var showingCustomPhoto: Bool = true
    @State private var photoItem: PhotosPickerItem?
    let info: StudentInfo
    
    var body: some View {
        VStack {
            HStack(spacing: 10) {
                if let customIDPhoto, let uiImage = UIImage(data: customIDPhoto), showingCustomPhoto {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .frame(width: 60, height: 60)
                } else if let data = Data(base64Encoded: info.base64Photo), let uiImage = UIImage(data: data) {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .frame(width: 60, height: 60)
                } else {
                    PhotosPicker(selection: $photoItem, matching: .images) {
                        Image(systemName: "person.circle.fill")
                            .font(.custom("", size: 50))
                            .foregroundColor(.blue)
                    }
                }
                VStack(alignment: .leading) {
                    Text(info.formattedName)
                        .font(.title)
                        .fontWeight(.semibold)
                    Text(
                        String(
                            localized: "ID_CARD_USER_GRADE",
                            defaultValue: "Grade \(info.grade)",
                            comment: "The current grade of the user"
                        )
                    )
                }
                Spacer()
            }
            .padding(.vertical, 5)
            .padding(.leading)
            
            Rectangle()
                .frame(height: 8)
                .foregroundColor(accentColor)
            
            Picker(String(
                localized: "ID_CARD_TYPE_PICKER_TITLE",
                defaultValue: "ID type",
                comment: "Picker title for the ID card type (barcode or qr code)"
            ), selection: $usingBarCode.animation(.spring)) {
                Text(
                    String(
                        localized: "ID_CARD_BAR_CODE_TYPE",
                        defaultValue: "Bar code",
                        comment: "The bar code type of id card display"
                    )
                )
                .tag(true)
                Text(
                    String(
                        localized: "ID_CARD_QR_CODE_TYPE",
                        defaultValue: "QR code",
                        comment: "The qr code type of id card display"
                    )
                )
                .tag(false)
            }
            .pickerStyle(.segmented)
            .padding(.horizontal)
            .padding(.vertical, 5)
            
            Group {
                if usingBarCode {
                    Image(uiImage: barCode(from: info.permId))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(height: 80)
                        .transition(.scale)
                } else {
                    Image(uiImage: qrCode(from: info.permId))
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .padding(.horizontal, 50)
                        .transition(.scale)
                }
            }
            
            Text(info.permId)
                .font(.headline)
        }
        .padding(.vertical)
        .background(Color.init(.systemGray5))
        .cornerRadius(30)
        .padding(.horizontal)
        .frame(maxWidth: 450)
        .safeAreaInset(edge: .bottom) {
            if let customIDPhoto, let _ = UIImage(data: customIDPhoto) {
                let showOriginalPhotoText = String(
                    localized: "ID_CARD_SHOW_ORIGINAL_PHOTO_BUTTON",
                    defaultValue: "Show original photo",
                    comment: "Button to show the original id card photo"
                )
                let showCustomPhotoText = String(
                    localized: "ID_CARD_SHOW_CUSTOM_PHOTO_BUTTON",
                    defaultValue: "Show custom photo",
                    comment: "Button to show the custom id card photo"
                )
                Button(showingCustomPhoto ? showOriginalPhotoText : showCustomPhotoText) {
                    showingCustomPhoto.toggle()
                }
            }
        }
        .onChange(of: photoItem) { value in
            Task {
                if let data = try? await value?.loadTransferable(type: Data.self) {
                    if let _ = UIImage(data: data) {
                        customIDPhoto = data
                        return
                    }
                }
            }
        }
    }
    
    func qrCode(from string: String) -> UIImage {
        if string.isEmpty { return UIImage() }
        let filter = CIFilter.qrCodeGenerator()
        let context = CIContext()
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage (outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        
        return UIImage()
    }
    
    func barCode(from string: String) -> UIImage {
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

#Preview("IDCardView") {
    IDCardView(info: StudentInfo.preview)
}
