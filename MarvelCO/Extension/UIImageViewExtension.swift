//
//  UIImageViewExtension.swift
//  MarvelCO
//
//  Created by Geraldo Fernandes on 06/04/24.
//

import UIKit

extension UIImageView {
    @discardableResult
    func loadImage(fromURL urlString: String, completion: @escaping () -> Void) -> URLSessionDataTask? {
        guard let url = URL(string: urlString) else { return nil }

        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Erro ao baixar imagem: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
            
            completion()
        }
        task.resume()
        
        return task
    }
}

