import UIKit
import Foundation

/**
 * Hash Table implementation leveraging linear probing (open addressing)
 * for collision resolution with tombstoning of deleted values.
 */
public class Dictionary<Key: Hashable, Value: Any>
{
    private struct DictionaryNode
    {
        var key: Key
        var value: Value
        var isTombstone: Bool = false
        init(key: Key, value: Value) {
            self.key = key
            self.value = value
        }
    }
        
    private var data: [DictionaryNode?]
    private var occupiedBucketCount: Int
    private var numBuckets: Int
    private var loadFactor: Float {
        return Float(occupiedBucketCount) / Float(numBuckets)
    }
    
    public var count: Int
    
    public init() {
        numBuckets = 10
        occupiedBucketCount = 0
        count = 0
        data = Array<DictionaryNode?>(repeating: nil, count: numBuckets)
    }
    
    subscript(key: Key) -> Value? {
        get {
            return getValue(for: key)
        }
        set {
            if let value = newValue {
                setValue(value, for: key)
            } else {
                removeValue(for: key)
            }
        }
    }
    
    public func setValue(_ value: Value, for key: Key)
    {
        setValueWithoutRebalancing(value, for: key)
        rebalanceDictionaryIfApplicable()
    }
    
    private func setValueWithoutRebalancing(_ value: Value, for key: Key)
    {
        var hashIndex = abs(key.hashValue) % numBuckets
        var shouldUpdateCount = true
        var tombstoneIndex: Int? = nil
        var targetKeyFound = false
        var targetKeyIsTombstone = false
        
        /**
         * Dealing with the tombstone became somewhat non-trivial on key-value
         * insertions but I got it working. My original approach was too naiive.
         */
        while let currentNode = data[hashIndex] {
            if currentNode.isTombstone && tombstoneIndex != nil {
                tombstoneIndex = hashIndex
            }
            if currentNode.key == key {
                targetKeyFound = true
                targetKeyIsTombstone = currentNode.isTombstone
                break
            }
            hashIndex = (hashIndex >= numBuckets - 1) ? 0 : hashIndex + 1
        }
        
        if targetKeyFound {
            data[hashIndex] = DictionaryNode(key: key, value: value)
            if targetKeyIsTombstone { count += 1 }
        } else {
            if let unwrappedTombstoneIndex = tombstoneIndex {
                data[unwrappedTombstoneIndex] = DictionaryNode(key: key, value: value)
                count += 1
            } else {
                data[hashIndex] = DictionaryNode(key: key, value: value)
                occupiedBucketCount += 1
                count += 1
            }
        }
    }
    
    public func getValue(for key: Key) -> Value?
    {
        var hashIndex = abs(key.hashValue) % numBuckets
        //linear probe
        while let currentNode = data[hashIndex] {
            if currentNode.key == key {
                return (!currentNode.isTombstone) ? currentNode.value : nil
            } else {
                hashIndex = (hashIndex >= numBuckets - 1) ? 0 : hashIndex + 1
            }
        }
        
        return nil
    }
    
    public func removeValue(for key: Key)
    {
        var hashIndex = abs(key.hashValue) % numBuckets
        //linear probe
        while let currentNode = data[hashIndex] {
            if currentNode.key == key {
                var mutableDictionaryNode = currentNode
                mutableDictionaryNode.isTombstone = true
                data[hashIndex] = mutableDictionaryNode
                // We decrement the client facing count property but not
                // the occupied bucket count itself since we set "tombstone"
                // flags, technically the entry is still in the hash table taking up space.
                count -= 1
                break
            } else {
                hashIndex = (hashIndex >= numBuckets - 1) ? 0 : hashIndex + 1
            }
        }
    }
    
    private func rebalanceDictionaryIfApplicable()
    {
        if loadFactor >= 0.7 {
            let originalData = data
            data.removeAll()
            numBuckets *= 2
            occupiedBucketCount = 0
            count = 0
            data = Array<DictionaryNode?>(repeating: nil, count: numBuckets)
            for keyValue in originalData {
                if let item = keyValue {
                    setValueWithoutRebalancing(item.value, for: item.key)
                }
            }
        }
    }
}

public class Contact: Hashable
{
    public var firstName: String
    public var lastName: String
    
