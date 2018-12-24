package kim;

import graph.Graph;
import graph.OLDPath;
import graph.UndirectedArc;

import java.io.FileReader;
import java.io.StreamTokenizer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashSet;
import java.util.Set;

public class Main {
	public static void main(String[] args) {
		// long time;
		Integer sNode_id, tNode_id;
		Graph graph;
		try {
			// graph = new Graph(getData(args[2]));
			graph = new Graph(getData());
		} catch (Exception e) {
			System.err.println("ERRO: " + e.getMessage());
			return;
		}

		System.out.println();
		// Graph graph = new Graph(5120, 18000, 10);
		// Graph graph = new Graph(5120, 2.5f, 1f);
		// Graph graph = new Graph(10, 2.5f, 1f);
		//System.out.println(graph);
		// System.out.println(graph.getDensity());
		// time = System.currentTimeMillis();

		sNode_id = new Integer(args[0]);
		tNode_id = new Integer(args[1]);

		// time = System.currentTimeMillis();
		// Path p1 = graph.Shortest_Path(sNode_id, tNode_id);
		// System.out.println(System.currentTimeMillis() - time);
		// System.out.println(p1);

		// time = System.currentTimeMillis();
//		Integer nodes[] = new Integer[] { new Integer(113999),
//				new Integer(109610), new Integer(111117), new Integer(111234),
//				new Integer(111564), new Integer(111623), new Integer(127322),
//				new Integer(111359), new Integer(112669), new Integer(106942),
//				new Integer(109195), new Integer(111746) };
		// for (int i = 0; i < 20; i++)
		// new Tree(graph, nodes[i % 12], Tree.Mode.FAST_MODE, p1,
		// Tree.Type.Ts);
		// Tree ta = new Tree(graph, nodes[1], Tree.Mode.FAST_MODE, p1,
		// Tree.Type.Ts);
		// System.out.println(System.currentTimeMillis() - time);
		// System.out.println(ta);
 
		long time = System.currentTimeMillis();
		// for (int i = 0; i < 1000; i++)
		// kim.k_Shortest_Paths(graph, nodes[i % nodes.length],
		// nodes[(i + 1) % nodes.length], 3);
		// kim.k_Shortest_Paths(graph, sNode_id, tNode_id, 3);
		OLDPath[] paths = Kim.k_Shortest_Paths(graph, sNode_id, tNode_id, 100);
		System.out.println("k-Shortest paths between " + sNode_id + " and "
				+ tNode_id);
		time = System.currentTimeMillis() - time;
		for (int i = 0; i < paths.length && paths[i] != null; i++) {
			System.out.println(i + " - " + paths[i]);
		}
		System.out.println(time);

		// p1.reverse();
		// System.out.println(new Path(ta, tNode_id, Path.Mode.NORMAL));
		// time = System.currentTimeMillis();
		// for (int i = 0; i < 1; i++)
		// new Tree(graph, nodes[i % 12], Tree.Mode.FAST_MODE, p1,
		// Tree.Type.Tt);
		// System.out.println(System.currentTimeMillis() - time);
		// System.out.println(tb);
		// System.out.println(new Path(tb, sNode_id, Path.Mode.NORMAL));
		//System.out.println(graph);
		return;
	}

	public static Set getData() throws ClassNotFoundException, SQLException {
		System.out.println("<getData>");
		long time = System.currentTimeMillis();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String portadores = "157,159,165,169,170,392,393";
		String sqlQuery = "SELECT distinct cam_ubi_origen_id AS pontaA,"
				+ "cam_ubi_destino_id AS pontaB FROM NTG_CAMINOS"
				+ " WHERE cam_ubi_origen_id <> cam_ubi_destino_id"
				+ " AND cam_estado_en_planta <> 'H'" + " AND cam_fon_id IN ("
				+ portadores + ")";
		Connection con = DriverManager.getConnection(
				"jdbc:oracle:thin:@10.20.46.72:1521:orac", "ntg_dba2",
				"protege4");
		PreparedStatement prepare = con.prepareStatement(sqlQuery);
		ResultSet rs = prepare.executeQuery();
		rs.setFetchSize(20000);
		rs.setFetchDirection(ResultSet.FETCH_FORWARD);
		HashSet arcs = new HashSet(8500);
		while (rs.next())
			arcs.add(new UndirectedArc(new Integer(rs.getInt("pontaA")),
					new Integer(rs.getInt("pontaB"))));
		System.out.println("</getData time="
				+ (System.currentTimeMillis() - time) + ">");
		return arcs;
	}

	public static Set getData(String fileName) {
		Set arcs = new HashSet();
		try {
			FileReader file = new FileReader(fileName);
			StreamTokenizer st = new StreamTokenizer(file);
			st.parseNumbers();
			st.eolIsSignificant(true);
			int[] p = { 0, 0 };
			int i = 0;
			int token = st.nextToken();
			while (token != StreamTokenizer.TT_EOF) {
				switch (token) {
				case StreamTokenizer.TT_NUMBER:
					p[i % 2] = (int) st.nval;
					i++;
					break;
				case StreamTokenizer.TT_EOL:
					arcs.add(new UndirectedArc(p[0], p[1]));
					break;
				}
				token = st.nextToken();
			}
			file.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return arcs;
	}
}
