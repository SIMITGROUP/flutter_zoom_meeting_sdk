#pragma once

#include <flutter/method_call.h>
#include <flutter/standard_method_codec.h>
#include <optional>
#include <string>

class ArgReader
{
public:
    explicit ArgReader(const flutter::MethodCall<flutter::EncodableValue> &call)
        : args_(std::get_if<flutter::EncodableMap>(call.arguments())) {}

    std::optional<std::string> GetString(const std::string &key) const
    {
        return Get<std::string>(key);
    }

    std::optional<int64_t> GetInt(const std::string &key) const
    {
        return Get<int64_t>(key);
    }

    std::optional<bool> GetBool(const std::string &key) const
    {
        return Get<bool>(key);
    }

private:
    const flutter::EncodableMap *args_;

    template <typename T>
    std::optional<T> Get(const std::string &key) const
    {
        if (!args_)
            return std::nullopt;
        auto it = args_->find(flutter::EncodableValue(key));
        if (it != args_->end())
        {
            if (auto val = std::get_if<T>(&(it->second)))
            {
                return *val;
            }
        }
        return std::nullopt;
    }
};
