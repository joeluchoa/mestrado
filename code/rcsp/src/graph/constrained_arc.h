/**
 * @file constrained_arc.h
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
#ifndef CONSTRAINED_ARC_H
#define CONSTRAINED_ARC_H


#include <ostream>
#include <vector>
using namespace std;

#include "resources.h"
#include "base_vertex.h"
#include "base_arc.h"

template<class VertexLabelType, class ArcCostType>
class ConstrainedArc : public BaseArc<VertexLabelType> 
{
  private:
    ArcCostType cost;
    Resources resources;

  public:
    ConstrainedArc (BaseVertex<VertexLabelType>* origin, 
                    BaseVertex<VertexLabelType>* destination,
                    ArcCostType cost, const vector<int>& resources);

    ArcCostType get_cost (); 

    const Resources& get_resources (); 

    template<class T, class U> 
      friend ostream& operator<< (ostream& out, const ConstrainedArc<T,U>& a); 
};


#include "constrained_arc.cc"
#endif /* CONSTRAINED_ARC_H */
