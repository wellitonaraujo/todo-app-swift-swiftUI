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
    
    @FetchRequest(entity: Todo.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Todo.name, ascending: true)]) var todos: FetchedResults<Todo>
    
    @State private var addTodoView: Bool = false
    
    // MARK: - BODY
    var body: some View {
        NavigationView {
            List {
                ForEach(self.todos, id: \.self) {todo in
                    HStack {
                        Text(todo.name ?? "Unkown")
                        
                        Spacer()
                        
                        Text(todo.priority ?? "Unkown")
                    }
                }
                
                .onDelete(perform: deleteTodo)
            }
            .navigationBarTitle("Tarefas", displayMode: .inline)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
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
    
    // MARK: - FUNCTIONS
    
    private func deleteTodo(at offsets: IndexSet) { // deleting todo by index
        for index in offsets {
            let todo = todos[index]
            managedObjectContext.delete(todo)
        }
        
        do {
            try managedObjectContext.save()
        } catch {
            print(error)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
       ContentView()
        .previewDevice("iPhone 11 Pro")
    }
}
