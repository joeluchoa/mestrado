package graph;

public final class Leaf {
	public int beta;

	public int ordem;

	public Integer parNode_id;

	public Integer no_id;

	private Integer brotherNode_id = null;

	private Integer firstChild_id = null;

	public Leaf(int beta, Integer no_id, int ordem, Integer par) {
		this.beta = beta;
		this.no_id = no_id;
		this.ordem = ordem;
		this.parNode_id = par;
	}

	public Leaf(int beta, Integer no_id, int ordem, Integer par,
			Integer brotherNode_id, Integer firstChild_id) {
		this.beta = beta;
		this.no_id = no_id;
		this.ordem = ordem;
		this.parNode_id = par;
		this.brotherNode_id = brotherNode_id;
		this.firstChild_id = firstChild_id;
	}

	public Leaf(Integer no_id, int ordem, Integer par) {
		this.no_id = no_id;
		this.ordem = ordem;
		this.parNode_id = par;
	}

	/**
	 * Cria uma folha raiz
	 * 
	 * @param no_id
	 * @param ordem
	 */
	public Leaf(Integer no_id, int ordem) {
		this.no_id = no_id;
		this.ordem = ordem;
		this.parNode_id = this.no_id;
	}

	public Leaf(int beta, Integer no_id, int ordem) {
		this.beta = beta;
		this.no_id = no_id;
		this.ordem = ordem;
		this.parNode_id = this.no_id;
	}

	public boolean equals(Object arg0) {
		return no_id.equals(((Leaf) arg0).no_id);
	}

	public String toString() {
		StringBuffer sb = new StringBuffer();
		sb.append("<id=" + no_id + " b=" + beta + " o=" + ordem + " p="
				+ parNode_id + " fc=" + firstChild_id + " br=" + brotherNode_id
				+ "/>");
		return sb.toString();
	}

	public Integer getBrotherNode_id() {
		return brotherNode_id;
	}

	public void setBrotherNode_id(Integer brotherNode_id) {
		this.brotherNode_id = brotherNode_id;
	}

	public Integer getFirstChild_id() {
		return firstChild_id;
	}

	public void setFirstChild_id(Integer firstChild_id) {
		this.firstChild_id = firstChild_id;
	}

	public void setParNode_id(Integer parNode_id) {
		this.parNode_id = parNode_id;
	}
}