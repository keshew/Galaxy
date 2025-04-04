import SwiftUI

extension Text {
    func Sans(size: CGFloat,
              color: Color = .white,
              colorOutline: Color = Color(red: 151/255, green: 26/255, blue: 192/255),
              width: CGFloat = 0.7) -> some View {
        self.font(.custom("JosefinSans-Thin_Regular", size: size))
            .foregroundColor(color)
            .outlineText(color: colorOutline, width: width)
    }
}
