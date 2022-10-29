//
//  ContentView.swift
//  Todo App
//
//  Created by Welliton da Conceicao de Araujo on 28/10/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    // MARK: - PROPERTIES
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @State private var addTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List(0..<5) {item in
                Text("sss")
            }
            .navigationBarTitle("Tarefas", displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: {
                    self.addTodoView.toggle()
                }){
                    Image(systemName: "plus")
                }
                .sheet(isPresented: $addTodoView) {
                    AddTodoView().environment(\.managedObjectContext, self.managedObjectContext)
                }
            )
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
