//
//  NormalizePaths.cpp
//  LeetCodeProblems
//
//  Created by Abhay Curam on 5/8/25.
//

#include <string>
#include <iostream>
#include <sstream>
#include <vector>

/**
 * This is practice problem 8.4 from Elements of Programming Interviews
 */

/**
 * Example of splitting a string on a delimiter token, in this case it splits
 * the string on '/' if this is a path string.
 *
 * string "///Abhay/../Ajay/temp/../Passwallet" becomes:
 * ['Abhay', '..', 'Ajay', 'temp', '..' 'Passwallet']
 */
std::vector<std::string> splitPathIntoComponents(const std::string& pathStr)
{
    std::vector<std::string> tokens;
    std::stringstream ss(pathStr);
    std::string token;
    while (std::getline(ss, token, '/')) {
        if (!token.empty()) {
            tokens.push_back(token);
        }
    }
    return tokens;
}

std::string shortestNormalizedPath(const std::string& pathStr)
{
    if (pathStr.empty()) { return ""; }
    const bool isRootPath = (pathStr[0] == '/') ? true : false;
    std::vector<std::string> pathComponents = splitPathIntoComponents(pathStr);
    std::string basePath, pathPrefix;
    if (!isRootPath) {
        int i = 0;
        while (pathComponents[i] == "." && i < pathComponents.size()) { i++; }
        if (pathComponents[i] == "..") {
            pathPrefix = "../";
            basePath = "";
        } else {
            pathPrefix = "";
            basePath = pathComponents[i];
        }
    } else {
        pathPrefix = "/";
        basePath = "";
    }
    
    std::stack<std::string> pathStack;
    for (int i = 0; i < pathComponents.size(); i++) {
        std::string component = pathComponents[i];
        if (component == ".") {
            continue;
        } else if (component == "..") {
            if (!pathStack.empty()) { pathStack.pop(); }
        } else {
            pathStack.push(component);
        }
    }
    
    bool basePathEncountered = false;
    std::string shortestPathStr = "";
    int pathCount = 0;
    while (!pathStack.empty() && !basePathEncountered) {
        std::string pathComponent = pathStack.top();
        pathStack.pop();
        if (pathComponent == basePath) { basePathEncountered = true; }
        if (pathCount > 0) { pathComponent += "/"; }
        shortestPathStr.insert(0, pathComponent);
        pathCount++;
    }
    
    shortestPathStr.insert(0, pathPrefix);
    return shortestPathStr;
}



