/**
 * @file instance.cc
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


#ifdef INSTANCE_H

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/

template<class T, class U> ostream& 
operator<< (ostream& out, const Instance<T,U>& i) 
{
  out << "n=" << i.graph->get_number_of_verteces () << "; "
   << "m=" << i.graph->get_number_of_arcs () << "; "
   << "k=" << i.resources_available->get_number_of_resources () << ";"
   << endl;

  out << "V={" << endl;

  const vector<BaseVertex<T>*>& V = i.graph->get_verteces ();
  for (__typeof (V.end ()) it = V.begin (); it != V.end (); ++it) 
    {
      out << "  " << *(*it) << endl;
    }
  out << "};" << endl;

  out << "A={" << endl;
  const vector<BaseArc<T>*>& A = i.graph->get_arcs ();
  for (__typeof (A.end ()) it = A.begin (); it != A.end (); ++it) 
    {
      out << "  " << *((ConstrainedArc<T,U>*)*it) << endl;
    }
  out << "};" << endl;

  out << "l=" << *i.resources_available << ";" << endl;
  out << "s=" << *i.source <<  "; t=" << *i.target << ";" << endl;

  return out;
}


#else /* !defined INSTANCE_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "instance.h"


#endif /* INSTANCE_H */
