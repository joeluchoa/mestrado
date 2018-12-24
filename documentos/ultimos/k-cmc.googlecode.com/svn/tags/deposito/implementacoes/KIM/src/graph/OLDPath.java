package graph;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;

public class OLDPath {
	Integer[] node_ids;

	HashMap hm_node_ids;

	int cost;

	int hashCode;

	int devNode;

	int parent;

	String origem;

	public static class Mode {

		public static final Mode NORMAL = new Mode(1);

		public static final Mode REVERSED = new Mode(2);

		private Mode(int i) {
		}
	}

	/**
	 * 
	 * 
	 */
	private OLDPath() {
	}

	/**
	 * Monta o caminho que liga as duas arvores de acordo com o algorimo KIM.
	 * 
	 * @param Ts
	 * @param Tt
	 * @param arc
	 */
	public OLDPath(Tree Ts, Tree Tt, UndirectedArc arc) {
		normalPath(Ts, arc.getPontaA());
		// System.out.println(this);
		/* No caso do arco representar um �nico n� */
		if (arc.getPontaA().equals(arc.getPontaB()))
			// Retira o ultimo n�
			// hm_node_ids.remove(node_ids[node_ids.length - 1]);
			concat(new OLDPath(Tt, Tt.getLeaf(arc.getPontaB()).parNode_id,
					OLDPath.Mode.REVERSED));
		else
			concat(new OLDPath(Tt, arc.getPontaB(), OLDPath.Mode.REVERSED));
		hashCode = node_ids.hashCode();
	}

	/**
	 * Gera um caminho a partir da concatenacao de dois outros
	 * 
	 * @param p1
	 * @param p2
	 */
	public OLDPath(OLDPath p1, OLDPath p2) {

	}

	/**
	 * 
	 * @param node_id
	 * @return
	 */
	public boolean contains(Integer node_id) {
		return hm_node_ids.containsKey(node_id);
	}

	/**
	 * 
	 * @param p
	 */
	public void concat(OLDPath p) {
		Integer newNodeIds[] = new Integer[node_ids.length + p.node_ids.length];
		int i, j;
		// System.out.println("Concat p1=" + this + " e " + p);
		for (i = 0; i < node_ids.length; i++)
			newNodeIds[i] = node_ids[i];
		j = 0;
		while (i < newNodeIds.length) {
			// NOVO
			hm_node_ids.put(p.node_ids[j], new Integer(i));
			newNodeIds[i++] = p.node_ids[j++];
		}
		node_ids = newNodeIds;
		cost = newNodeIds.length - 1;
		hashCode = node_ids.hashCode();
		// System.out.println(this);
	}

	/**
	 * Constroi um caminho a partir de uma arvore e um no terminal.
	 * 
	 * @param tree
	 * @param tNode_id
	 * @param mode
	 */
	public OLDPath(Tree tree, Integer tNode_id, Mode mode) {
		if (mode == Mode.NORMAL)
			normalPath(tree, tNode_id);
		else
			reversedPath(tree, tNode_id);
		this.cost = node_ids.length - 1;
		hashCode = node_ids.hashCode();
	}

	/**
	 * 
	 * @param tree
	 * @param tNode_id
	 */
	private void reversedPath(Tree tree, Integer tNode_id) {
		Leaf curLeaf = tree.getLeaf(tNode_id);
		node_ids = new Integer[curLeaf.ordem];
		hm_node_ids = new HashMap(curLeaf.ordem);
		int i = 0;
		while (curLeaf.parNode_id != curLeaf.no_id) {
			node_ids[i] = curLeaf.no_id;
			hm_node_ids.put(curLeaf.no_id, new Integer(i));
			curLeaf = (Leaf) tree.getLeaf(curLeaf.parNode_id);
			i++;
		}
		node_ids[i] = curLeaf.no_id;
		hm_node_ids.put(curLeaf.no_id, new Integer(i));
	}

	/**
	 * 
	 * @param tree
	 * @param tNode_id
	 */
	private void normalPath(Tree tree, Integer tNode_id) {
		Leaf curLeaf = tree.getLeaf(tNode_id);
		node_ids = new Integer[curLeaf.ordem];
		hm_node_ids = new HashMap(curLeaf.ordem);
		int i = curLeaf.ordem - 1;
		while (curLeaf.parNode_id != curLeaf.no_id) {
			node_ids[i] = curLeaf.no_id;
			hm_node_ids.put(curLeaf.no_id, new Integer(i));
			curLeaf = (Leaf) tree.getLeaf(curLeaf.parNode_id);
			i--;
		}
		node_ids[i] = curLeaf.no_id;
		hm_node_ids.put(curLeaf.no_id, new Integer(i));
	}

	/**
	 * 
	 * 
	 */
	public void reverse() {
		Integer aux;
		int j = node_ids.length - 1;
		for (int i = 0; i < node_ids.length / 2; i++, j--) {
			aux = node_ids[i];
			node_ids[i] = node_ids[j];
			node_ids[j] = aux;
			hm_node_ids.put(node_ids[i], new Integer(i));
			hm_node_ids.put(node_ids[j], new Integer(j));
		}
		hashCode = node_ids.hashCode();
		return;
	}

