/*
 * global.cpp
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#include "global.h"


//=========================================================================
// Class: Config 

Config* Config::singleton;

Config::Config () 
{
  verbose_mode = true;
  debug_mode = true;
}

bool Config::get_verbose_mode ()
{
  return verbose_mode;
}

bool Config::get_debug_mode ()
{
  return debug_mode;
}

Config* Config::instance ()
{
  if (!singleton)
    {
      singleton = new Config ();
    }
  return singleton;
}



//=========================================================================
// Class: CalcTime

CalcTime::CalcTime (const string &message) 
{
  start = clock ();
  msg   = message;
}

CalcTime::~CalcTime () 
{
  clock_t total  = clock () - start;
  double seconds = (double) total / CLOCKS_PER_SEC;
  log << msg << " time: " << seconds << "s" << endl;
}
