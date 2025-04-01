import Foundation

class CustomerViewModel: ObservableObject {
    @Published var customers: [Customer] = []
    @Published var searchText = ""

    init() {
        loadCustomers()
    }

    func loadCustomers() {
        if let url = Bundle.main.url(forResource: "customers", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            let decoder = JSONDecoder()
            customers = (try? decoder.decode([Customer].self, from: data)) ?? []
        }
    }

    func toggleActiveStatus(for customer: Customer) {
        if let index = customers.firstIndex(where: { $0.Id == customer.Id }) {
            customers[index].IsActive.toggle()
            objectWillChange.send()
        }
    }

    func deleteCustomer(_ customer: Customer) {
        customers.removeAll { $0.Id == customer.Id }
    }

    var filteredCustomers: [Customer] {
        if searchText.isEmpty {
            return customers
        } else {
            return customers.filter {
                $0.DisplayName.localizedCaseInsensitiveContains(searchText) ||
                $0.city.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
