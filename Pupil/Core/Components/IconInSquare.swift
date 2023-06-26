//
//  IconInSquare.swift
//  Pupil
//
//  Created by Evan Kaneshige on 3/12/23.
//

import SwiftUI

struct IconInSquare: View {
    let color: Color
    let image: String
    var body: some View {
        Image(systemName: image)
            .foregroundColor(.white)
            .frame(minWidth: 30, minHeight: 30)
            .background(color, in: RoundedRectangle(cornerRadius: 8))
    }
}

struct IconInSquare_Previews: PreviewProvider {
    static var previews: some View {
        IconInSquare(color: .red, image: "paintbrush.fill")
    }
}
