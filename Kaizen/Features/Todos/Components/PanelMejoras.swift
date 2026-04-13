import SwiftUI

struct PanelMejoras: View {
    @ObservedObject var todoVM: TodoHomeViewModel
    @State var crearMejora = false
    var body: some View {
        VStack {
            HStack {
                VStack(alignment:.leading) {
                    HeaderText(text: "Mejoras de hoy")
                    Text(Utils.formatDateEEEEdMMMM(from: Date()).capitalized)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                }

                Spacer()
                
                Button(
                    action: { crearMejora.toggle() },
                    label: {
                        Text("+ Nueva mejora")
                            .font(.system(size: 14))
                            .bold()
                    }
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }

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
                ScrollView(showsIndicators: false) {
                    VStack(spacing:20){
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
            }
        }
        .sheet(isPresented: $crearMejora){
            AgregarMejoraView(todoVM: todoVM)
                .presentationDetents([.fraction(0.15)])
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
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                HStack {
                    Text("Nombre de la tarea")
                        .bold()
                        .strikethrough(completado)
                    Spacer()
                    Button(
                        action: { completado.toggle() },
                        label: {
                            Image(
                                systemName: completado
                                    ? "checkmark.circle.fill"
                                    : "circle"
                            )
                            .font(.system(size: 25))
                            .foregroundColor(
                                completado ? .blue : .gray
                            )
                        }
                    )
                }

                Text(mejora.descripcion)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            Divider()
            Text("Today 10:00PM")
                .font(.footnote)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(radius: 2)
    }
}

#Preview {
    @StateObject var todoVM: TodoHomeViewModel = TodoHomeViewModel()
    PanelMejoras(todoVM: todoVM)
        .padding(.horizontal)
}
