import SwiftUI

struct BackButtonView: View {
    var action:() -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Button(action: {action()}) {
            Image(systemName: "arrowshape.backward.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 13, height: 13)
                .foregroundColor(.black)
                .padding(9)
        }
        .background(.white)
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.5), radius: 2, x: 0, y: 2)
    }
}

#Preview {
    BackButtonView(){
        
    }
}
