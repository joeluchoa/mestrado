package kim;

import edu.uci.ics.jung.algorithms.shortestpaths.DeviationArcsMap;
import graph.Graph;
import graph.Leaf;
import graph.OLDPath;
import graph.PathMapByCost;
import graph.Tree;
import graph.UndirectedArc;

import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.Set;
import java.util.TreeSet;

public final class Kim {

	/**
	 * Calcula os k melhores caminhos partindo desNode e chegando em tNode.
	 * 
	 * @param graph
	 * @param sNode_id
	 * @param tNode_id
	 * @param k
	 * @return um vetor com os k melhores caminhos calculados
	 */
	public static final OLDPath[] k_Shortest_Paths(Graph graph, Integer sNode_id,
			Integer tNode_id, int kLim) {
		int k = 1, gama, delta;
		TreeSet[] W = new TreeSet[kLim];
		DeviationArcsMap[] B = new DeviationArcsMap[kLim];
		PathMapByCost P = new PathMapByCost();
		OLDPath[] bestPaths = new OLDPath[kLim];
		OLDPath p1 = graph.Shortest_Path(sNode_id, tNode_id);
		if (p1 == null)
			return bestPaths;
		p1.setDevNode(-1);
		p1.setParent(0);
		W[0] = new TreeSet();
		W[0].add(new Integer(0));
		W[0].add(new Integer(p1.getNodesCount() - 1));
		bestPaths[0] = p1;
		if (kLim == 1)
			return bestPaths;
		// System.out.println("1st " + p1);
		OLDPath p2 = FSP(graph, sNode_id, tNode_id, p1, p1);
		if (p2 == null)
			return bestPaths;
		p2.ComputeDeviation(p1);
		p2.setParent(0);
		P.put(p2);
		B[0] = new DeviationArcsMap();
		// System.out.println(B[0]);
		while (!P.isEmpty()) {
			OLDPath pk = P.removeFirst();
			// System.out.println(P);
			OLDPath pj = bestPaths[pk.getParent()];
			bestPaths[k] = pk;
			// System.out.println(k + "� " + pk);
			// System.out.flush();
			// System.out.println("Paths with cost=" + pk.getCost() + " : "
			// + P.getCountByCost(pk.getCost()));
			/* <Otimizacao Teste> */
			if (P.getCountByCost(pk.getCost()) + k + 1 >= kLim) {
				int lim = kLim - k - 1;
				for (int i = 0; i < lim; i++)
					bestPaths[++k] = P.removeFirst();
				break;
			}
			/* </Otimizacao Teste> */
			if (k + 1 == kLim)
				break;
			W[k] = new TreeSet();
			W[k].add(new Integer(pk.getDevNode() + 1));
			W[k].add(new Integer(pk.getNodesCount() - 1));
			B[k] = new DeviationArcsMap();
			B[pk.getParent()].put(new Integer(pk.getDevNode()), pk.getNode(pk
					.getDevNode() + 1));
			// System.out.println(B[pk.getParent()]);
			if (pk.getDevNode() + 1 != pk.getNodesCount() - 1) {

				OLDPath pa = pa(graph, sNode_id, tNode_id, pk);
				if (pa != null) {
					pa.setParent(k);
					pa.setOrigem("A");
					pa.ComputeDeviation(pk);
					// System.out.println("Pa=" + pa);
					P.put(pa);
					// System.out.println(P);
				}

			}
			gama = computeGama(W[pk.getParent()], pk.getDevNode(), pj
					.getNodesCount() - 1);
			OLDPath pb = pb(graph, B[pk.getParent()], sNode_id, tNode_id, pk, pj,
					gama);
			if (pb != null) {
				pb.setParent(pk.getParent());
				pb.setOrigem("B");
				pb.ComputeDeviation(pj);
				// System.out.println("Pb=" + pb);
				P.put(pb);
				// System.out.println(P);
			}
			if (!W[pk.getParent()].contains(new Integer(pk.getDevNode()))) {
				W[pk.getParent()].add(new Integer(pk.getDevNode()));
				delta = computeDelta(W[pk.getParent()], pk.getDevNode(), pj
						.getDevNode());
				OLDPath pc = pc(graph, B[pk.getParent()], sNode_id, tNode_id, pk,
						pj, delta);
			
				if (pc != null) {
					pc.setParent(pk.getParent());
					pc.setOrigem("C");
					pc.ComputeDeviation(pj);
					// System.out.println("Pc=" + pc);
					P.put(pc);
					// System.out.println(P);
				}
			}
			k++;
		}
		// System.out.println("<Discarded Paths>");
		// while (!P.isEmpty())
		// System.out.println(P.removeFirst());
		// System.out.println("</Discarded Paths>");
		return bestPaths;
	}

