package graph;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Random;
import java.util.Set;

public class Graph {
	private static final long serialVersionUID = 5658186803945557018L;

	private HashMap nodes;

	private int nArcs = -1;

	public int getDensity() {
		return getArcsCount() / getNodesCount();
	}

	public int getNodesCount() {
		return nodes.size();
	}

	public int getArcsCount() {
		if (nArcs == -1) {
			nArcs = 0;
			Iterator i = nodes.values().iterator();
			while (i.hasNext())
				nArcs += ((Node) i.next()).proximos.size();
		}
		return nArcs;
	}

	/**
	 * Retorna um HashMap com os proximos nós do nó passado
	 * 
	 * @param node_id
	 * @return
	 */
	public HashMap getProximos(Integer node_id) {
		return ((Node) nodes.get(node_id)).proximos;
	}

	/**
	 * Retorna um HashMap com os proximos nós do nó passado
	 * 
	 * @param node_id
	 * @return
	 */
	public Set getProximosAsSet(Integer node_id) {
		return ((Node) nodes.get(node_id)).proximos.keySet();
	}

	/**
	 * Gera um grafo a partir de um conjunto de arcos.
	 * 
	 * @param arcs
	 */
	public Graph(Set undirectedArcs) {
		Iterator i = undirectedArcs.iterator();
		nodes = new HashMap();
		while (i.hasNext()) {
			UndirectedArc uArc = (UndirectedArc) i.next();
			if (nodes.containsKey(uArc.getPontaA()))
				getNode(uArc.getPontaA()).proximos.put(uArc.getPontaB(), uArc
						.getPontaB());
			else {
				HashMap proximos = new HashMap();
				proximos.put(uArc.getPontaB(), uArc.getPontaB());
				addNode(new Node(uArc.getPontaA(), proximos));
			}
			if (nodes.containsKey(uArc.getPontaB()))
				getNode(uArc.getPontaB()).proximos.put(uArc.getPontaA(), uArc
						.getPontaA());
			else {
				HashMap proximos = new HashMap();
				proximos.put(uArc.getPontaA(), uArc.getPontaA());
				addNode(new Node(uArc.getPontaB(), proximos));
			}
		}
	}

	public Graph(int nNodes, int nArcs, int maxArcsPerNode) {
		Random rand = new Random();
		Node no_atual;
		int rest = nArcs;
		int toGenerate;
		nodes = new HashMap(nNodes);
		for (int i = 1; i <= nNodes; i++) {
			Integer pId = new Integer(i * 10);
			toGenerate = Math.min(
					Math.abs(rand.nextInt()) % maxArcsPerNode + 1, rest);
			rest -= toGenerate;
			HashMap proximos = new HashMap(toGenerate);
			for (int j = 1; j <= toGenerate;) {
				Integer id = new Integer(
						(Math.abs(rand.nextInt()) % nNodes + 1) * 10);
				if (!id.equals(pId) && !proximos.containsKey(id)) {
					proximos.put(id, id);
					j++;
				}
			}
			no_atual = new Node(pId, proximos);
			nodes.put(no_atual.getId(), no_atual);
		}
	}

	public Graph(int nNodes, float variancia, float media) {
		int max = 0;
		Random rand = new Random();
		Node no_atual;
		int toGenerate;
		nodes = new HashMap(nNodes);
		for (int i = 1; i <= nNodes; i++) {
			Integer pId = new Integer(i * 10);
			toGenerate = Math.min(nNodes - 1, Math.max(1, Math.abs((int) Math
					.round(rand.nextGaussian() * variancia + media))));
			max = Math.max(max, toGenerate);
			HashMap proximos = new HashMap(toGenerate);
			for (int j = 1; j <= toGenerate;) {
				Integer id = new Integer(
						(Math.abs(rand.nextInt()) % nNodes + 1) * 10);
				if (!id.equals(pId) && !proximos.containsKey(id)) {
					proximos.put(id, id);
					j++;
				}
			}
			no_atual = new Node(pId, proximos);
			nodes.put(no_atual.getId(), no_atual);
		}
		// Torna a rede bidirecional
		Iterator i = nodes.keySet().iterator();
		while (i.hasNext()) {
			Node curNode = getNode((Integer) i.next());
			Iterator j = curNode.proximos.keySet().iterator();
			while (j.hasNext()) {
				Node pNode = getNode((Integer) j.next());
				if (!pNode.equals(curNode)) {
					/* cria arco reverso */
					pNode.proximos.put(curNode.getId(), curNode.getId());
					addNode(pNode);
				}
			}
		}
		System.out.println("Max=" + max);
		// Apaga aleatoriamente alguns arcos de modo que a rede fique com 17000
		// arcos...
	}

