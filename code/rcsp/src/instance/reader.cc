/**
 * @file reader.cc
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


#ifdef READER_H

/*==========================================================================*/
/*== Implementations WITH template or inline modifier ======================*/
/*==========================================================================*/

template<class T, class U>
Reader<T, U>::Reader()
{ }

template<class T, class U> void 
Reader<T, U>::clean_str (string& line) 
{
  for (int pos = 0; 
       (pos = line.find_first_of ("{}()[]->=,;")) != string::npos; ++pos) 
    {
      line[pos] = ' ';
    }
}

template<class T, class U> void 
Reader<T, U>::readline (ifstream& input, istringstream&  iss, string& line) 
{
  getline (input, line);
  clean_str (line);
  iss.clear ();
  iss.str (line);
}

template<class T, class U> const Instance<T,U>*
Reader<T, U>::read (const char* filename) 
{
  ifstream input;
  istringstream iss;
  string trash, line;

  input.open (filename, ifstream::in);
  if (not input.good ())
    return NULL;

  Instance<T,U>* instance = new Instance<T,U> ();
  instance->graph = new BaseGraph<T> ();

  // first line n,m,k
  int n, m, k;
  readline (input, iss, line);
  iss >> trash >> n >> trash >> m >> trash >> k;

  readline (input, iss, trash);

  // verteces label
  for (int i = 0; i < n; ++i) 
    {
      T label;
      readline (input, iss, line);
      iss >> label;
      instance->graph->add_vertex (new BaseVertex<T> (label));
    }

  readline (input, iss, trash);
  readline (input, iss, trash);

  // arcs datas
  for (int i = 0; i < m; ++i) 
    {
      readline (input, iss, line);

      T label_origin, label_destination;
      iss >> label_origin >> label_destination;

      U cost;
      iss >> trash >> cost;

      iss >> trash;
      vector<int> resources;
      for (int j = 0; j < k; ++j) 
        {
          int r;
          iss >> r;
          resources.push_back(r);
        }

      instance->graph->add_arc (new ConstrainedArc<T,U> (
                                                         instance->graph->get_vertex (label_origin),
                                                         instance->graph->get_vertex (label_destination),
                                                         cost, resources));
    }

  readline (input, iss, trash);

  // limits 
  readline (input, iss, line);
  iss >> trash;
  vector<int> limits;
  for (int i = 0; i < k; ++i) 
    {
      int r;
      iss >> r;
      limits.push_back (r);
    }
  instance->resources_available = new Resources (limits);

  // source and target
  T label_source, label_target;
  readline (input, iss, line);
  iss >> trash >> label_source >> trash >> label_target;
  instance->source = instance->graph->get_vertex (label_source);
  instance->target = instance->graph->get_vertex (label_target);

  return instance;
}

#else /* !defined READER_H */

/*==========================================================================*/
/*== Implementations WITHOUT template or inline modifier ===================*/
/*==========================================================================*/

#include "reader.h"


#endif /* READER_H */