	/**
	 * Calcula os k melhores caminhos partindo desNode e chegando em tNode
	 * possuinfdo no maximo nTrechos.
	 * 
	 * @param graph
	 * @param sNode_id
	 * @param tNode_id
	 * @param kLim
	 * @param nTrechos
	 * @return um vetor com os k melhores caminhos calculados
	 */
	public static final OLDPath[] k_Shortest_Paths(Graph graph, Integer sNode_id,
			Integer tNode_id, int kLim, int nTrechos) {
		int k = 1, gama, delta;
		TreeSet[] W = new TreeSet[kLim];
		DeviationArcsMap[] B = new DeviationArcsMap[kLim];
		PathMapByCost P = new PathMapByCost();
		OLDPath[] bestPaths = new OLDPath[kLim];
		OLDPath p1 = graph.Shortest_Path(sNode_id, tNode_id);
		if (p1 == null || p1.getCost() > nTrechos)
			return bestPaths;
		p1.setDevNode(-1);
		p1.setParent(0);
		W[0] = new TreeSet();
		W[0].add(new Integer(0));
		W[0].add(new Integer(p1.getNodesCount() - 1));
		bestPaths[0] = p1;
		if (kLim == 1)
			return bestPaths;
		// System.out.println("1st " + p1);
		OLDPath p2 = FSP(graph, sNode_id, tNode_id, p1, p1);
		if (p2 == null || p2.getCost() > nTrechos)
			return bestPaths;
		p2.ComputeDeviation(p1);
		p2.setParent(0);
		P.put(p2);
		B[0] = new DeviationArcsMap();
		// System.out.println(B[0]);
		while (!P.isEmpty()) {
			OLDPath pk = P.removeFirst();
			// System.out.println(P);
			OLDPath pj = bestPaths[pk.getParent()];
			if (pk.getCost() > nTrechos)
				return bestPaths;
			bestPaths[k] = pk;
			// System.out.println(k + "� " + pk);
			// System.out.flush();
			// System.out.println("Paths with cost=" + pk.getCost() + " : "
			// + P.getCountByCost(pk.getCost()));
			/* <Otimizacao Teste> */
			if (P.getCountByCost(pk.getCost()) + k + 1 >= kLim) {
				int lim = kLim - k - 1;
				for (int i = 0; i < lim; i++)
					bestPaths[++k] = P.removeFirst();
				break;
			}
			/* </Otimizacao Teste> */
			if (k + 1 == kLim)
				break;
			W[k] = new TreeSet();
			W[k].add(new Integer(pk.getDevNode() + 1));
			W[k].add(new Integer(pk.getNodesCount() - 1));
			B[k] = new DeviationArcsMap();
			B[pk.getParent()].put(new Integer(pk.getDevNode()), pk.getNode(pk
					.getDevNode() + 1));
			// System.out.println(B[pk.getParent()]);
			if (pk.getDevNode() + 1 != pk.getNodesCount() - 1) {

				OLDPath pa = pa(graph, sNode_id, tNode_id, pk);
				if (pa != null) {
					pa.setParent(k);
					pa.setOrigem("A");
					pa.ComputeDeviation(pk);
					// System.out.println("Pa=" + pa);
					P.put(pa);
					// System.out.println(P);
				}

			}
			gama = computeGama(W[pk.getParent()], pk.getDevNode(), pj
					.getNodesCount() - 1);
			OLDPath pb = pb(graph, B[pk.getParent()], sNode_id, tNode_id, pk, pj,
					gama);
			if (pb != null) {
				pb.setParent(pk.getParent());
				pb.setOrigem("B");
				pb.ComputeDeviation(pj);
				// System.out.println("Pb=" + pb);
				P.put(pb);
				// System.out.println(P);
			}
			if (!W[pk.getParent()].contains(new Integer(pk.getDevNode()))) {
				W[pk.getParent()].add(new Integer(pk.getDevNode()));
				delta = computeDelta(W[pk.getParent()], pk.getDevNode(), pj
						.getDevNode());
				OLDPath pc = pc(graph, B[pk.getParent()], sNode_id, tNode_id, pk,
						pj, delta);
				if (pc != null) {
					pc.setParent(pk.getParent());
					pc.setOrigem("C");
					pc.ComputeDeviation(pj);
					// System.out.println("Pc=" + pc);
					P.put(pc);
					// System.out.println(P);
				}
			}
			k++;
		}
		// System.out.println("<Discarded Paths>");
		// while (!P.isEmpty())
		// System.out.println(P.removeFirst());
		// System.out.println("</Discarded Paths>");
		return bestPaths;
	}

