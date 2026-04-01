import SwiftUI
import Combine

struct TodoHomeView: View {
    //Properties wrappers
    @EnvironmentObject var router:Router
    @ObservedObject var todoVM:TodoHomeViewModel
    @State var categoria = ""
    
    //Constantes para UI
    let gridItems = [GridItem(.flexible())]
    let bgColor:Color = .beige
    let fgColorText:Color = .black
    let bgColorButtonCrear:Color = .brown
    
    var body: some View{
        ZStack(alignment: .bottomTrailing){
            bgColor
                .ignoresSafeArea()
            
            VStack(spacing:30){
                header
                content
                Spacer()
            }
            .padding(.horizontal)
            
            Button(action:{ router.navigate(to: .createAndModifyToDo) },label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.white)
                    .padding()
            })
            .clipShape(Circle())
            .background(bgColorButtonCrear)
            .cornerRadius(10)
            .padding()
        }
    }
    
    var header:some View{
        VStack {
            HStack{
                VStack(alignment:.leading){
                    Text("Hola!")
                    Text("Ahmed Garcia")
                }
                .font(.system(size:25).bold())
                .foregroundColor(fgColorText)
                
                Spacer()
                Image(systemName: "person.crop.square.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 60,height: 60)
                    .foregroundColor(fgColorText)
            }
            
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .padding(.leading)
                
                TextField("Buscar categoria",text: $categoria)
                Spacer()
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity,maxHeight: 40)
            .clipShape(Rectangle())
            .background(.white)
            .cornerRadius(10)
        }.task {
            todoVM.loadLists()
        }
    }
    
    var content: some View{
        VStack(alignment: .leading, spacing:30) {
            Text("Listas")
                .font(.system(size:20))
                .foregroundColor(fgColorText)
                .bold()
            
            if todoVM.listas.isEmpty {
                VStack{
                    Image(systemName: "tree")
                         .resizable()
                         .aspectRatio(contentMode: .fit)
                         .frame(width: 150,height: 150)
                     
                     Text("""
                         Todavia no hay ninguna lista de tareas.
                         Pulsa + para empezar a planificar tus tareas
                         """)
                     .multilineTextAlignment(.center)
                     .frame(maxWidth: .infinity)
                }
            }else{
                ScrollView(.horizontal){
                    LazyHStack(spacing:20){
                        ForEach(todoVM.listas, id: \.self) { lista in
                            CardListaView(todoVM:todoVM,lista: lista)
                        }
                    }
                }
                .frame(height:150)
            }
        }
    }
}

//#Preview {
//    @StateObject var router = Router.shared
//    @StateObject var todo = TodoHomeViewModel()
//    
//    TodoHomeView(todoVM: todo)
//        .environmentObject(router)
//}
