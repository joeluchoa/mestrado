#include <iostream>
#include <string>
using namespace std;

#include "graph/base_vertex.h"
#include "graph/base_arc.h"
#include "graph/constrained_arc.h"
#include "graph/base_graph.h"
#include "graph/resources.h"
#include "instance/instance.h"
#include "instance/reader.h"

void base_vertex_test() {
    cout << "\n:: BaseVertex test" << endl;
    cout << BaseVertex<string>("String") << endl;
    cout << BaseVertex<int>(1) << endl;
}

void base_arc_test() {
    cout << "\n:: BaseArc test" << endl;
    cout << BaseArc<string>(new BaseVertex<string>("Origin"), 
                            new BaseVertex<string>("Destination")) << endl;
    cout << BaseArc<int>(new BaseVertex<int>(1), 
                         new BaseVertex<int>(2)) << endl;
}

void resources_test() {
    cout << "\n:: Resources test" << endl;
    Resources r(vector<int> (5, 0));
    cout << r << endl;
    vector<int> x, y;
    for (int i = 0; i < 5; ++i) {
        x.push_back(i+1);
        y.push_back(5-i);
    }
    Resources rx(x), ry(y);
    cout << rx << " " << ry << endl;
    r += rx;
    cout << r << endl;
    cout << (r.is_limited_by(rx) ? "Yes" : "No") << endl;
    r += ry;
    cout << r << endl;
    cout << (r.is_limited_by(rx) ? "Yes" : "No") << endl;
}

void constrained_arc_test() {
    cout << "\n:: ConstrainedArc test" << endl;
    vector<int> resources;
    for (int i = 0; i < 5; ++i) {
        resources.push_back(i + 1);
    }
    cout << ConstrainedArc<string, double>(new BaseVertex<string>("Origin"), 
                                           new BaseVertex<string>("Destination"),
                                           1.234,
                                           resources) << endl;
    cout << ConstrainedArc<int, int>(new BaseVertex<int>(1), 
                                     new BaseVertex<int>(2),
                                     1234,
                                     resources) << endl;
    BaseArc<int> *arc = new ConstrainedArc<int,int>(new BaseVertex<int>(1),
                                                    new BaseVertex<int>(2),
                                                    1234,
                                                    resources);
    cout << *((ConstrainedArc<int,int>*)arc) << endl;
}

void base_graph_test() {
    cout << "\n:: BaseGraph test" << endl;
    BaseVertex<string> a("A"), b("B"), c("C");
    ConstrainedArc<string, double> x(&a, &b, 1.234, vector<int>(1,5));
    ConstrainedArc<string, double> y(&c, &b, 0.789, vector<int>(1,6));
    BaseGraph<string> graph;
    graph.add_vertex(&a);
    graph.add_vertex(&b);
    graph.add_vertex(&c);
    graph.add_arc(&x);
    graph.add_arc(&y);
    cout << (graph.get_vertex("D") != NULL ? "ERROR" : "OK") << endl;
    cout << *graph.get_vertex("B") << endl;
    cout << (graph.get_arc("B", "C") != NULL ? "ERROR" : "OK") << endl;
    cout << *graph.get_arc("C", "B") << endl;
    cout << *((ConstrainedArc<string, double>*)graph.get_arc("C", "B")) << endl;
    cout << graph << endl;
}


void instance_test() {
    cout << "\n:: Instance test" << endl;
    Instance<string,double> i;
    i.graph = new BaseGraph<string>();
    i.resources_available = new Resources(vector<int> (3, 0));
    i.graph->add_vertex(new BaseVertex<string>("A"));
    i.graph->add_vertex(new BaseVertex<string>("B"));
    i.graph->add_arc( new ConstrainedArc<string,double>(
                    i.graph->get_vertex("A"),
                    i.graph->get_vertex("B"),
                    0.123,
                    vector<int>()));
    i.source = i.graph->get_vertex("A");
    i.target = i.graph->get_vertex("B");
    cout << i << endl;
}

void reader_test() {
    cout << "\n:: Reader test" << endl;
    const Instance<string, double>* inst = 
        Reader<string, double>::read("tests/test_2_1.sample");
    cout << *inst << endl;
}

int main() {
    cout << "\n== Tests ===============================================" << endl;
    base_vertex_test();
    base_arc_test();
    resources_test();
    constrained_arc_test();
    base_graph_test();
    instance_test();
    reader_test();
    return 0;
}
