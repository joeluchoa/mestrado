/*
 * Graph.h
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#pragma once

#include "../utils/global.h"

#include "vertex.h"
#include "edge.h"

class Graph {
    vector<Vertex> vertexes;
    vector<Edge> edges;

    map<int, Vertex*> map_vertexes_id;

    map<const Vertex*, vector<const Edge*> > adj_in;
    map<const Vertex*, vector<const Edge*> > adj_out;
    map<const Vertex*, map<const Vertex*, const Edge*> > matrix;

public:

    Graph();

    void clear();

    void add_vertex(const Vertex& v);
    void add_vertex(int id, int cost, const vector<int>& resources);
    const Vertex* get_vertex(int id);

    void add_edge(const Edge& e);
    void add_edge(int start_id, int end_id, int cost, 
                  const vector<int>& resources);
};
