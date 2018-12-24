/**
 * @file instance.h
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
#ifndef INSTANCE_H
#define INSTANCE_H


#include "../graph/constrained_arc.h"
#include "../graph/base_graph.h"
#include "../graph/resources.h"

template<class VertexLabelType, class ArcCostType>
class Instance 
{
  public:
    BaseGraph<VertexLabelType>*  graph;
    Resources*                   resources_available;
    BaseVertex<VertexLabelType>* source;
    BaseVertex<VertexLabelType>* target;

    template<class T, class U> 
      friend ostream& operator<< (ostream& out, const Instance<T,U>& i);

    friend class BaseGenerator;
};


#include "instance.cc"
#endif /* INSTANCE_H */
