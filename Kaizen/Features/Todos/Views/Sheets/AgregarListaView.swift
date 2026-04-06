import SwiftUI

struct AgregarListaView: View {
    @EnvironmentObject var router:Router
    @ObservedObject var todoVM:TodoHomeViewModel
    @FocusState var focus:Bool
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack(alignment: .leading) {
            Text(todoVM.isModifyList ? "Modificar Lista" : "Nueva Lista")
                .font(.system(size: 25).bold())

            TextField("Escribe el titulo de la lista", text: $todoVM.title)
                .focused($focus)
            Divider()
            Spacer()

            PanelColoresView(currentColor: $todoVM.currentColor)

            HStack(spacing: 10) {
                Button(
                    action: {
                        dismiss()
                        todoVM.defaultView()
                    },
                    label: {
                        Text("Cancelar")
                            .foregroundColor(.gray)
                    }
                )

                Button(
                    action: {
                        if todoVM.isModifyList {
                            todoVM.modificarLista()
                        }else{
                            todoVM.createNewList()
                        }
                    },
                    label: {
                        Text(todoVM.isModifyList ? "Modificar" : "Crear Lista")
                            .foregroundColor(.blue)
                    }
                )
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top)
        .padding(.leading)
        .padding(.trailing)
        .background(.white)
        .onAppear{
            focus = true
        }
    }
}

//#Preview {
//    @State var currentColor: Color = .blue
//    @StateObject var todoVM:TodoHomeViewModel = TodoHomeViewModel()
//    CrearListaTareaView(todoVM:todoVM,currentColor: $currentColor)
//}