	public Node getNode(Integer id) {
		return (Node) nodes.get(id);
	}

	public void addNode(Node node) {
		nodes.put(node.getId(), node);
	}

	public Node getNode(int id) {
		return getNode(new Integer(id));
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("<Grafo arcos=" + getArcsCount() + " nós=" + getNodesCount()
				+ ">\n");
		Iterator i = nodes.values().iterator();
		while (i.hasNext()) {
			sb.append(((Node) i.next()).toString());
			sb.append("\n");
		}
		sb.append("</Grafo arcos=" + getArcsCount() + " nós=" + getNodesCount()
				+ ">");
		return sb.toString();
	}

	public String asXML() {
		return null;
	}

	public void restoresNodes(Set nodesToRestore) {
		Iterator i = nodesToRestore.iterator();
		nArcs = -1;
		while (i.hasNext()) {
			Node no_atual = (Node) i.next();
			addNode(no_atual);
		}
		i = nodesToRestore.iterator();
		while (i.hasNext()) {
			Integer no_atual_id = ((Node) i.next()).getId();
			// Restaura os arcos deste nó
			Iterator it = getProximosAsSet(no_atual_id).iterator();
			while (it.hasNext()) {
				getNode((Integer) it.next()).proximos.put(no_atual_id,
						no_atual_id);
			}
		}
	}

	/**
	 * Remove do grafo todos os nós cujos ids estejam no vetor nodesToDelete
	 * 
	 * @param nodesToDelete
	 *            Vetor contendo os ids dos nós a serem removidos
	 * @return O conjunto de nos removidos
	 * 
	 */
	public Set deleteNodes(Integer[] nodesToDelete) {
		nArcs = -1;
		Set backupNodes = new HashSet(nodesToDelete.length);
		for (int i = 0; i < nodesToDelete.length; i++) {
			//System.out.println("Del nó:" + nodesToDelete[i]);
			Iterator it = getProximosAsSet(nodesToDelete[i]).iterator();
			while (it.hasNext()) {
				// Apaga os arcos incidentes
				getNode((Integer) it.next()).proximos.remove(nodesToDelete[i]);

			}
			backupNodes.add(nodes.remove(nodesToDelete[i]));
		}
		return backupNodes;
	}

	/**
	 * 
	 * @param arc
	 */
	public void deleteArc(UndirectedArc arc) {
		nArcs = -1;
		//System.out.println("Del " + arc);
		getNode(arc.getPontaA().intValue()).proximos.remove(arc.getPontaB());
		getNode(arc.getPontaB().intValue()).proximos.remove(arc.getPontaA());
	}

	/**
	 * 
	 * @param toDelete
	 */
	public void deleteArcs(UndirectedArc[] toDelete) {
		for (int i = 0; i < toDelete.length; i++)
			deleteArc(toDelete[i]);
	}

	/**
	 * 
	 * @param arcs
	 */
	public void restoreArcs(UndirectedArc[] arcs) {
		for (int i = 0; i < arcs.length; i++)
			restoreArc(arcs[i]);
	}

	/**
	 * 
	 * @param arc
	 */
	public void restoreArc(UndirectedArc arc) {
		getNode(arc.getPontaA().intValue()).proximos.put(arc.getPontaB(), arc
				.getPontaB());
		getNode(arc.getPontaB().intValue()).proximos.put(arc.getPontaA(), arc
				.getPontaA());
	}

	/**
	 * Retorna o menor caminho entre os dois nós passado
	 * 
	 * @param sNode_id
	 * @param tNode_id
	 * @return
	 */
	public OLDPath Shortest_Path(Integer sNode_id, Integer tNode_id) {
		//long time = System.currentTimeMillis();
		Integer[] fila = new Integer[getNodesCount()];
		int ini = 0;
		int fim = 1;
		Tree tree = new Tree(getNodesCount());
		// System.out.println("SP s=" + sNode_id + " t=" + tNode_id);
		tree.put(sNode_id, new Leaf(sNode_id, 1));
		fila[ini] = sNode_id;
		while (fim > ini) {
			Iterator i = getNode(fila[ini]).proximos.keySet().iterator();
			int ordem = tree.getLeaf(fila[ini]).ordem + 1;
			while (i.hasNext()) {
				Integer no_aux_id = (Integer) i.next();
				if (!tree.containsKey(no_aux_id)) {
					tree.put(no_aux_id, new Leaf(no_aux_id, ordem, fila[ini]));
					fila[fim++] = no_aux_id;
					if (no_aux_id.equals(tNode_id)) {
						//System.out.println(System.currentTimeMillis() - time);
						return new OLDPath(tree, tNode_id, OLDPath.Mode.NORMAL);
					}
				}
			}
			ini++;
		}
		return null;
	}
}