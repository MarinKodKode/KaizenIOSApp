import Combine
import SwiftUI

//Constantes para UI
let gridItems = [GridItem(.flexible())]
let bgColor: Color = .beige
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

//            Button(
//                action: { router.navigate(to: .createAndModifyToDo) },
//                label: {
//                    Image(systemName: "plus")
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: 15, height: 15)
//                        .foregroundColor(.white)
//                        .padding()
//                }
//            )
//            .clipShape(Circle())
//            .background(bgColorButtonCrear)
//            .cornerRadius(10)
//            .padding()
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
            
            HeaderText(text: "Listas")

            if todoVM.listas.isEmpty {
//                VStack {
                    
//                    Image(systemName: "tree")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 150, height: 150)
//
//                    Text(
//                        """
//                        Todavia no hay ninguna lista de tareas.
//                        Pulsa + para empezar a planificar tus tareas
//                        """
//                    )
//                    .multilineTextAlignment(.center)
//                    .frame(maxWidth: .infinity)
                }
//            } else {
                ScrollView(.horizontal,showsIndicators: false) {
                    LazyHStack(alignment: .top ,spacing: 20) {
                        
                        Button(action: { router.navigate(to: .createAndModifyToDo) }, label: {
                            Image(systemName: "plus")
                                .frame(maxWidth: .infinity,maxHeight: .infinity)
                                .foregroundColor(.gray)
                        })
                        .frame(width: 110, height: 130)
                        .cardDashStyle(dashColor: .gray, cornerRadius: 10, dashLineWidth: 1.2, segmentDash: 8)
                        
                        ForEach(todoVM.listas, id: \.self) { lista in
                            CardListaView(todoVM: todoVM, lista: lista)
                        }
                    }
                }
                .frame(height: 150)
//            }
            
            PanelMejoras(todoVM:todoVM)
            
            
        }
    }
}

struct HeaderText:View {
    let text:String
    var body: some View {
        Text(text)
            .font(.system(size: 20,weight: .bold))
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
