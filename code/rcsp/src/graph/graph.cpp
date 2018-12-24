/*
 * Graph.cpp
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#include "graph.h"

Graph::Graph() { this->clear(); }

void Graph::clear() {
	vertexes.clear();
	map_vertexes_id.clear();
	edges.clear();
	adj_in.clear();
	adj_out.clear();
    matrix.clear();
}

void Graph::add_vertex(const Vertex& v) {
	vertexes.push_back(v);
    map_vertexes_id[v.get_id()] = &vertexes.back();
}

void Graph::add_edge(const Edge& e) {
	edges.push_back(e);
	adj_in[e.get_end()].push_back(&edges.back());
	adj_out[e.get_start()].push_back(&edges.back());
    matrix[e.get_start()][e.get_end()] = &edges.back();
}

void Graph::add_edge(int start_id, int end_id, int cost=0, 
                     const vector<int>& resources=vector<int>()) {
    Vertex* start = map_vertexes_id[start_id];
    Vertex* end = map_vertexes_id[end_id];
    add_edge(Edge(start, end, cost, resources));
}

void Graph::add_vertex(int id, int cost=0, 
                       const vector<int>& resources=vector<int>()) {
    add_vertex(Vertex(id, cost, resources));
}

