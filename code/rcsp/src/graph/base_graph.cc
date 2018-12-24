/**
 * @file base_graph.cc
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


#ifdef BASE_GRAPH_H

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/

template<class T> void
BaseGraph<T>::add_vertex (BaseVertex<T>* v) 
{
  map_label_to_vertex[v->get_label ()] = v;
  verteces.push_back (v);
}

template<class T> BaseVertex<T>* 
BaseGraph<T>::get_vertex (const T& label) 
{ 
  __typeof (map_label_to_vertex.end ()) it = map_label_to_vertex.find (label);
  if (it == map_label_to_vertex.end ())
    return NULL;
  return it->second; 
}

template<class T> void
BaseGraph<T>::add_arc (BaseArc<T>* a) 
{
  matrix[a->get_origin ()][a->get_destination ()] = a;
  arcs.push_back (a);
}

template<class T> BaseArc<T>*
BaseGraph<T>::get_arc (BaseVertex<T>* origin, 
                       BaseVertex<T>* destination) 
{
  if (origin == NULL || destination == NULL)
    return NULL;

  __typeof (matrix.end ()) it1 = matrix.find (origin);
  if (it1 == matrix.end ())
    return NULL;

  __typeof (it1->second.end ()) it2 = it1->second.find (destination);
  if (it2 == it1->second.end ())
    return NULL;

  return it2->second;
}

template<class T> BaseArc<T>* 
BaseGraph<T>::get_arc (const T& origin_label, const T& destination_label) 
{
  BaseVertex<T>* origin = get_vertex (origin_label);
  BaseVertex<T>* destination = get_vertex (destination_label);
  return get_arc (origin, destination);
}

template<class T> int 
BaseGraph<T>::get_number_of_verteces () const 
{ 
  return verteces.size (); 
}

template<class T> int
BaseGraph<T>::get_number_of_arcs () const 
{ 
  return arcs.size (); 
}

template<class T> const vector<BaseVertex<T>*>& 
BaseGraph<T>::get_verteces() 
{ 
  return verteces; 
}

template<class T> const vector<BaseArc<T>*>&
BaseGraph<T>::get_arcs () 
{ 
  return arcs; 
}

template<class T> ostream& 
operator<< (ostream& out, const BaseGraph<T>& g) 
{
  out << "G[n=" << g.get_number_of_verteces ()
   << "; m=" << g.get_number_of_arcs () << "; V={";

  for (__typeof (g.verteces.end ()) it = g.verteces.begin ();
       it != g.verteces.end (); ++it) 
    {
      if (it != g.verteces.begin ()) 
        out << ",";
      out << *(*it);
    }

  out << "}; A={";

  for (__typeof (g.arcs.end ()) it = g.arcs.begin ();
       it != g.arcs.end (); ++it) {
    if (it != g.arcs.begin ()) 
      out << ",";
    out << *(*it);
  }

  out << "}]" << endl;

  return out;
}


#else /* !defined BASE_GRAPH_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "base_graph.h"


#endif /* BASE_GRAPH_H */

