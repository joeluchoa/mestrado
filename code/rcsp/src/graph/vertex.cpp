/*
 * Vertex.cpp
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#include "vertex.h"

Vertex::Vertex(int id, int cost=0, 
               const vector<int>& resources=vector<int>()) {
    this->id = id;
    this->cost = cost;
    this->resources = resources;
}

int Vertex::get_cost() const { return this->cost; }
int Vertex::get_id() const { return this->id; }
const vector<int>& Vertex::get_resources() const { return this->resources; }
ostream& operator<<(ostream& o, const Vertex& v) { 
    return o << v.get_id(); 
}
