//: [Previous](@previous)

import Foundation
enum Direction : String {
    case Latitude = "Latitude";
    case Longitude = "Longitude";
}

func find_pole(direction:Direction, degrees:Int) -> String {
    if direction == Direction.Latitude && 0 <= degrees && degrees <= 90 {
        return "N";
    }
    if direction == Direction.Latitude && -90 <= degrees && degrees < 0 {
        return "S";
    }
    if direction == Direction.Longitude && 0 <= degrees && degrees <= 180 {
        return "E";
    }
    if direction == Direction.Longitude && -180 <= degrees && degrees < 0 {
        return "W";
    }
    return "Oups";
}

class CoordinatePD {
    var direction: Direction;
    var degrees: Int;
    var minutes: UInt;
    var seconds: UInt;
    var pole: String;

    
    init() {
        self.degrees = 1;
        self.minutes = 2;
        self.seconds = 3;
        self.direction = Direction.Latitude;
        self.pole = "N";
    }
    
    init?(degrees: Int, minutes: UInt, seconds: UInt, direction: Direction) {
        if !(
            (
                -90 <= degrees && degrees <= 90 && direction == Direction.Latitude ||
                -180 <= degrees && degrees <= 180 && direction == Direction.Longitude
            ) &&
            0 <= minutes && minutes <= 59 &&
            0 <= seconds && seconds <= 59
        ) {
            print("Invalid parameter(s)!");
            return nil
        }
        self.degrees = degrees;
        self.minutes = minutes;
        self.seconds = seconds;
        self.direction = direction;
        self.pole = find_pole(direction:direction, degrees: degrees);
    }

    func method_1() -> String {
        return "\(abs(self.degrees))°\(self.minutes)'\(self.seconds)\" \(self.pole)"
    }
    
    func method_2() -> String {
        let degrees_in_float: Float = Float(abs(self.degrees)) + Float(self.minutes)/60 + Float(self.seconds)/3600;
        return "\(degrees_in_float)° \(self.pole)";
    }
    
    func method_3(coord: CoordinatePD) -> CoordinatePD? {
        if self.direction != coord.direction {
            return nil;
        }
        let degrees_3 = (self.degrees + coord.degrees) / 2;
        let minutes_3 = (self.minutes + coord.minutes) / 2;
        let seconds_3 = (self.seconds + coord.seconds) / 2;
        return CoordinatePD(degrees: degrees_3, minutes: minutes_3, seconds: seconds_3, direction: self.direction)
    }
    
    func method_4(coord_1:CoordinatePD, coord_2: CoordinatePD) -> CoordinatePD? {
        if coord_1.direction != coord_2.direction {
            return nil;
        }
        let degrees_3 = (coord_1.degrees + coord_2.degrees) / 2;
        let minutes_3 = (coord_1.minutes + coord_2.minutes) / 2;
        let seconds_3 = (coord_1.seconds + coord_2.seconds) / 2;
        return CoordinatePD(degrees: degrees_3, minutes: minutes_3, seconds: seconds_3, direction: coord_1.direction)
    }
    
}

let coord = CoordinatePD(degrees: -46,minutes: 34,seconds: 45, direction: .Latitude);
print(coord?.method_1() ?? "Oups");
print(coord?.method_2() ?? "Oups");

let coord_2 = CoordinatePD(degrees: 345, minutes: 12, seconds: 23, direction: .Longitude);
print(coord_2?.method_1() ?? "Oups");
print(coord_2?.method_2() ?? "Oups");

let coord_3 = CoordinatePD();
print(coord_3.method_1());
print(coord_3.method_2());

let coord_4 = coord?.method_3(coord: coord_3);
print(coord_4?.method_1() ?? "Oups");
print(coord_4?.method_2() ?? "Oups");

let coord_5 = coord_4?.method_4(coord_1: coord ?? coord_3, coord_2: coord_3)
print(coord_5?.method_1() ?? "Oups");
print(coord_5?.method_2() ?? "Oups");

//: [Next](@next)

