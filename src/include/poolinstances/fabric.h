#pragma once

#include "poolcore/poolCore.h"
#include "poolcore/poolInstance.h"
#include "rapidjson/document.h"
#include <functional>
#include <unordered_map>

class PoolInstanceFabric {
public:
  static CPoolInstance *get(asyncBase *base, const std::string &type, const std::string &protocol, rapidjson::Value &config);

private:
  using NewPoolInstanceFunction = std::function<CPoolInstance*(asyncBase*, rapidjson::Value&)>;

private:
  static std::unordered_map<std::string, NewPoolInstanceFunction> FabricData_;
};
