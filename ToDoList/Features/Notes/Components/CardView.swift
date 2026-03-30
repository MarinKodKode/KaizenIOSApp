import SwiftUI

struct CardView: View {
    @EnvironmentObject var todoVm:TodoViewModel
    @State var count = 0
    var todo: Todo
    var action:() -> Void
    var body: some View {
        VStack {
            VStack {
                Text(todo.note)
                    .frame(
                        maxWidth: .infinity,
                        maxHeight: .infinity,
                        alignment: .topLeading
                    )
            }
            .padding()
            .frame(height: 240)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(
                color: .black.opacity(0.2),
                radius: 4,
                x: 0,
                y: 2
            )
            VStack {
                Text(todo.title.isEmpty ? "Nota de Texto" : todo.title)
                    .font(.subheadline)
                    .bold()
                Text("26 Ene")
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }.onTapGesture {
            action()
        }
    }
}

#Preview {
    CardView(todo: Todo(title: "", note: "", date: Date()), action: {})
}
