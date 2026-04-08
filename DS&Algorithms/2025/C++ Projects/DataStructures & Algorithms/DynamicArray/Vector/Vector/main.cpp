//
//  main.cpp
//  Vector
//
//  Created by Abhay Curam on 5/12/25.
//

#include <iostream>
#include "Vector.hpp"

struct DummyStruct {
    std::string foo;
};

int main(int argc, const char * argv[]) {
    // insert code here...
    
    /*
     * Vector push/pop back tests and subscript tests
     */
    Vector<int> vec;
    vec.push_back(1);
    vec.push_back(2);
    vec.push_back(3);
    vec.push_back(4);
    vec.push_back(5);
    vec.push_back(6);
    vec.push_back(7);
    vec.push_back(8);
    vec.push_back(9);
    std::cout << "Vector capacity: " << vec.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec.getSize(); i++) { std::cout << vec[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "Overwriting the vector" << std::endl;
    for (int i = 0; i < vec.getSize(); i++) { vec[i] += 10; }
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec.getSize(); i++) { std::cout << vec[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "Now removing 4 elements via pop back" << std::endl;
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    std::cout << "Vector capacity: " << vec.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec.getSize(); i++) { std::cout << vec[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "Now removing 6 elements via pop back" << std::endl;
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    vec.pop_back();
    std::cout << "Vector capacity: " << vec.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec.getSize(); i++) { std::cout << vec[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    
    /*
     * Vector insertion and removal tests
     */
    std::cout << "Vector insertion and removal tests" << std::endl;
    Vector<int> vec2;
    vec2.insertAt(0, 1);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    vec2.removeAt(0);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    
    std::cout << "Repeatedly inserting elements at the beginning" << std::endl;
    vec2.insertAt(0, 1);
    vec2.insertAt(1, 2);
    vec2.insertAt(2, 3);
    vec2.insertAt(3, 5);
    vec2.insertAt(4, 6);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << "inserting element in the middle" << std::endl;
    vec2.insertAt(3, 4);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << "inserting elements at the end" << std::endl;
    vec2.insertAt(vec2.getSize(), 7);
    vec2.insertAt(vec2.getSize(), 8);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    std::cout << "Repeatedly removing elements from the beginning" << std::endl;
    vec2.removeAt(0);
    vec2.removeAt(0);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << "Repeatedly removing elements from the middle" << std::endl;
    vec2.removeAt(2);
    vec2.removeAt(2);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << "Repeatedly removing elements from the end" << std::endl;
    vec2.removeAt(vec2.getSize() - 1);
    vec2.removeAt(vec2.getSize() - 1);
    vec2.removeAt(vec2.getSize() - 1);
    vec2.removeAt(vec2.getSize() - 1);
    std::cout << "Vector capacity: " << vec2.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec2.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec2.getSize(); i++) { std::cout << vec2[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    
    std::cout << "Testing copy constructor" << std::endl;
    vec2.push_back(10);
    vec2.push_back(20);
    vec2.push_back(30);
    vec2.push_back(40);
    Vector<int> vec3 = Vector<int>(vec2);
    std::cout << "Vector capacity: " << vec3.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec3.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec3.getSize(); i++) { std::cout << vec3[i] << " "; }
    std::cout << std::endl;
    std::cout << "Testing copy on assignment:" << std::endl;
    Vector<int> vec4;
    vec4 = vec3;
    std::cout << "Vector capacity: " << vec4.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec4.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec4.getSize(); i++) { std::cout << vec4[i] << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    
    Vector<DummyStruct> vec5;
    vec5.push_back(DummyStruct("hello"));
    vec5.push_back(DummyStruct("world"));
    vec5.push_back(DummyStruct("pat"));
    std::cout << "Vector capacity: " << vec5.getCapacity() << std::endl;
    std::cout << "Vector size: " << vec5.getSize() << std::endl;
    std::cout << "Vector elements: ";
    for (int i = 0; i < vec5.getSize(); i++) { std::cout << vec5[i].foo << " "; }
    std::cout << std::endl;
    std::cout << std::endl;
    
    return 0;
}