	/**
	 * Calcula o menor caminho de sNode a tNode diferente de R.
	 * 
	 * @param graph
	 *            Grafo
	 * @param sNode_id
	 *            id do n� inicial
	 * @param tNode_id
	 *            id do n� final
	 * @param R
	 *            caminho a partir do qual o novo caminho ser� gerado.
	 * @return o menor caminho calculado
	 */
	private static OLDPath FSP(Graph graph, Integer sNode_id, Integer tNode_id,
			OLDPath R, OLDPath par) {
		// System.out.println("FSP s=" + sNode_id + " t=" + tNode_id + " R " + R
		// + " par=" + par);
		Tree Ts = new Tree(graph, sNode_id, Tree.Mode.FAST_MODE, par,
				Tree.Type.Ts);
		// System.out.println(Ts);
		// System.out.println(Path.reverse(R));
		Tree Tt = new Tree(graph, tNode_id, Tree.Mode.FAST_MODE, OLDPath
				.reverse(par), Tree.Type.Tt);
		// System.out.println(Tt);
		UndirectedArc uArc = SEP(Ts, Tt, graph, sNode_id, R);
		// System.out.println(uArc);
		if (uArc == null)
			return null;
		return new OLDPath(Ts, Tt, uArc);
	}

	private static UndirectedArc SEP(Tree Ts, Tree Tt, Graph graph,
			Integer sNode_id, OLDPath p) {
		UndirectedArc resp = null;
		int cost = Integer.MAX_VALUE;
		LinkedList stack = new LinkedList();
		stack.addFirst(sNode_id);
		while (!stack.isEmpty()) {
			Integer no_atual_id = (Integer) stack.removeFirst();
			// System.out.println("[" + no_atual_id + "]");
			Leaf sCurLeaf = Ts.getLeaf(no_atual_id);
			Leaf tCurLeaf = Tt.getLeaf(no_atual_id);
			// System.out.println(sCurLeaf);
			// System.out.println(tCurLeaf);
			// Calcula filhos
			Set sons = new HashSet();
			Integer node_v = Ts.getLeaf(no_atual_id).getFirstChild_id();
			// System.out.println("Calcula filhos");
			while (node_v != null) {
				sons.add(node_v);
				node_v = Ts.getLeaf(node_v).getBrotherNode_id();
			}
			// System.out.println("FILHOS " + sons);

			if (sCurLeaf.beta == tCurLeaf.beta) {
				// System.out.println("Type 1");
				Iterator i = graph.getProximosAsSet(no_atual_id).iterator();
				while (i.hasNext()) {
					node_v = (Integer) i.next();
					// System.out.print(node_v + ",");
					if (!sons.contains(node_v)
							&& sCurLeaf.beta < Tt.getLeaf(node_v).beta
							&& cost > sCurLeaf.ordem + Tt.getLeaf(node_v).ordem
									- 1) {
						// System.out.println("Gerou Tipo 1");
						resp = new UndirectedArc(no_atual_id, node_v);
						cost = sCurLeaf.ordem + Tt.getLeaf(node_v).ordem - 1;
					}
				}
				// System.out.println("");
			} else {
				// System.out.println("Type 2 "
				// + (sCurLeaf.ordem + tCurLeaf.ordem - 2));

				if (cost > sCurLeaf.ordem + tCurLeaf.ordem - 2) {
					// System.out.println("Gerou Tipo 2");
					cost = sCurLeaf.ordem + tCurLeaf.ordem - 2;
					resp = new UndirectedArc(no_atual_id, no_atual_id);
				}
			}
			Iterator i = sons.iterator();
			while (i.hasNext()) {
				node_v = (Integer) i.next();
				if (Ts.getLeaf(node_v).beta < p.getNodesCount())
					stack.addFirst(node_v);
			}
		}
		// System.out.println(resp);
		return resp;
	}

	/**
	 * Retorna o menor caminho de s a t que se desvia de R antes de t.
	 * 
	 * @param sNode_id
	 * @param tNode_id
	 * @param R
	 * @return
	 */
	private static OLDPath pa(Graph graph, Integer sNode_id, Integer tNode_id,
			OLDPath R) {
		// System.out.println("<Pa>");
		OLDPath subPath = R.subPath(R.getDevNode() + 1);
		// System.out.println("subPath=" + subPath);
		OLDPath iniPath = R.subPath(0, R.getDevNode());
		// System.out.println("iniPath=" + iniPath);
		// System.out.println(graph);
		Set deletedNodes = graph.deleteNodes(R.getNodesIDs(0, R.getDevNode()));
		// System.out.println(graph);
		OLDPath p = FSP(graph, R.getNode(R.getDevNode() + 1), R.getLastNodeID(),
				subPath, subPath);
		graph.restoresNodes(deletedNodes);
		// System.out.println(graph);
		// System.out.println(p);
		if (p != null) {
			iniPath.concat(p);
			// System.out.println("</Pa = " + iniPath + ">");
			return iniPath;
		}
		return null;
	}

