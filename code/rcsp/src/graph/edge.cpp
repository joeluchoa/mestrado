/*
 * Edge.cpp
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#include "edge.h"

Edge::Edge(Vertex *start, Vertex *end, int cost, const vector<int>& resources) {
	this->start = start;
	this->end = end;
	this->cost = cost;
	this->resources = resources;
}

int Edge::get_cost() const { return this->cost; }
const Vertex* Edge::get_start() const { return this->start; }
const Vertex* Edge::get_end() const { return this->end; }
const vector<int>& Edge::get_resources() const { return this->resources; }
