/**
 * @file reader.h
 * @brief 
 * @author Joel Silva Uchoa <joeluchoa@gmail.com>
 * @version 0.1
 * @date 2011-04-25
 *
 * @section LICENSE
 *
 * Copyright (C) 
 * 2011 - Joel Silva Uchoa
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
 * 
 */


#pragma once
#ifndef READER_H
#define READER_H


#include <fstream>
#include <iostream>
#include <sstream>
using namespace std;

#include "instance.h"

template<class T, class U>
class Reader 
{
  private:
    Reader();

    static void clean_str (string& line); 

    static void readline (ifstream& input, istringstream&  iss, string& line); 

  public:
    static const Instance<T,U>* read (const char* filename); 
};


#include "reader.cc"
#endif /* READER_H */
