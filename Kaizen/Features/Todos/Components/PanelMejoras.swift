import SwiftUI

struct PanelMejoras: View {
    @ObservedObject var todoVM: TodoHomeViewModel

    var body: some View {
        VStack {
            HeaderText(text: "Mejoras de hoy")

            PanelInput(todoVM: todoVM)

            if todoVM.mejoras.isEmpty {
                Text("No hay mejoras por mostrar")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .bold()
                    .padding(.vertical)
                    .cardRoundedRectangleStyle(
                        bgColor: .gray.opacity(0.2),
                        cornerRadius: 10
                    )
            } else {
                ScrollView(showsIndicators: false){
                    VStack {
                        ForEach(todoVM.mejoras) { mejora in
                            Card(todoVM: todoVM, mejora: mejora)
                        }
                    }
                    .padding()
                }
                .frame(
                    maxWidth: .infinity,
                    maxHeight: .infinity,
                    alignment: .top
                )
                .cardRoundedRectangleStyle(
                    bgColor: .gray.opacity(0.2),
                    cornerRadius: 10
                )
            }

            Divider()
        }
    }
}

struct PanelInput: View {
    @ObservedObject var todoVM: TodoHomeViewModel
    var body: some View {
        HStack {
            VStack {
                TextField("Agrega una nueva mejora", text: $todoVM.descripcion)
                Divider()
            }

            Button(
                action: { todoVM.agregarMejora() },
                label: {
                    Image(systemName: "plus.square.fill")
                        .font(.system(size: 30))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            .white,
                            todoVM.descripcion.isEmpty
                                ? .gray.opacity(0.5) : .gray
                        )
                }
            )
            .disabled(todoVM.descripcion.isEmpty)
        }
    }
}

struct Card: View {
    @ObservedObject var todoVM: TodoHomeViewModel
    let mejora: MejoraModel
    @State var completado = false
    var body: some View {
        HStack {
            Button(
                action: { completado.toggle() },
                label: {
                    Image(
                        systemName: completado
                            ? "checkmark.square.fill" : "square"
                    )
                    .scaleEffect(completado ? 1.2 : 1)
                    .animation(.spring(response: 0.3,dampingFraction: 0.5),value: completado)
                    .foregroundColor(completado ? .green : .gray)
                }
            )

            Text(mejora.descripcion.capitalized)
                .frame(maxWidth: .infinity, alignment: .leading)
                .strikethrough(completado)
                .foregroundColor(.gray)

            Button(
                action: { todoVM.eliminarMejora(mejora: mejora) },
                label: {
                    Image(systemName: "minus")
                        .foregroundColor(.gray)
                }
            )
        }
        .frame(height: 35)
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.gray, lineWidth: 1)
        )

    }
}

#Preview {
    @StateObject var todoVM: TodoHomeViewModel = TodoHomeViewModel()
    PanelMejoras(todoVM: todoVM)
        .padding(.horizontal)
}

#Preview {
    @StateObject var todoVM: TodoHomeViewModel = TodoHomeViewModel()
    PanelMejoras(todoVM: todoVM)
        .padding(.horizontal)
}
