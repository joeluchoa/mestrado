/**
 * @file resources.cc
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


#ifdef RESOURCES_H

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/


#else /* !defined RESOURCES_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "resources.h"

Resources::Resources (const vector<int>& resources) : resources (resources) 
{ }

int
Resources::get_number_of_resources () const
{ 
  return resources.size (); 
}

int
Resources::operator() (int i) const 
{
  if (i >= (int)resources.size ())
    return 0;
  return resources[i];
}

Resources&
Resources::operator+= (const Resources& other) 
{
  for (int i = 0; i < other.get_number_of_resources (); ++i) 
    {
      if ((int)resources.size() <= i)
        resources.push_back(0);
      resources[i] += other (i);
    }
  return *this;
}

bool
Resources::is_limited_by (const Resources& other) const 
{
  for (int i = 0; i < (int)resources.size(); ++i) 
    {
      if (resources[i] > other (i)) 
        return false;
    }
  return true;
}

ostream& 
operator<< (ostream& out, const Resources& r) 
{
  out << "[";
  for (int i = 0; i < (int)r.get_number_of_resources (); ++i) 
    { 
      if (i > 0) 
        out << ",";
      out << r (i);
    }
  out << "]";
  return out;
}


#endif /* RESOURCES_H */
