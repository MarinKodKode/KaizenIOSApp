import SwiftUI

struct CreateToDoView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var todoVm:TodoViewModel
    var body: some View {
        VStack {
            HStack {
                BackButtonView {
                    todoVm.createNote()
                    router.popToRoot()
                }
                TextField("Titulo", text: $todoVm.title)
                    .font(.title)
                
                if todoVm.isNoteModify {
                    Image(systemName: "trash.fill")
                        .onTapGesture {
                            todoVm.borrarTarea()
                        }
                }
            }

            Divider()
            TextEditor(text: $todoVm.note)
            Divider()
            Spacer()
        }.padding(.horizontal)
            .navigationBarBackButtonHidden(true)
    }
}

//#Preview {
//    @StateObject var todoVm = TodoViewModel()
//    CreateToDoView()
//        .environmentObject(todoVm)
//}