    public init(firstName: String, lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
    
    public static func == (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.firstName == rhs.firstName && lhs.lastName == rhs.lastName
    }
    
    /**
     * The calling client would create and instance of hasher, pass it to this
     * method, then call hasher.finalize() to retrieve the final hash code.
     *
     * let contact = Contact("Abhay", "Curam")
     * var hasher = Hasher()
     * contact.hash(&hasher)
     * let hashValue = hasher.finalize()
     */
    public func hash(into hasher: inout Hasher)
    {
        hasher.combine(firstName)
        hasher.combine(lastName)
    }

}

/**
 * MARK - Bunch of Custom Code to actually "test" the Dictionary.
 */
public class CollidableString: Hashable, CustomDebugStringConvertible
{
    public var debugDescription: String {
        return str
    }
    
    public var str: String = ""
    private var forceCollision = false
    public init(_ str: String, forceHashCollision: Bool = true) {
        self.str = str
        forceCollision = forceHashCollision
    }
    
    public func hash(into hasher: inout Hasher)
    {
        if forceCollision {
            hasher.combine(20)
        } else {
            hasher.combine(str)
        }
    }
    
    public static func ==(lhs: CollidableString, rhs: CollidableString) -> Bool {
        return lhs.str == rhs.str
    }
}

/**
 * MARK - Actual Test Plan
 * Test plan via print statement and setting up scenario/conditions.
 * If you actually want to re-run this uncomment the code.
 *
print("Test Case 1:-----Inserting CollidingKeys into Dict---------")
var dictionary = Dictionary<CollidableString, Int>()
let hello = CollidableString("hello")
let world = CollidableString("world")
let baby = CollidableString("baby")
let haha = CollidableString("haha")
dictionary[hello] = 10
dictionary[world] = 20
dictionary[baby] = 30
dictionary[haha] = 40
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 2:------------deleting entries for colliding keys------------")
dictionary[hello] = nil
dictionary[baby] = nil
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 3:------------Updating Value for Existing Colliding Keys------------")
dictionary[world] = 60
print(dictionary[hello])
print(dictionary[world])
print(dictionary[baby])
print(dictionary[haha])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 4:------------Updating Value for Deleted/Tombstoned Colliding Key(s)------------")
dictionary[hello] = 100
dictionary[baby] = 50
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)



print("Test Case 5:------------Inserting Non-colliding Keys into Dict------------")
let foo = CollidableString("foo", forceHashCollision: false)
let bar = CollidableString("bar", forceHashCollision: false)
let atom = CollidableString("atom", forceHashCollision: false)
let plank = CollidableString("plank", forceHashCollision: false)
dictionary[foo] = -10
dictionary[bar] = -20
dictionary[atom] = -30
dictionary[plank] = -40
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Value for key \"foo:\" ", dictionary[foo])
print("Value for key \"bar:\" ", dictionary[bar])
print("Value for key \"atom:\" ", dictionary[atom])
print("Value for key \"plank:\" ", dictionary[plank])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 6:------------Deleting Non-colliding Keys------------")
dictionary[foo] = nil
dictionary[atom] = nil
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Value for key \"foo:\" ", dictionary[foo])
print("Value for key \"bar:\" ", dictionary[bar])
print("Value for key \"atom:\" ", dictionary[atom])
print("Value for key \"plank:\" ", dictionary[plank])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 7:------------Update Value for Non Colliding Existing Key(s)------------")
dictionary[bar] = -60
dictionary[plank] = -100
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Value for key \"foo:\" ", dictionary[foo])
print("Value for key \"bar:\" ", dictionary[bar])
print("Value for key \"atom:\" ", dictionary[atom])
print("Value for key \"plank:\" ", dictionary[plank])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
print("Test Case 8:------------Update Value for Non Colliding Deleted/Tombstone Key(s)------------")
dictionary[foo] = -300
dictionary[atom] = -500
print("Value for key \"hello:\" ", dictionary[hello])
print("Value for key \"world:\" ", dictionary[world])
print("Value for key \"baby:\" ", dictionary[baby])
print("Value for key \"haha:\" ", dictionary[haha])
print("Value for key \"foo:\" ", dictionary[foo])
print("Value for key \"bar:\" ", dictionary[bar])
print("Value for key \"atom:\" ", dictionary[atom])
print("Value for key \"plank:\" ", dictionary[plank])
print("Count: ", dictionary.count)
print("Num Buckets: ", dictionary.numBuckets)
print(dictionary.data)
*/

