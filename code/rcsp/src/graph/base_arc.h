/**
 * @file base_arc.h
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
#ifndef BASE_ARC_H
#define BASE_ARC_H


#include <ostream>
using namespace std;

#include "base_vertex.h"

template<class VertexLabelType>
class BaseArc 
{
  protected:
    BaseVertex<VertexLabelType>* origin;
    BaseVertex<VertexLabelType>* destination;

  public:
    BaseArc (BaseVertex<VertexLabelType>* origin, 
             BaseVertex<VertexLabelType>* destination);

    BaseVertex<VertexLabelType>* get_origin ();

    BaseVertex<VertexLabelType>* get_destination ();

    template<class T> friend ostream& operator<< (ostream& out, 
                                                  const BaseArc<T>& a);
};


#include "base_arc.cc"
#endif /* BASE_ARC_H */
