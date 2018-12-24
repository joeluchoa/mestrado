/**
 * @file base_arc.cc
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



#ifdef BASE_ARC_H 

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/


/**
 * @brief 
 *
 * @tparam T
 * @param origin
 * @param destination
 */
template<class T>
BaseArc<T>::BaseArc (BaseVertex<T>* origin, BaseVertex<T>* destination) : 
  origin (origin), destination (destination)
{ }

template<class T> BaseVertex<T>* 
BaseArc<T>::get_origin ()
{ 
  return origin; 
}

template<class T> BaseVertex<T>* 
BaseArc<T>::get_destination () 
{ 
  return destination; 
}

template<class T> ostream& 
operator<< (ostream& out, const BaseArc<T>& a) 
{
  out << "(" << *a.origin << "," << *a.destination << ")";
  return out;
}


#else /* !defined BASE_ARC_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "base_arc.h"


#endif /* BASE_ARC_H */
