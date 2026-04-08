//
//  main.cpp
//  C++LanguageFundamentals
//
//  Created by Abhay Curam on 5/1/25.
//

#include <iostream>

/*void passByPointer(int* x)
{
    std::cout << "x ptr: " << x << std::endl;
    std::cout << "x ptr value: " <<  *x << std::endl;
    *x = 4;
    std::cout << "x ptr: " << x << std::endl;
    std::cout << "x ptr value: " <<  *x << std::endl;
    int y = 10;
    x = &y;
    std::cout << "x ptr value: " <<  x << std::endl;
}*/

/*void passByConstPointerToConst (const int* const x)
{
    std::cout << "x ptr: " << x << std::endl;
    std::cout << "x ptr value: " <<  *x << std::endl;
    *x = 4;
    std::cout << "x ptr: " << x << std::endl;
    std::cout << "x ptr value: " <<  *x << std::endl;
    int g = 7;
    x = &g;
}*/

/*void passByConstReference(const int& x)
{
    std::cout << "x: " << x << std::endl;
    x = 100;
    std::cout << "x: " << x << std::endl;
}*/


int main(int argc, const char * argv[]) {
    // insert code here...
    
    typedef int* ip;
    ip x, y;
    std::cout << "hello words" << std::endl;
    return 0;
    
    /*int y = 3;
    std::cout << "y: " << y << std::endl;
    passByConstReference(y);
    std::cout << "y: " << y << std::endl;*/
}
