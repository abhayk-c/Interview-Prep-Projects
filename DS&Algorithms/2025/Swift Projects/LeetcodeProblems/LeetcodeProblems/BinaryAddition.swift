class BinaryAdder {
    func addBinary(_ a: String, _ b: String) -> String {
        let charArrayA = Array(Array(a).reversed())
        let charArrayB = Array(Array(b).reversed())
        let size = max(charArrayA.count, charArrayB.count)
        var carryValue = 0
        var binaryResultString = ""
        for i in 0..<size {
            if i < charArrayA.count && i < charArrayB.count {
                guard let intValueA = charArrayA[i].wholeNumberValue,
                      let intValueB = charArrayB[i].wholeNumberValue else { return "" }
                let sum = intValueA + intValueB + carryValue
                let binaryResult = getBinarySumAndCarryFromDecimal(sum)
                carryValue = binaryResult.carry
                binaryResultString.append(String(binaryResult.sum))
            } else if i < charArrayA.count {
                guard let intValueA = charArrayA[i].wholeNumberValue else { return "" }
                let binaryResult = getBinarySumAndCarryFromDecimal(intValueA + carryValue)
                carryValue = binaryResult.carry
                binaryResultString.append(String(binaryResult.sum))
            } else if i < charArrayB.count {
                guard let intValueB = charArrayB[i].wholeNumberValue else { return "" }
                let binaryResult = getBinarySumAndCarryFromDecimal(intValueB + carryValue)
                carryValue = binaryResult.carry
                binaryResultString.append(String(binaryResult.sum))
            }
        }

        if carryValue > 0 { binaryResultString.append(String(carryValue)) }
        return String(binaryResultString.reversed())
    }

    func getBinarySumAndCarryFromDecimal(_ value: Int) -> (sum: Int, carry: Int)
    {
        if value == 1 || value == 0 {
            return (sum: value, carry: 0)
        } else if value == 2 {
            return (sum: 0, carry: 1)
        } else {
            return (sum: 1, carry: 1)
        }
    }
}
