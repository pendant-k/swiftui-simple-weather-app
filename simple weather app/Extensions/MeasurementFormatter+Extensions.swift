import Foundation

// Measurement

extension MeasurementFormatter {
    static func temperature(value: Double) -> String {
        let numberFormatter = NumberFormatter()
        // 소수점 아래 제거
        numberFormatter.maximumFractionDigits = 0

        let formatter = MeasurementFormatter()
        formatter.numberFormatter = numberFormatter

        let temp = Measurement(value: value, unit: UnitTemperature.kelvin)

        return formatter.string(from: temp)
    }
}
