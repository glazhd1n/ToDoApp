import Foundation

class APIService {
    static let shared = APIService()

    func fetchTodos(completion: @escaping (Result<[Todo], Error>) -> Void) {
        let urlString = "https://dummyjson.com/todos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else { return }

            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(.success(response.todos))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
