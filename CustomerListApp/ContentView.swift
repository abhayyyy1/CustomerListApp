import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = CustomerViewModel()

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(text: $viewModel.searchText)
                List {
                    ForEach(viewModel.filteredCustomers) { customer in
                        CustomerRow(customer: customer, viewModel: viewModel)
                    }
                }
            }
            .navigationTitle("Customers")
        }
    }
}

struct CustomerRow: View {
    let customer: Customer
    @ObservedObject var viewModel: CustomerViewModel

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(customer.DisplayName)
                    .font(.headline)
                    .foregroundColor(customer.IsActive ? .primary : .gray)
                Text(customer.city)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }

            Spacer()

            if customer.hasLocationErrors {
                Image(systemName: "exclamationmark.circle.fill")
                    .foregroundColor(.red)
            }

            Menu {
                Button(action: { viewModel.toggleActiveStatus(for: customer) }) {
                    Label(customer.IsActive ? "Deactivate" : "Activate", systemImage: "power")
                }
                Button(role: .destructive, action: { viewModel.deleteCustomer(customer) }) {
                    Label("Delete", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis.circle")
                    .foregroundColor(.gray)
            }
        }
        .padding()
    }
}
