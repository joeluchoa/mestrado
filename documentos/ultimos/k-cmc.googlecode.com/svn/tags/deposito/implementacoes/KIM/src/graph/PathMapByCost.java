package graph;

import java.util.Comparator;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;
import java.util.TreeMap;

import edu.uci.ics.jung.algorithms.shortestpaths.Path;

public class PathMapByCost extends TreeMap {
	private static final long serialVersionUID = -844294225793076380L;

	public PathMapByCost() {
		super(new Comparator() {
			public int compare(Object arg0, Object arg1) {
				return ((Integer) arg0).compareTo((Integer) arg1);
			}
		});
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("<PathMapByCost>");
		Iterator i = keySet().iterator();
		while (i.hasNext()) {
			Integer cost = (Integer) i.next();
			sb.append("\n<Custo=" + cost + ">\n");
			sb.append("\t" + get(cost));
			sb.append("\n</Custo>");
		}
		sb.append("\n</PathMapByCost>");
		return sb.toString();
	}

	/**
	 * Insere um conjunto de caminhos com o custo passado.
	 */
	public Object put(Object arg0, Object arg1) {
		return super.put((Integer) arg0, (Set) arg1);
	}

	/**
	 * Insere um caminho no Map
	 * 
	 * @param p
	 *            Caminho a ser inserido
	 */
	public void put(Path p) {
		Integer cost = new Integer(p.getCost());
		Set paths = (Set) get(cost);
		if (paths == null) {
			paths = new HashSet(1);
			paths.add(p);
			put(cost, paths);
		} else
			paths.add(p);
	}

	/**
	 * 
	 * @return
	 */
	public Path removeFirst() {
		Set paths = (Set) get(firstKey());
		Iterator i = paths.iterator();
		Path resp = (Path) i.next();

		paths.remove(resp);
		if (paths.isEmpty())
			remove(firstKey());
		return resp;
	}

	public int getCountByCost(int cost) {
		Set paths = (Set) get(new Integer(cost));
		
		if (paths == null)
			return 0;
		return paths.size();
	}
}
