import ArgumentParser
import ConvertCore

@main
struct Convert: ParsableCommand {
    static let configuration = CommandConfiguration(
        abstract: "A utility for converting between different units",
        subcommands: [Distance.self, Weight.self],
        defaultSubcommand: nil
    )
}

// MARK: - Distance subcommand
extension Convert {
    struct Distance: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Convert distance units (km, m, mi, yd)"
        )

        @Option(name: .shortAndLong, help: "Value to convert")
        var value: Double

        @Option(name: .shortAndLong, help: "Source unit (km, m, mi, yd)")
        var from: String

        @Option(name: .shortAndLong, help: "Target unit (km, m, mi, yd)")
        var to: String

        func run() throws {
            // Parse and validate units
            guard let fromUnit = DistanceUnit(rawValue: from) else {
                throw ConversionError.unsupportedUnit("Invalid source unit: \(from). Valid units: km, m, mi, yd")
            }

            guard let toUnit = DistanceUnit(rawValue: to) else {
                throw ConversionError.unsupportedUnit("Invalid target unit: \(to). Valid units: km, m, mi, yd")
            }

            // Perform conversion
            let result = try DistanceUnit.convert(value: value, from: fromUnit, to: toUnit)

            // Print result
            print("\(value) \(from) = \(result) \(to)")
        }
    }
}

// MARK: - Weight subcommand
extension Convert {
    struct Weight: ParsableCommand {
        static let configuration = CommandConfiguration(
            abstract: "Convert weight units (kg, g, lb, oz)"
        )

        @Option(name: .shortAndLong, help: "Value to convert")
        var value: Double

        @Option(name: .shortAndLong, help: "Source unit (kg, g, lb, oz)")
        var from: String

        @Option(name: .shortAndLong, help: "Target unit (kg, g, lb, oz)")
        var to: String

        func run() throws {
            // Parse and validate units
            guard let fromUnit = WeightUnit(rawValue: from) else {
                throw ConversionError.unsupportedUnit("Invalid source unit: \(from). Valid units: kg, g, lb, oz")
            }

            guard let toUnit = WeightUnit(rawValue: to) else {
                throw ConversionError.unsupportedUnit("Invalid target unit: \(to). Valid units: kg, g, lb, oz")
            }

            // Perform conversion
            let result = try WeightUnit.convert(value: value, from: fromUnit, to: toUnit)

            // Print result
            print("\(value) \(from) = \(result) \(to)")
        }
    }
}
