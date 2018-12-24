/*
 * Edge.h
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#pragma once

#include "../utils/global.h"
#include "../graph/vertex.h"

class Edge {
private:
	Vertex* start;
	Vertex* end;
	int cost;
	vector<int> resources;

public:
	Edge(Vertex* start, Vertex* end, int cost, const vector<int>& resources);
	int get_cost() const;
	const Vertex* get_start() const;
	const Vertex* get_end() const;
	const vector<int>& get_resources() const;
};