	/**
	 * 
	 * @param p
	 * @return
	 */
	public static OLDPath reverse(OLDPath p) {
		try {
			OLDPath resp = (OLDPath) p.clone();
			resp.reverse();
			return resp;
		} catch (CloneNotSupportedException e) {
		}
		return null;
	}

	/**
	 * 
	 * @param ini
	 * @param fim
	 * @return
	 */
	public OLDPath subPath(int ini, int fim) {
		OLDPath p = new OLDPath();
		p.node_ids = new Integer[fim - ini + 1];
		p.hm_node_ids = new HashMap(fim - ini + 1);

		for (int i = ini, j = 0; i <= fim; i++, j++) {
			p.node_ids[j] = node_ids[i];
			p.hm_node_ids.put(p.node_ids[j], new Integer(j));
		}
		p.cost = p.node_ids.length - 1;
		p.hashCode = p.node_ids.hashCode();
		return p;
	}

	/**
	 * 
	 * @param sNode_id
	 * @param tNode_id
	 * @return
	 */
	public OLDPath subPath(Integer sNode_id, Integer tNode_id) {
		return null;
	}

	/**
	 * 
	 * @param ini
	 * @param fim
	 * @return
	 */
	public Integer[] getNodesIDs(int ini, int fim) {
		Integer[] nodes = new Integer[fim - ini + 1];
		for (int i = ini; i <= fim; i++)
			nodes[i] = node_ids[i];
		return nodes;
	}

	/**
	 * 
	 * @param iniNode_id
	 * @param finalNode_id
	 * @return
	 */
	public Set getNodes(Integer iniNode_id, int finalNode_id) {
		return null;
	}

	/**
	 * 
	 */
	public boolean equals(Object arg0) {
		if ((hashCode == ((OLDPath) arg0).hashCode())) {
			Iterator i = hm_node_ids.keySet().iterator();
			Iterator j = ((OLDPath) arg0).hm_node_ids.keySet().iterator();

			while (i.hasNext() && j.hasNext()) {
				if (!i.next().equals(j.next()))
					return false;
			}
			if (!(i.hasNext() && j.hasNext()))
				return false;
			return true;
		} else
			return false;
	}

	/**
	 * 
	 */
	public int hashCode() {
		return hashCode;
	}

	/**
	 * 
	 */
	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("<Path cost=" + cost + " devPos=" + devNode + " par="
				+ parent + " origem=" + origem + ">");
		for (int i = 0; i < node_ids.length; i++)
			sb.append(node_ids[i] + "-");
		sb.deleteCharAt(sb.length() - 1);
		sb.append("</Path>");
		return sb.toString();
	}

	public String asString() {
		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < node_ids.length; i++)
			sb.append(node_ids[i] + "-");
		sb.deleteCharAt(sb.length() - 1);
		return sb.toString();
	}

	/**
	 * 
	 * @return
	 */
	public int getCost() {
		return cost;
	}

	/**
	 * 
	 * @param cost
	 */
	public void setCost(int cost) {
		this.cost = cost;
	}

	public int getNodesCount() {
		return node_ids.length;
	}

	/**
	 * Cria uma copia deste caminho.
	 */
	protected Object clone() throws CloneNotSupportedException {
		OLDPath newPath = new OLDPath();
		newPath.node_ids = new Integer[node_ids.length];
		for (int i = 0; i < node_ids.length; i++)
			newPath.node_ids[i] = node_ids[i];
		newPath.hm_node_ids = (HashMap) hm_node_ids.clone();
		newPath.cost = cost;
		newPath.hashCode = hashCode;
		return newPath;
	}

	/**
	 * Calcula o desvio deste no em relacao a p
	 * 
	 * @param p
	 *            Caminho a partir do qual este n� se desvia
	 */
	public void ComputeDeviation(OLDPath p) {
		for (int i = 0; i < p.node_ids.length; i++)
			if (!node_ids[i].equals(p.node_ids[i])) {
				// System.out.println(node_ids[i] + "!=" + p.node_ids[i]);
				devNode = i - 1;
				break;
			}
		// System.out.println("computeDeviaton between " + this + " and " + p
		// + " = " + devNode);
	}

	public int getDevNode() {
		return devNode;
	}

	/**
	 * Retorna o id do n� cuja posicao seja pos.
	 * 
	 * @param pos
	 * @return
	 */
	public Integer getNode(int pos) {
		return node_ids[pos];
	}

	/**
	 * 
	 * @return
	 */
	public Integer getLastNodeID() {
		return node_ids[node_ids.length - 1];
	}

	/**
	 * 
	 * @return
	 */
	public Integer getFirstNodeID() {
		return node_ids[0];
	}

	/**
	 * 
	 * @return
	 */
	public Integer getDevNodeID() {
		return node_ids[devNode];
	}

	/**
	 * 
	 * @param ini
	 * @return
	 */
	public OLDPath subPath(int ini) {
		return subPath(ini, node_ids.length - 1);
	}

	public int getParent() {
		return parent;
	}

	public void setParent(int parent) {
		this.parent = parent;
	}

	public void setDevNode(int devNode) {
		this.devNode = devNode;
	}

	public String getOrigem() {
		return origem;
	}

	public void setOrigem(String origem) {
		this.origem = origem;
	}
}
