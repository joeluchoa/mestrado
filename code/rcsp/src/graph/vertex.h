/*
 * Vertex.h
 *
 *  Created on: 11/11/2010
 *      Author: Joel Silva Uchoa
 */

#pragma once

#include "../utils/global.h"

class Vertex {
	int id;
	int cost;
	vector<int> resources;

public:
	Vertex(int id, int cost, const vector<int>& resources);
	int get_cost() const;
	int get_id() const;
	const vector<int>& get_resources() const;
};

ostream& operator <<(ostream& o, const Vertex& v);
