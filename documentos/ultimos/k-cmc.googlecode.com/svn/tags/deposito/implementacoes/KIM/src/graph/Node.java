package graph;

import java.util.HashMap;
import java.util.Iterator;

public class Node {
	private Integer id;

	public HashMap proximos;

	private int hashCode;

	public Node(Integer id) {
		this.id = id;
		hashCode = id.hashCode();
	}

	public Node(int id) {
		this.id = new Integer(id);
		hashCode = this.id.hashCode();
	}

	public Node(int id, HashMap proximos) {
		this(id);
		this.proximos = proximos;
	}

	public Node(Integer id, HashMap proximos) {
		this(id);
		this.proximos = proximos;
	}

	public boolean equals(Object arg0) {
		return ((Node) arg0).id.equals(id);
	}

	public int hashCode() {
		return hashCode;
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("<node id=" + id + ">");
		Iterator i = proximos.keySet().iterator();
		while (i.hasNext())
			sb.append(((Integer) i.next()) + " ");
		sb.deleteCharAt(sb.length()-1);
		sb.append("</node>");
		return sb.toString();
	}

	public Integer getId() {
		return id;
	}

}
