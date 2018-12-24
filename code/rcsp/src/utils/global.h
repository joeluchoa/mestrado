/*
 * global.h
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#pragma once

//=========================================================================
// INCLUDES

#include <cstdio>
#include <cstring>
#include <cstdlib>

#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>
#include <queue>
#include <sstream>

using namespace std;

//=========================================================================
// VARIABLES and CONSTANTES

class Config {
  private:
    bool verbose_mode;
    bool debug_mode;
    static Config* singleton;
    Config();
  public:
    bool get_verbose_mode();
    bool get_debug_mode();
    static Config* instance();
};

//=========================================================================
// DEFINES

#define CFG Config::instance()
#define foreach(i, x) for(__typeof(x.end()) i=x.begin();i!=x.end();++i)
#define log if (CFG->get_verbose_mode()) cout << "[LOG] "
#define debug if (CFG->get_debug_mode()) cerr << "[DEBUG] "
#define watch(x) debug << #x" = " << x

//=========================================================================
// CLASSES

class CalcTime {
  private:
    string msg;
    clock_t start;

  public:
    CalcTime(const string &message);
    ~CalcTime();
};
