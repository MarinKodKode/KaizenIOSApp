//
//  TodoHomeView.swift
//  Kaizen App
//
//  Created by Lettuce, Gaona & KodKode on 30/03/26.
//

import SwiftUI
import Combine
import SwiftUI

//Constantes para UI
let gridItems = [GridItem(.flexible())]
let bgColor: Color = .beige
let fgColorText: Color = .black
let bgColorButtonCrear: Color = .brown

struct TodoHomeView: View {
    
    @EnvironmentObject private var router : Router
    
    @ObservedObject private var vmTodoHome : TodoHomeViewModel = TodoHomeViewModel()
    
    let gridItems = [GridItem(.flexible())]
    
    let bgColor:Color = .beige
    
    let fgColorText:Color = .black
    
    let bgColorButtonCrear:Color = .bruguer
    
    var body: some View{
        ZStack(alignment: .bottomTrailing){
            bgColor
                .ignoresSafeArea()
            
            VStack(alignment: .leading){
                
                HStack{
                    VStack(alignment:.leading){
                        Text("Ahmed Garcia")
                    }
                    .font(.system(size:25).bold())
                    .foregroundColor(fgColorText)
                    
                    Spacer()
                    
                    Image("profile_pic")
                        .resizable()
                        .scaledToFill()
                        .foregroundStyle(.white)
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                    
                    Image("inbursa")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 48, height: 48)
                        .clipShape(Circle())
                }
                
//                HStack{
//                    Image(systemName: "magnifyingglass")
//                        .foregroundColor(.gray)
//                        .padding(.leading)
//                    
//                    TextField("Buscar categoria",text: $vmTodoHome.categoria)
//                    Spacer()
//                    Image(systemName: "slider.horizontal.3")
//                        .foregroundColor(.gray)
//                        .padding(.trailing)
//                }
//                .frame(maxWidth: .infinity,maxHeight: 40)
//                .clipShape(Rectangle())
//                .background(.white)
//                .cornerRadius(10)
                
                Text("Listas")
                    .font(.system(size:20))
                    .foregroundColor(fgColorText)
                    .bold()
                
                if vmTodoHome.listas.isEmpty{
                    
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
                            ForEach(vmTodoHome.listas, id: \.self) { lista in
                                CardListaView(lista: lista)
                            }
                        }
                    }
                    .frame(height:150)
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .padding(.top, 48)
            
            Button(action:{ router.navigate(to: .createAndModifyToDo) },label: {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 15,height: 15)
                    .foregroundColor(.white)
                    .padding()
            })
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

            Button(
                action: { router.navigate(to: .createAndModifyToDo) },
                label: {
                    Image(systemName: "plus")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 15, height: 15)
                        .foregroundColor(.white)
                        .padding()
                }
            )
            .clipShape(Circle())
            .background(bgColorButtonCrear)
            .cornerRadius(10)
            .padding()
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

//            HStack {
//                Image(systemName: "magnifyingglass")
//                    .foregroundColor(.gray)
//                    .padding(.leading)
//
//                TextField("Buscar categoria", text: $categoria)
//                Spacer()
//                Image(systemName: "slider.horizontal.3")
//                    .foregroundColor(.gray)
//                    .padding(.trailing)
//            }
//            .frame(maxWidth: .infinity, maxHeight: 40)
//            .clipShape(Rectangle())
//            .background(.white)
//            .cornerRadius(10)
        }.task {
            todoVM.loadLists()
        }
    }

    var content: some View {
        VStack(alignment: .leading, spacing: 30) {
            
//            PanelMejorasView()
            panelMejoras
            
            HeaderText(text: "Listas")

            if todoVM.listas.isEmpty {
                VStack {
                    Image(systemName: "tree")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150, height: 150)

                    Text(
                        """
                        Todavia no hay ninguna lista de tareas.
                        Pulsa + para empezar a planificar tus tareas
                        """
                    )
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                }
            } else {
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 20) {
                        ForEach(todoVM.listas, id: \.self) { lista in
                            CardListaView(todoVM: todoVM, lista: lista)
                        }
                    }
                }
                .frame(height: 150)
            }
        }
    }
    
    var panelMejoras:some View{
        PanelMejorasView(todoVM:todoVM)
    }
}

struct PanelMejorasView: View {
    @ObservedObject var todoVM:TodoHomeViewModel
    var body: some View {
        VStack {
            HeaderText(text: "Mejoras de hoy")

            if todoVM.mejoras.isEmpty {
                CardMejoraEmptyView()
            }else{
                VStack(){
                    ForEach(todoVM.mejoras) { mejora in
                        Text(mejora.descripcion.capitalized)
                            .frame(maxWidth: .infinity, maxHeight: 50,alignment: .leading)
                            .foregroundColor(.white)
                            .bold()
                            .padding(.horizontal)
                            .cardRoundedRectangleStyle(bgColor: Color(hex: mejora.color), cornerRadius: 10)
                            .onTapGesture {
                                todoVM.modificatMejoraDatos(mejora:mejora)
                            }
                    }
                }
            }

            ButtonAddMejoraView(todoVM:todoVM)
        }.frame(maxWidth: .infinity)
    }
}

struct CardMejoraEmptyView: View {
    var body: some View {
        Text("No hay mejoras por mostrar")
            .frame(maxWidth: .infinity, maxHeight: 50)
            .font(.footnote)
            .foregroundColor(.gray)
            .bold()
            .cardRoundedRectangleStyle(bgColor: .gray.opacity(0.4), cornerRadius: 10)
    }
}

struct ButtonAddMejoraView: View {
    @ObservedObject var todoVM:TodoHomeViewModel
    
    var body: some View {
        Button(
            action: { todoVM.openMejora = true },
            label: {
                VStack {
                    Text("Agrega una mejora")
                        .multilineTextAlignment(.center)
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .bold()

                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 20))
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.white, .black)
                }
                .foregroundColor(.orange)
                .frame(maxWidth: .infinity, maxHeight: 50)
                .cardRoundedRectangleStyle(bgColor: .white, cornerRadius: 10)
                .cardDashStyle(dashColor: .black, cornerRadius: 10, dashLineWidth: 1.5, segmentDash: 6)
            })
        .sheet(isPresented: $todoVM.openMejora) {
            AgregarMejoraView(todoVM:todoVM)
                .presentationDetents([.fraction(0.25)])
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
    TodoHomeView()
    @StateObject var router = Router.shared
    @StateObject var todoVM = TodoHomeViewModel()
    @Environment(\.modelContext) var context

    TodoHomeView(todoVM: todoVM)
        .environmentObject(router)
        .task {
            todoVM.configure(context: context)
        }
}
