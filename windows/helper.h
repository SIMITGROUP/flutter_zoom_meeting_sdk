#pragma once

#include <string>
#include <iostream>

inline const void sLog(const std::string tag, const std::wstring message)
{
    std::wcout << L"FlutterZoomMeetingSDK::" << std::wstring(tag.begin(), tag.end()) << " " << message << std::endl;
}

inline const void sLog(const std::string tag, const std::string message)
{
    std::cout << "FlutterZoomMeetingSDK::" << tag << " " << message << std::endl;
}

inline std::string WStringToString(const std::wstring &wstr)
{
    // int size_needed = WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), (int)wstr.size(), NULL, 0, NULL, NULL);
    // std::string str(size_needed, 0);
    // WideCharToMultiByte(CP_UTF8, 0, wstr.c_str(), (int)wstr.size(), &str[0], size_needed, NULL, NULL);
    return "";
}