package graph;

public class UndirectedArc {
	Integer node_a;

	Integer node_b;

	int hashCode;

	public UndirectedArc(Integer pontaa, Integer pontab) {
		//if (pontaa.intValue() < pontab.intValue()) {
			node_a = pontaa;
			node_b = pontab;
		//} else {
			//node_a = pontab;
			//node_b = pontaa;
		//}
	}

	public UndirectedArc(int pontaa, int pontab) {
		//if (pontaa < pontab) {
			node_a = new Integer(pontaa);
			node_b = new Integer(pontab);
		//} else {
			//node_a = new Integer(pontab);
			//node_b = new Integer(pontaa);
		//}

		hashCode = node_a.hashCode() + node_b.hashCode();
	}

	public boolean equals(Object arg0) {
		UndirectedArc outro = (UndirectedArc) arg0;

		if (node_a.equals(outro.getPontaA()))
			return node_b.equals(outro.getPontaB());
		else if (node_a.equals(outro.getPontaB()))
			return node_b.equals(outro.getPontaA());
		return false;
	}

	public int hashCode() {
		return hashCode;
	}

	public String toString() {
		return "<" + node_a + "->" + node_b + "/>";
	}

	public Integer getPontaA() {
		return node_a;
	}

	public Integer getPontaB() {
		return node_b;
	}

}
