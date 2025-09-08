struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ListViewModel())
    }
}

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: ListViewModel
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            Group {
                if viewModel.useLazyStack {
                    ScrollView {
                        VStack(spacing: 12) {
                            sectionView(title: "Tamamlanacaklar", items: pendingItems)
                            sectionView(title: "Tamamlananlar", items: completedItems)
                        }
                        .padding()
                    }
                } else {
                    List {
                        Section(header: Text("Tamamlanacaklar")) {
                            ForEach(pendingItems) { item in
                                NavigationLink(destination: DetailView(item: item)) {
                                    rowView(item: item)
                                }
                                .swipeActions(edge: .leading) {
                                    Button { viewModel.toggleComplete(item.id) } label: { Label("Tamamlandı", systemImage: "checkmark") }
                                }
                            }
                            .onDelete { offsets in
                                let ids = offsets.map { pendingItems[$0].id }
                                viewModel.delete(ids: ids)
                            }
                        }

                        Section(header: Text("Tamamlananlar")) {
                            ForEach(completedItems) { item in
                                NavigationLink(destination: DetailView(item: item)) {
                                    rowView(item: item)
                                }
                                .swipeActions {
                                    Button(role: .destructive) { viewModel.delete(ids: [item.id]) } label: { Label("Sil", systemImage: "trash") }
                                }
                            }
                            .onDelete { offsets in
                                let ids = offsets.map { completedItems[$0].id }
                                viewModel.delete(ids: ids)
                            }
                        }
                    }
                    .listStyle(.insetGrouped)
                }
            }
            .navigationTitle("MasterListApp")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { viewModel.applyRandomTheme() }) {
                        Image(systemName: "paintpalette")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack(spacing: 12) {
                        Button(action: { viewModel.useLazyStack.toggle() }) {
                            Image(systemName: viewModel.useLazyStack ? "list.bullet" : "square.grid.2x2")
                        }
                        Button(action: { showAdd = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAdd) {
                AddItemView()
                    .environmentObject(viewModel)
            }
            .tint(viewModel.themeColor)
            .onAppear { viewModel.applyRandomTheme() }
        }
    }

    private var pendingItems: [TodoItem] { viewModel.items.filter { !$0.isCompleted } }
    private var completedItems: [TodoItem] { viewModel.items.filter { $0.isCompleted } }

    @ViewBuilder
    private func rowView(item: TodoItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title).font(.headline)
                Text(item.detail).font(.subheadline).foregroundColor(.secondary).lineLimit(2)
            }
            Spacer()
            if item.isCompleted {
                Image(systemName: "checkmark.seal.fill").foregroundColor(.green)
            }
        }
        .padding(.vertical, 6)
    }

    @ViewBuilder
    private func sectionView(title: String, items: [TodoItem]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.title3).bold()
            LazyVStack(alignment: .leading, spacing: 8) {
                ForEach(items) { item in
                    NavigationLink(destination: DetailView(item: item)) {
                        rowView(item: item)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(.secondarySystemBackground)))
                    }
                    .swipeActions {
                        Button(role: .destructive) { viewModel.delete(ids: [item.id]) } label: { Label("Sil", systemImage: "trash") }
                    }
                }
            }
        }
    }
}