	/**
	 * Gera menor caminho entre s e t que se desvia do pai de R apos o no de
	 * desvio.
	 * 
	 * @param graph
	 * @param nextNodes
	 * @param sNode_id
	 * @param tNode_id
	 * @param pk
	 * @param pj
	 * @param gama
	 * @return
	 */
	private static OLDPath pb(Graph graph, DeviationArcsMap nextNodes,
			Integer sNode_id, Integer tNode_id, OLDPath pk, OLDPath pj, int gama) {
		// System.out.println("<pb pk=" + pk + " pj=" + pj + "/>");
		OLDPath subPath = pj.subPath(pk.getDevNode(), gama);
		OLDPath iniPath = pj.subPath(0, pk.getDevNode() - 1);
		// System.out.println("iniPath=" + iniPath);
		// System.out.println("subPath" + subPath);

		// Remove os n�s pj(alfak - 1)
		Set deletedNodes = graph.deleteNodes(pj.getNodesIDs(0,
				pk.getDevNode() - 1));
		// remove o arco v2(alfak),v2(alfak+1)
		// UndirectedArc[] arcs = new UndirectedArc[1];
		// arcs[0] = new UndirectedArc(pk.getDevNodeID(), pk.getNode(pk
		// .getDevNode() + 1));
		UndirectedArc[] arcs = nextNodes.getAsArcs(
				new Integer(pk.getDevNode()), pk.getDevNodeID());
		// System.out.println(arcs);
		graph.deleteArcs(arcs);
		// System.out.println(graph);
		OLDPath p = FSP(graph, pk.getDevNodeID(), pj.getLastNodeID(), subPath, pj
				.subPath(pk.getDevNode(), pj.getNodesCount() - 1));

		graph.restoresNodes(deletedNodes);
		graph.restoreArcs(arcs);
		// System.out.println(graph);
		if (p != null) {
			iniPath.concat(p);
			// System.out.println("Pb = " + iniPath);
			return iniPath;
		}
		// System.out.println("Pb = " + null);
		return null;
	}

	/**
	 * Retorna o menor caminho que se desvia de pj e pk antes do no de desvio
	 * 
	 * @param graph
	 * @param nextNodes
	 * @param sNode_id
	 * @param tNode_id
	 * @param pk
	 * @param pj
	 * @param delta
	 * @return
	 */
	private static OLDPath pc(Graph graph, DeviationArcsMap nextNodes,
			Integer sNode_id, Integer tNode_id, OLDPath pk, OLDPath pj, int delta) {

		// System.out.println("<pc pk=" + pk + " pj=" + pj + "/>");
		OLDPath iniPath = pj.subPath(0, delta - 1);
		// System.out.println("iniPath=" + iniPath);
		OLDPath subPath = pj.subPath(delta, pk.getDevNode());
		// System.out.println("subPath=" + subPath);
		Set deletedNodes = graph.deleteNodes(pj.getNodesIDs(0, delta - 1));
		UndirectedArc[] arcs = nextNodes.getAsArcs(new Integer(delta), pk
				.getNode(delta));
		if (arcs != null)
			graph.deleteArcs(arcs);
		// System.out.println(graph);
		OLDPath p = FSP(graph, pj.getNode(delta), pk.getLastNodeID(), subPath, pj
				.subPath(delta, pj.getNodesCount() - 1));
		graph.restoresNodes(deletedNodes);
		if (arcs != null)
			graph.restoreArcs(arcs);
		if (p != null) {
			iniPath.concat(p);
			// System.out.println("Pc = " + iniPath);
			return iniPath;
		}
		// System.out.println("Pc = " + null);
		return null;
	}

	/**
	 * 
	 * @param Wk
	 * @param alfaK
	 * @param qj
	 * @return
	 */
	private static int computeGama(TreeSet Wk, int alfaK, int qj) {
		// System.out.println("computeGama Wk=" + Wk + " alfaK=" + alfaK + "
		// qj="
		// + qj);
		// System.out.println("Gama="
		// + (Integer) Wk.subSet(new Integer(alfaK + 1),
		// new Integer(qj + 1)).first());
		return ((Integer) Wk
				.subSet(new Integer(alfaK + 1), new Integer(qj + 1)).first())
				.intValue();
	}

	/**
	 * 
	 * @param Wk
	 * @param alfaK
	 * @param alfaJ
	 * @return
	 */
	private static int computeDelta(TreeSet Wk, int alfaK, int alfaJ) {
		// System.out.println("computeDelta Wk=" + Wk + " alfaK=" + alfaK
		// + " AlfaJ" + alfaJ);
		// System.out.println("Delta = "
		// + (Integer) Wk.subSet(new Integer(alfaJ + 1),
		// new Integer(alfaK)).last());
		return ((Integer) Wk.subSet(new Integer(alfaJ + 1), new Integer(alfaK))
				.last()).intValue();
	}
}
