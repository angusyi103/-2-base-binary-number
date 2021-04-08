import Foundation

/*
 Given an binary array using -2 base
 | 1 | -2 | 4 | -8 | 16 | -32 |
 
 [0, 1, 1, 1, 1, 1] == -22
 
 divide the number by two and return an binary array using -2 base
 
 [1, 0, 1, 0, 1, 1] == -11
 */

public func solution(_ A : inout [Int]) -> [Int] {
    // write your code in Swift 4.2.1 (Linux)

    var result = 0
    for (power, num) in A.enumerated() {
        result += Int(pow(-2, Double(power))) * num
    }
    
    print(result)
    print(ceil(Double(result)/2))
    
    var positiveBinaryStr = ""
    let divideNumber = ceil(Double(result)/2)
    if divideNumber < 0 {
        var power = ceil(log2(divideNumber * -1))
        if Int(power) % 2 == 0 {
            power += 1
        }
        
        var finalAry = [Int](repeating: 0, count: Int(power+1))
        finalAry[Int(power)] = 1
        print(finalAry)
        
        let positiveNum = Int(divideNumber - pow(-2, power))
        positiveBinaryStr = String(positiveNum, radix: 2)
        print(positiveBinaryStr)
        let carryNegativeNumAry = carryNegativeNum(binaryStr: positiveBinaryStr)
        for (index, _) in carryNegativeNumAry.enumerated() {
            finalAry[index] = carryNegativeNumAry[index]
        }
        return finalAry
    } else {
        positiveBinaryStr = String(Int(divideNumber), radix: 2)
        print(positiveBinaryStr)
        let carryNegativeNumAry = carryNegativeNum(binaryStr: positiveBinaryStr)
        return carryNegativeNumAry
    }
}

func carryNegativeNum(binaryStr: String) -> [Int] {
    var positiveBinaryAry: [Int] = binaryStr.map { (Int(String($0)) ?? 0) }
    var tempBinaryAry = [Int]()
    print(positiveBinaryAry)
    for (index, _) in positiveBinaryAry.enumerated() {
        print("index, element",index, positiveBinaryAry[index])
        print("positiveBinaryAry",positiveBinaryAry)
        print("tempBinaryAry",tempBinaryAry)
        
        if positiveBinaryAry[index] == 0 {
            tempBinaryAry.append(0)
        } else if positiveBinaryAry[index] == 1 {
            if isNegativeNum(index: index) {
                if positiveBinaryAry.indices.contains(index+1) {
                    positiveBinaryAry[index+1] += 1
                }
            }
            
            tempBinaryAry.append(1)
        } else {
            tempBinaryAry.append(0)
            if positiveBinaryAry.indices.contains(index+1) {
                positiveBinaryAry[index+1] += 1
            } else {
                if isNegativeNum(index: index + 1) {
                    tempBinaryAry.append(1)
                }
                tempBinaryAry.append(1)
            }
        }
    }
    
    print(tempBinaryAry)
    return tempBinaryAry
}

func isNegativeNum(index: Int) -> Bool {
    return index % 2 == 1
}

var ary = [0, 1, 1, 1, 1, 1]
let result = solution(&ary)
print(result)
