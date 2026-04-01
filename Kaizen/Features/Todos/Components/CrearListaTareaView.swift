import SwiftUI

struct CrearListaTareaView: View {
    @EnvironmentObject var router:Router
    @EnvironmentObject var todoVM:TodoHomeViewModel
    @Environment(\.dismiss) var dismiss
    @State var title = ""
    @Binding var currentColor:ColorOptionModel
    var body: some View {
        VStack(alignment: .leading) {
            Text("Nueva Lista")
                .font(.system(size: 25).bold())

            TextField("Escribe el titulo de la lista", text: $title)
            Divider()
            Spacer()

            PanelColoresView(currentColor: $currentColor)

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
                        todoVM.createNewList(title:title, color: currentColor)
                        dismiss()
                    },
                    label: {
                        Text("Crear Lista")
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
    }
}

#Preview {
    @State var currentColor: ColorOptionModel = ColorOptionModel()
    CrearListaTareaView(currentColor: $currentColor)
}
