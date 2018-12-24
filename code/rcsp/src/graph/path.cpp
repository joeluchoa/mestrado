/*
 * path.cpp
 *
 *  Created on: 11/02/2011
 *      Author: Joel Silva Uchoa
 */

#include "src/graph/path.h"

Path::Path(const Graph* graph, const vector<Vertex*>& vertexes) {
    vector<Vertex*>::iterator last = vertexes.begin();
    this.cost = 0;
    this.resource = 0;
    this.graph = graph;
    this.vertexes = vertexes;
    foreach (vector<Vertex*>::iterator current = vertexes.begin;
             current != vertexes.end(); ++curent) {
        if (current != vertexes.begin()) {
            this.cost += graph.get_edge(*last, *current).get_cost();
            this.resource += graph.get_edge(*last, *current).get_resource();
        }
        last = current;
    }
}

int Path::get_cost() { return this.cost; }
int Path::get_resource() { return this.resource; }
const vector<Vertex*>& get_vertexes() { return this.vertexes; }

int Path::get_size_common_prefix(const Path& other) {
    for (int i=0; i<vertexes.size() && i<other.get_vertexes().size(); ++i) {
        if (vertexes[i] != other.get_vertexes()[i]) {
            return i;
        }
    }
    return 0;
}

Path Path::get_sub_path(int start_idx=0, int end_idx) {
    vector<Vertex*> v;
    for (int i = start_idx; i < end_idx; ++i) {
        v.push_back(this->vertexes[i]);
    }
    return Path(this->graph, v);
}
