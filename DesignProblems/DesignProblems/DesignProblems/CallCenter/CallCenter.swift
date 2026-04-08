//
//  CallCenter.swift
//  DesignProblems
//
//  Created by Abhay Curam on 10/28/25.
//

/**
 * Below are all just data model objects and abstract base
 * classes (protocols). Each model should have a clean single concern.
 */
public enum CallStatus {
    case callInSession, callEscalated, callResolved, callDropped
}

public enum CallEscalationLevel {
    case low     // respondents or above can handle call
    case medium  // managers or above can handle call
    case high    // only directors can handle the call
}

public protocol CallStatusDelegate: AnyObject {
    func didPickupCall(_ employee: CallCenterEmployee, _ call: Call?)
    func didSuccessfullyHandleCall(_ employee: CallCenterEmployee, _ call: Call?)
    func didEscalateCall(_ employee: CallCenterEmployee, _ call: Call?, _ toLevel: CallEscalationLevel)
}

public struct Call {
    let callID: String
    let caller: Person
    var callStatus: CallStatus
    var callEscalationLevel: CallEscalationLevel //essentially a priority
}

public protocol Person: AnyObject {
    var personID: String { get }
    var firstName: String { get }
    var lastName: String { get }
}

public protocol CallCenterEmployee: Person {
    var employeeID: String { get }
    var call: Call? { get set }
    var callStatusDelegate: CallStatusDelegate? { get set }
}

/*
 * A call center employee simply has some metadata and the single responsibility
 * of "handling" a call. Since it handles calls it reports on the "status" and can
 * update the call state, but it doesn't implement any business logic or call policy.
 *
 * I do believe there was oppportunity to have a CallHandler protocol, the methods
 * for handling calls are the same across each object.
 */
class Respondent: CallCenterEmployee {
    let personID: String
    let employeeID: String
    let firstName: String
    let lastName: String
    var call: Call? = nil
    weak var callStatusDelegate: CallStatusDelegate? = nil
    
    public init(_ personID: String,
                _ employeeID: String,
                _ firstName: String,
                _ lastName: String) {
        self.personID = personID
        self.employeeID = employeeID
        self.firstName = firstName
        self.lastName = lastName
    }
    
    private func didPickupCall() {
        call?.callStatus = .callInSession
        callStatusDelegate?.didPickupCall(self, call)
    }
    
    private func successfullyHandledCall() {
        call?.callStatus = .callResolved
        callStatusDelegate?.didSuccessfullyHandleCall(self, call)
    }
    
    private func escalatingCall() {
        call?.callStatus = .callEscalated
        callStatusDelegate?.didEscalateCall(self, call, .medium)
    }
}

class Manager: CallCenterEmployee {
    let personID: String
    let employeeID: String
    let firstName: String
    let lastName: String
    var call: Call? = nil
    weak var callStatusDelegate: CallStatusDelegate? = nil
    
    public init(_ personID: String,
                _ employeeID: String,
                _ firstName: String,
                _ lastName: String) {
        self.personID = personID
        self.employeeID = employeeID
        self.firstName = firstName
        self.lastName = lastName
    }
    
    private func didPickupCall() {
        call?.callStatus = .callInSession
        callStatusDelegate?.didPickupCall(self, call)
    }
    
    private func successfullyHandledCall() {
        call?.callStatus = .callResolved
        callStatusDelegate?.didSuccessfullyHandleCall(self, call)
    }
    
    private func escalatingCall() {
        call?.callStatus = .callEscalated
        callStatusDelegate?.didEscalateCall(self, call, .high)
    }
}

class Director: CallCenterEmployee {
    let personID: String
    let employeeID: String
    let firstName: String
    let lastName: String
    var call: Call? = nil
    weak var callStatusDelegate: CallStatusDelegate? = nil
    
    public init(_ personID: String,
                _ employeeID: String,
                _ firstName: String,
                _ lastName: String) {
        self.personID = personID
        self.employeeID = employeeID
        self.firstName = firstName
        self.lastName = lastName
    }
    
    private func didPickupCall() {
        call?.callStatus = .callInSession
    }
    
    private func successfullyHandledCall() {
        call?.callStatus = .callResolved
    }
    
    private func escalatingCall() {
        //no op for the director
    }
}


public protocol CallDispatcher {
    func dispatchCall(_ call: Call) -> Void
}

/**
 * This guys job is to store appropriately dispatch calls, and queue them if nobody
 * is available. This object stores all the responders in queues and implements the
 * dispatch escalation policy.
 *
 * I think this has streamlined enough responsibilities because the object implementing
 * the call escalation/dispatch policy needs to have access to the core data model
 * data structures otherwise its difficult to implement the policy. Separating the two
 * felt like a net negative.
 */
public class CallCenter: CallDispatcher, CallStatusDelegate {
    
    var availableResponders: [Respondent] = []
    var respondersInCalls: [String : Respondent] = [:]
    var availableManagers: [Manager] = []
    var managersInCalls: [String : Manager] = [:]
    var availableDirectors: [Director] = []
    var directorsInCalls: [String : Director] = [:]
    var callWaitingQueue: [Call] = []
    
    public init(_ employees: [CallCenterEmployee]) {
        //Imagine this processes all call center employees
        //and loads them into their appropriate queues
        for employee in employees {
            employee.callStatusDelegate = self
            if let director = employee as? Director {
                availableDirectors.append(director)
            } else if let manager = employee as? Manager {
                availableManagers.append(manager)
            } else if let responder = employee as? Respondent {
                availableResponders.append(responder)
            }
        }
    }
    
    public func dispatchCall(_ call: Call) {
        // TO DO Implement
    }
    
    public func didEscalateCall(_ employee: any CallCenterEmployee, _ call: Call?, _ toLevel: CallEscalationLevel) {
        // TO DO Implement
    }
    
    public func didPickupCall(_ employee: any CallCenterEmployee, _ call: Call?) {
        // TO DO Implement
    }
    
    public func didSuccessfullyHandleCall(_ employee: any CallCenterEmployee, _ call: Call?) {
        // TO DO Implement
    }
}

