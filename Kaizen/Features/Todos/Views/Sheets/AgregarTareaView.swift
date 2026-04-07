import SwiftUI

struct AgregarTareaView:View {
    @ObservedObject var todoVM:TodoHomeViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState var focus:Bool
    @State var name:String = ""
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Image(systemName: "circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height: 20)
                    .foregroundColor(.gray)
                TextField("Agregar una tarea", text: $name)
                    .focused($focus)
                Button(action:{
                    todoVM.createNewTodo(name: name)
                    name = ""
                },label:{
                    Image(systemName: "arrowtriangle.up.square.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20,height: 20)
                })
                .disabled(name.isEmpty)
            }
            Divider()
            ScrollView(.horizontal,showsIndicators: false){
                HStack(spacing:20){
                    ButtonTextImage(text: "Definir fecha de vencimiento", image: "calendar")
                    ButtonTextImage(text: "Recordarme", image: "bell")
                    ButtonTextImage(text: "Repetir", image: "repeat")
                }
            }
            Spacer()
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

struct ButtonTextImage:View {
    let text:String
    let image:String
    
    var body: some View {
        Button(action:{},label: {
            HStack{
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20,height: 20)
                    .foregroundColor(.gray)
                Text(text)
                    .foregroundColor(.gray)
            }
        })
    }
}

struct ButtonRadioTodoView:View {
    @State var completed:Bool = false
    var body: some View {
        Image(systemName: completed ? "checkmark.circle.fill" : "circle")
            .foregroundColor(completed ? .green : .gray)
            .onTapGesture {
                completed.toggle()
            }
    }
}

//#Preview {
//    CrearTareaView()
//}
