/*
 * path.h
 *
 *  Created on: 11/02/2011
 *      Author: Joel Silva Uchoa
 */

#pragma once

#include "src/graph/graph.h"

class Path {
    int cost;
    int resource;
    Graph* graph;
    vector<Vertex*> vertexes;

public:

    Path(const Graph* graph, const vector<Vertex*>& vertexes);

    int get_cost();
    int get_resorce();
    const vector<Vertex*>& get_vertexes();
    int get_size_common_prefix(const Path& other);
    Path get_sub_path(int start_idx, int end_idx);
};
