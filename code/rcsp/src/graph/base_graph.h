/**
 * @file base_graph.h
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
#ifndef BASE_GRAPH_H
#define BASE_GRAPH_H


#include <vector>
#include <map>
using namespace std;

#include "base_vertex.h"
#include "base_arc.h"

template<class VertexLabelType>
class BaseGraph 
{
  protected:
    vector<BaseVertex<VertexLabelType>*>               verteces;
    map<VertexLabelType, BaseVertex<VertexLabelType>*> map_label_to_vertex;

    vector<BaseArc<VertexLabelType>*> arcs;

    map<BaseVertex<VertexLabelType>*, 
      map<BaseVertex<VertexLabelType>*, BaseArc<VertexLabelType>*> > matrix;

  public:
    void add_vertex (BaseVertex<VertexLabelType>* v);

    BaseVertex<VertexLabelType>* get_vertex (const VertexLabelType& label); 

    void add_arc (BaseArc<VertexLabelType>* a);

    BaseArc<VertexLabelType>* get_arc (BaseVertex<VertexLabelType>* origin, 
                                       BaseVertex<VertexLabelType>* destination); 

    BaseArc<VertexLabelType>* get_arc (const VertexLabelType& origin_label, 
                                       const VertexLabelType& destination_label);

    int get_number_of_verteces () const;

    int get_number_of_arcs () const; 

    const vector<BaseVertex<VertexLabelType>*>& get_verteces(); 

    const vector<BaseArc<VertexLabelType>*>& get_arcs (); 

    template<class T> friend ostream& operator<< (ostream& out, 
                                                  const BaseGraph<T>& g); 
};


#include "base_graph.cc"
#endif /* BASE_GRAPH_H */
