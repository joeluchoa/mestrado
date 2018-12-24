package graph;

import java.util.Collection;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedList;

public final class Tree extends HashMap {
	private static final long serialVersionUID = -8593837719407848274L;

	public static class Mode {
		public static final Mode FAST_MODE = new Mode(1);

		public static final Mode MEMORY_MODE = new Mode(2);

		private Mode(int i) {
		}
	}

	public static class Type {
		public static final Type Ts = new Type(1);

		public static final Type Tt = new Type(2);

		private Type(int i) {
		}
	}

	/**
	 * Imprime a arvore comecando pela ordem 1.
	 */
	public String toString() {
		int ordem = 1;
		Collection toDelete = new HashSet();
		StringBuffer sb = new StringBuffer();
		HashSet keys = new HashSet(this.keySet());
		sb.append("<Tree>\n");
		while (!keys.isEmpty()) {
			Iterator i = keys.iterator();
			int pos = sb.length();
			int cont = 0;
			while (i.hasNext()) {
				Integer no_id = (Integer) i.next();
				if (((Leaf) this.get(no_id)).ordem == ordem) {
					sb.append(((Leaf) this.get(no_id)));
					toDelete.add(no_id);
					cont++;
				}
			}
			sb.insert(pos, "[" + cont + "]");
			sb.append("\n");
			keys.removeAll(toDelete);
			ordem++;
		}
		sb.append("</Tree>");
		return sb.toString();
	}

	public Tree(Graph graph, Integer sNode_id, Mode mode, OLDPath p, Type type) {
		super(graph.getNodesCount());
		if (mode == Mode.FAST_MODE)
			BST_Fast_Mode(graph, p, type);
		else
			BST_Memory_Mode(graph, sNode_id, p, type);
	}

	public Tree() {
		super();
	}

	public Tree(int i) {
		super(i);
	}

	// private final void BST_Fast_Mode(Graph graph, Path p, Type type) {
	// final Integer[] fila = new Integer[graph.getNodesCount()];
	//
	// int ini = 0, fim = 0;
	//
	// if (type == Type.Ts) {
	// put(p.node_ids[0], new Leaf(1, p.node_ids[0], 1, p.node_ids[0],
	// null, p.node_ids[1]));
	// fila[0] = p.node_ids[0];
	// for (int i = 1; i < p.node_ids.length - 1; i++) {
	// fila[i] = p.node_ids[i];
	// put(fila[i], new Leaf(i + 1, fila[i], i + 1, fila[i - 1], null,
	// p.node_ids[i + 1]));
	// }
	// fim = p.node_ids.length - 1;
	// fila[fim] = p.node_ids[fim];
	// put(fila[fim], new Leaf(fim + 1, fila[fim], fim + 1, fila[fim - 1],
	// null, null));
	// } else {
	// put(p.node_ids[0], new Leaf(p.node_ids.length, p.node_ids[0], 1,
	// p.node_ids[0], null, p.node_ids[1]));
	// fila[0] = p.node_ids[0];
	// for (int i = 1; i < p.node_ids.length - 1; i++) {
	// fila[i] = p.node_ids[i];
	// put(fila[i], new Leaf(p.node_ids.length - i, fila[i], i + 1,
	// fila[i - 1], null, p.node_ids[i + 1]));
	// }
	// fim = p.node_ids.length - 1;
	// fila[fim] = p.node_ids[fim];
	// put(fila[fim], new Leaf(1, fila[fim], fim + 1, fila[fim - 1], null,
	// null));
	// }
	// fim++;
	// while (fim > ini) {
	// Leaf parLeaf = (Leaf) this.get(fila[ini]);
	// int ordem = parLeaf.ordem + 1;
	// int beta = parLeaf.beta;
	// Iterator i = graph.getNode(fila[ini]).proximos.keySet().iterator();
	// Integer oldBrother = null;
	// while (i.hasNext()) {
	// Integer no_aux_id = (Integer) i.next();
	// if (!containsKey(no_aux_id)) {
	// put(no_aux_id, new Leaf(beta, no_aux_id, ordem, fila[ini],
	// oldBrother, null));
	// fila[fim++] = no_aux_id;
	// oldBrother = no_aux_id;
	// }
	// }
	// parLeaf.setFirstChild_id(oldBrother);
	// ini++;
	// }
	// for (int i = 1; i < p.node_ids.length; i++) {
	// Leaf cur = getLeaf(p.node_ids[i]);
	// Leaf par = getLeaf(p.node_ids[i - 1]);
	// cur.setBrotherNode_id(par.getFirstChild_id());
	// par.setFirstChild_id(cur.no_id);
	// }
	// }

