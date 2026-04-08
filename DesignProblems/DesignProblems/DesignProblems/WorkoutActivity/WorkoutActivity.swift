//
//  WorkoutActivity.swift
//  DesignProblems
//
//  Created by Abhay Curam on 11/16/25.
//

import HealthKit

public struct HKSampleData {}

public protocol WorkoutCalorieComputation {
    func getTotalCaloriesBurned(_ healthData: [HKSampleData]) -> NSNumber
    func getActiveCaloriesBurned(_ healthData: [HKSampleData]) -> NSNumber
}

public protocol WorkoutActivity {
    var workoutTitle: String { get }
    var workoutID: String { get }
    var healthKitQuantityTypes: [HKQuantityTypeIdentifier] { get }
    var calorieComputation: WorkoutCalorieComputation { get }
}

public struct RunningWorkoutCalorieComputation: WorkoutCalorieComputation {
    public func getTotalCaloriesBurned(_ healthData: [HKSampleData]) -> NSNumber {
        //imagine doing some custom math
        return 0
    }
    
    public func getActiveCaloriesBurned(_ healthData: [HKSampleData]) -> NSNumber {
        //imagine doing some custom math
        return 0
    }
}

public struct RunningWorkoutActivity: WorkoutActivity {
    public var workoutTitle: String
    public var workoutID: String
    public var healthKitQuantityTypes: [HKQuantityTypeIdentifier]
    public var calorieComputation: any WorkoutCalorieComputation
    
    public init(_ workoutID: String) {
        self.workoutID = workoutID
        self.workoutTitle = "Running"
        self.healthKitQuantityTypes = [.heartRate, .runningPower, .runningSpeed, .activeEnergyBurned]
        self.calorieComputation = RunningWorkoutCalorieComputation()
    }
}

/**
 * This model is what we write to disk and send to the phone.
 */
public struct WorkoutActivityReport: Codable {
    let workoutTime: TimeInterval
    //These would be better as there own measurement object
    //wrapping a unit of measurement and a NSNumber.
    let distanceInFeet: Float
    let distanceInMiles: Float
    let elevationGainInFeet: Float
    let totalCalories: Int
    let activeCalories: Int
    let avgHeartRatebpm: Int
    let avgPower: Int
    let averagePace: TimeInterval
}

