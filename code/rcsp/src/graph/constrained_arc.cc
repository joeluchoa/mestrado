/**
 * @file constrained_arc.cc
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


#ifdef CONSTRAINED_ARC_H

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/

template<class T, class U>
ConstrainedArc<T, U>::ConstrainedArc (BaseVertex<T>* origin, 
                                      BaseVertex<T>* destination,
                                      U cost, const vector<int>& resources) : 
  BaseArc<T> (origin, destination), cost (cost), resources (resources)
{ }

template<class T, class U> U
ConstrainedArc<T, U>::get_cost () 
{ 
  return cost; 
}

template<class T, class U> const Resources& 
ConstrainedArc<T, U>::get_resources () 
{ 
  return resources; 
}

template<class T, class U> ostream& 
operator<< (ostream& out, const ConstrainedArc<T,U>& a) 
{
  out << "(" << *a.origin << "->" << *a.destination << "; c=" << a.cost
   << "; r=" << a.resources << ")";
  return out;
}


#else /* !defined CONSTRAINED_ARC_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "constrained_arc.h"


#endif /* CONSTRAINED_ARC_H */
