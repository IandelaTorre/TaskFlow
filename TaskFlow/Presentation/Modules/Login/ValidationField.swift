//
//  ValidationField.swift
//  TaskFlow
//
//  Created by Ian Axel Perez de la Torre on 01/02/26.
//


import Foundation

public enum ValidationField: Equatable {
    case email
    case password
    case name
    case lastName
    case code
    case custom(label: String, regex: String)
}

public struct ValidationError: Error, Equatable {
    public let field: ValidationField
    public let message: String
}

public protocol InputValidator {
    /// Validates a single value for a given field. Returns nil if valid, or a ValidationError if invalid.
    func validate(_ value: String?, for field: ValidationField) -> ValidationError?
    /// Validates multiple fields at once. Returns the first error found, or nil if all are valid.
    func validateAll(_ inputs: [(ValidationField, String?)]) -> ValidationError?
}

public final class LoginInputValidator: InputValidator {

    // MARK: - Public API

    public init() {}

    public func validate(_ value: String?, for field: ValidationField) -> ValidationError? {
        switch field {
        case .email:
            return validateEmail(value)
        case .password:
            return validatePassword(value)
        case .name:
            return validateNonEmpty(value, field: field, label: "Nombre")
        case .lastName:
            return validateNonEmpty(value, field: field, label: "Apellido")
        case .code:
            return validateCode(value)
        case .custom(let label, let regex):
            return validateCustom(value, field: field, label: label, regex: regex)
        }
    }

    public func validateAll(_ inputs: [(ValidationField, String?)]) -> ValidationError? {
        for (field, value) in inputs {
            if let error = validate(value, for: field) { return error }
        }
        return nil
    }

    // MARK: - Private helpers

    private func validateNonEmpty(_ value: String?, field: ValidationField, label: String) -> ValidationError? {
        guard let trimmed = value?.trimmingCharacters(in: .whitespacesAndNewlines), !trimmed.isEmpty else {
            return ValidationError(field: field, message: "\(label) no puede estar vacío.")
        }
        return nil
    }

    private func validateEmail(_ value: String?) -> ValidationError? {
        let field: ValidationField = .email
        guard let email = value?.trimmingCharacters(in: .whitespacesAndNewlines), !email.isEmpty else {
            return ValidationError(field: field, message: "El email no puede estar vacío.")
        }
        // RFC 5322 simplified regex (suficientemente robusto para apps)
        let pattern = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,}$"
        if matches(email, pattern: pattern, options: [.caseInsensitive]) {
            return nil
        } else {
            return ValidationError(field: field, message: "El email no tiene un formato válido.")
        }
    }

    private func validatePassword(_ value: String?) -> ValidationError? {
        let field: ValidationField = .password
        guard let password = value, !password.isEmpty else {
            return ValidationError(field: field, message: "La contraseña no puede estar vacía.")
        }
        // Reglas: >=8, 1 mayúscula, 1 número, 1 caracter especial
        let lengthOK = password.count >= 8
        let hasUpper = matches(password, pattern: "[A-Z]")
        let hasDigit = matches(password, pattern: "[0-9]")
        let hasSpecial = matches(password, pattern: "[^A-Za-z0-9]")

        guard lengthOK else { return ValidationError(field: field, message: "La contraseña debe tener al menos 8 caracteres.") }
        guard hasUpper else { return ValidationError(field: field, message: "La contraseña debe incluir al menos una letra mayúscula.") }
        guard hasDigit else { return ValidationError(field: field, message: "La contraseña debe incluir al menos un número.") }
        guard hasSpecial else { return ValidationError(field: field, message: "La contraseña debe incluir al menos un caracter especial.") }
        return nil
    }

    private func validateCode(_ value: String?) -> ValidationError? {
        let field: ValidationField = .code
        guard let code = value?.trimmingCharacters(in: .whitespacesAndNewlines), !code.isEmpty else {
            return ValidationError(field: field, message: "El código no puede estar vacío.")
        }
        // Ajusta el patrón a tu formato de código (ejemplo: ABC-12345)
        let pattern = "^[A-Z]{3}-[A-Z0-9]{4,6}$"
        if matches(code, pattern: pattern) {
            return nil
        } else {
            return ValidationError(field: field, message: "El código no tiene el formato correcto.")
        }
    }

    private func validateCustom(_ value: String?, field: ValidationField, label: String, regex: String) -> ValidationError? {
        guard let text = value?.trimmingCharacters(in: .whitespacesAndNewlines), !text.isEmpty else {
            return ValidationError(field: field, message: "\(label) no puede estar vacío.")
        }
        if matches(text, pattern: regex, options: [.caseInsensitive]) {
            return nil
        } else {
            return ValidationError(field: field, message: "\(label) no tiene el formato correcto.")
        }
    }

    // MARK: - Regex helper

    private func matches(_ text: String, pattern: String, options: NSRegularExpression.Options = []) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: options)
            let range = NSRange(text.startIndex..<text.endIndex, in: text)
            return regex.firstMatch(in: text, options: [], range: range) != nil
        } catch {
            assertionFailure("Regex inválida: \(pattern) — error: \(error)")
            return false
        }
    }
}
