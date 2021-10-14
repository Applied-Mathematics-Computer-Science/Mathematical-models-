import Foundation

/*: Метод парабол

 */

func myFunc(x: Double) -> Double {
    return x*x - 2*4*x + 16 + log(x)
}

func isPoint(x1: Double, x2: Double, x3: Double) -> Bool {
    
    if myFunc(x: x1) > myFunc(x: x2) && myFunc(x: x2) < myFunc(x: x3) {
        return true
    }
    return false
}

func sgn(x: Double) -> Int {
    return x > 0 ? 1:-1
}

func parabolMethod() -> Void {
    
    let 𝜀: Double = 1e-6
    var h: Double = 1e-6

    var x: [Double] = [0,0,0]
    
    x[0] = 3
    
    var i:Int

    if myFunc(x:x[0] + h) <= myFunc(x: x[0]) {
     
        x[1] = x[0] + h * pow(2, 2) + 2*h
        x[2] = x[0] + h * pow(2, 3) + 3*h
  
        i = 3
        while !isPoint(x1: x[0], x2: x[1], x3: x[2])  {
            h *= 2
            i += 1
            x.removeFirst()
            x.append(x[0] + h * pow(2, Double(i)) + Double(i)*h)
        }
        print("x1,x2,x3;  i = :", i)
        
       
    } else if myFunc(x: x[0] + h) > myFunc(x: x[0]) {
        x[1] = x[0] - h * pow(2, 2) - 2*h
        x[2] = x[0] - h * pow(2, 3) - 3*h
        
        i = 3
        while !isPoint(x1: x[0], x2: x[1], x3: x[2])  {
            i += 1
            h *= 2
            x.removeFirst()
            x.append(x[0] - h * pow(2, Double(i)) - Double(i)*h)
        }
        print("x1,x2,x3;  i = :", i)
    }
    

    var f:[Double] = [0,0,0]
    
    for i in 0..<3 {
        f[i] = myFunc(x: x[i])
    }
    
    i = 0
    while fabs(f[1] - f[0]) > 𝜀 {
        i += 1
        
        let x4 = (x[0] + x[1]) / 2 +
                 (f[0] - f[1]) * (x[1] - x[2]) * (x[2] - x[0]) /
                 (2*(f[0] * (x[1] - x[2]) + f[1]*(x[2] - x[0]) + f[2]*(x[0] - x[1])))
        
        x.append(x4)
        f.append(myFunc(x: x4))
        
        x.sort { (one, two) in return myFunc(x: one) < myFunc(x: two) }

        for i in 0..<4 {
            f[i] = myFunc(x: x[i])
        }

        if sgn(x: x[1] - x[0]) == sgn(x:x[2] - x[0]) &&
            sgn(x: x[2] - x[0]) == -sgn(x:x[3] - x[0]) {
            
            x[2] = x[3]
            f[2] = f[3]
        }
        
        x.removeLast()
        f.removeLast()
        
        for i in 0..<3 {
            f[i] = myFunc(x: x[i])
        }
        
        var min = x[0]
        min = round(1000000*min)/1000000
        
        print()
        print("iter", i)
        print("xmin = ", min)
        print("f(x) = ", myFunc(x:min))
        
    }
}

parabolMethod()

