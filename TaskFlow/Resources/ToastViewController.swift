import UIKit

extension UIViewController {

    func showToast(message: String, seconds: Double = 2.0) {
        
        // 1. Buscamos la ventana principal activa de la aplicación
        // Esta es la forma moderna (iOS 13/15+) de encontrar la ventana sin warnings
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first(where: { $0.isKeyWindow }) else {
            return
        }
        
        // 2. Configuración de la etiqueta (Label)
        let toastLabel = UILabel()
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.8) // Un poco más oscuro
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 20 // Más redondeado
        toastLabel.clipsToBounds = true
        toastLabel.numberOfLines = 0 // Permite múltiples líneas si el texto es largo
        
        // Calculamos el tamaño basado en el texto
        let maxWidthPercentage: CGFloat = 0.8 // El toast ocupará máximo el 80% del ancho
        let maxSize = CGSize(width: window.frame.size.width * maxWidthPercentage, height: window.frame.size.height)
        let expectedSize = toastLabel.sizeThatFits(maxSize)
        
        // Añadimos padding (relleno)
        var width = expectedSize.width + 30
        let height = expectedSize.height + 20
        
        // Aseguramos un ancho mínimo para que no se vea ridículo con textos cortos
        width = max(width, 120)
        
        // Posición: Centrado horizontalmente, y pegado abajo con margen
        let x = (window.frame.size.width - width) / 2
        let y = window.frame.size.height - 100 // 100 puntos desde abajo
        
        toastLabel.frame = CGRect(x: x, y: y, width: width, height: height)
        
        // 3. ¡IMPORTANTE! Lo añadimos a la WINDOW, no a self.view
        window.addSubview(toastLabel)
        
        // Aseguramos que quede por encima de todo
        window.bringSubviewToFront(toastLabel)

        // 4. Animación de salida
        UIView.animate(withDuration: 0.5, delay: seconds, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: { _ in
            toastLabel.removeFromSuperview()
        })
    }
}
