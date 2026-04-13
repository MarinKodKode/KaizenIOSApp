import Combine
import SwiftUI

//Constantes para UI
let gridItems = [GridItem(.flexible())]
let bgColor: Color = .white
let fgColorText: Color = .black
let bgColorButtonCrear: Color = .brown

struct TodoHomeView: View {
    //Properties wrappers
    @EnvironmentObject var router: Router
    @ObservedObject var todoVM: TodoHomeViewModel

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            bgColor
                .ignoresSafeArea()

            VStack(spacing: 30) {
                header
                content
                Spacer()
            }
            .padding(.horizontal)
        }
    }

    var header: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Hola, Osmar Rivera")
                }
                .font(.system(size: 25).bold())
                .foregroundColor(fgColorText)

                Spacer()
                Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60, height: 60)
                    .foregroundColor(fgColorText)
            }
        }.task {
            todoVM.loadLists()
        }
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 30) {

            HStack{
                VStack(alignment:.leading){
                    HeaderText(text: "Listas")
                    Text("Tienes \(todoVM.listas.count ?? 0) listas")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                }
                Spacer()
                Button(
                    action: { router.navigate(to: .createAndModifyToDo) },
                    label: {
                        Text("+ Agregar")
                            .font(.system(size: 14))
                            .bold()
                    }
                )
                .padding(.vertical, 10)
                .padding(.horizontal, 14)
                .background(.blue.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 20) {
                    ForEach(todoVM.listas, id: \.self) { lista in
                        CardListaView(todoVM: todoVM, lista: lista)
                    }
                }
            }
            .frame(height: 140)
            
            PanelMejoras(todoVM: todoVM)
        }
    }
}

struct HeaderText: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .bold))
            .foregroundColor(fgColorText)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    @StateObject var router = Router.shared
    @StateObject var todoVM = TodoHomeViewModel()
    @Environment(\.modelContext) var context

    TodoHomeView(todoVM: todoVM)
        .environmentObject(router)
        .task {
            todoVM.configure(context: context)
        }
}