	private final void BST_Fast_Mode(Graph graph, OLDPath p, Type type) {
		final Integer[] fila = new Integer[graph.getNodesCount()];
		int ini = 0, fim = 1;
		int correction;

		if (Type.Tt == type)
			correction = p.getNodesCount() + 1;
		else
			correction = 0;

		put(p.getFirstNodeID(), new Leaf(Math.abs(correction - 1), p
				.getFirstNodeID(), 1, p.getFirstNodeID(), null, null));
		fila[ini] = p.getFirstNodeID();
		while (fim > ini) {
			Leaf parLeaf = (Leaf) get(fila[ini]);
			int ordem = parLeaf.ordem + 1;
			Iterator i = graph.getProximosAsSet(fila[ini]).iterator();
			Integer oldBrother = null;
			while (i.hasNext()) {
				Integer no_aux_id = (Integer) i.next();
				if (!containsKey(no_aux_id)) {
					if (p.contains(no_aux_id))
						put(no_aux_id, new Leaf(Math.abs(correction - ordem),
								no_aux_id, ordem, fila[ini], oldBrother, null));
					else
						put(no_aux_id, new Leaf(parLeaf.beta, no_aux_id, ordem,
								fila[ini], oldBrother, null));
					fila[fim++] = no_aux_id;
					oldBrother = no_aux_id;
				}
			}
			parLeaf.setFirstChild_id(oldBrother);
			ini++;
		}

		// Path p must be on the tree
		for (int i = 1; i < p.getNodesCount(); i++) {
			// find left brother
			Integer wNode_ID = p.getNode(i);
			Leaf wLeaf = getLeaf(wNode_ID);

			Leaf atual = getLeaf(getLeaf(wLeaf.parNode_id).getFirstChild_id());
			Leaf last = null;
			while (!atual.no_id.equals(wNode_ID)) {
				last = atual;
				atual = getLeaf(atual.getBrotherNode_id());
			}

			// restore brothehood
			if (last != null)
				last.setBrotherNode_id(atual.getBrotherNode_id());
			else
				getLeaf(wLeaf.parNode_id).setFirstChild_id(
						atual.getBrotherNode_id());

			// parent exchange
			Integer pNode_ID = p.getNode(i - 1);
			Leaf pLeaf = getLeaf(pNode_ID);
			wLeaf.setParNode_id(pNode_ID);
			wLeaf.setBrotherNode_id(pLeaf.getFirstChild_id());
			pLeaf.setFirstChild_id(wNode_ID);

			// getLeaf(p.node_ids[i]).setParNode_id(p.getNode(i - 1));
		}
	}

	private final void BST_Memory_Mode(Graph graph, Integer sNode_id, OLDPath p,
			Type type) {
		Leaf currentLeaf;
		Leaf parLeaf;
		Node curNode;
		LinkedList fila = new LinkedList();
		Iterator i;
		int ordem = 1;
		Integer no_aux_id;
		Integer no_atual_id;

		parLeaf = new Leaf(1, sNode_id, ordem);
		put(sNode_id, parLeaf);
		fila.addFirst(sNode_id);

		while (!fila.isEmpty()) {
			no_atual_id = (Integer) fila.removeFirst();
			curNode = graph.getNode(no_atual_id);
			parLeaf = (Leaf) this.get(no_atual_id);
			ordem = parLeaf.ordem + 1;
			i = curNode.proximos.keySet().iterator();
			while (i.hasNext()) {
				no_aux_id = (Integer) i.next();
				if (!this.containsKey(no_aux_id)) {
					currentLeaf = new Leaf(0, no_aux_id, ordem, parLeaf.no_id);
					put(no_aux_id, currentLeaf);
					fila.addLast(no_aux_id);
				}
			}
		}
	}

	public Leaf getLeaf(Integer key) {
		return (Leaf) get(key);
	}

	public void put(Integer key, Leaf leaf) {
		put((Object) key, (Object) leaf);
	}

	public Object put(Object arg0, Object arg1) {
		return super.put((Integer) arg0, (Leaf) arg1);
	}
}
