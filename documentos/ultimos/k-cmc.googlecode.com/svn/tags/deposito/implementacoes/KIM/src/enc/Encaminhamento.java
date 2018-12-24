package enc;

import graph.Graph;
import graph.OLDPath;
import graph.UndirectedArc;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

import kim.Kim;
import oracle.jdbc.OracleConnection;

/**
 * 
 * @author Fabio Pisaruk
 * @since September 2005
 * @version 1.0
 */
public class Encaminhamento {
	public static String connectionString = "jdbc:oracle:thin:@10.20.46.72:1521:orac";

	public static void generatePaths(Integer pontaA, Integer PontaB,
			String portadores, int nRespostas, int nTrechos, Integer p_xpes,
			Date p_dt_proc) throws ClassNotFoundException, SQLException {
		cleanTable(p_xpes);
		// parse portadores
		long time = System.currentTimeMillis();
		System.out.println("<generatePaths>");
		portadores = portadores.replace('[', ' ');
		portadores = portadores.replace(']', ' ');
		// getData
		Graph graph = new Graph(getData(portadores));
		// call path generator routine
		OLDPath[] resp = Kim.k_Shortest_Paths(graph, pontaA, PontaB, nRespostas,
				nTrechos);
		saveData(resp, p_xpes, p_dt_proc);
		System.out.println("</generatePaths time="
				+ (System.currentTimeMillis() - time) + ">");

	}

	public static void generatePaths(Integer pontaA, Integer PontaB,
			String portadores, int nRespostas, Integer p_xpes, Date p_dt_proc)
			throws ClassNotFoundException, SQLException {
		cleanTable(p_xpes);
		// parse portadores
		long time = System.currentTimeMillis();
		System.out.println("<generatePaths>");
		portadores = portadores.replace('[', ' ');
		portadores = portadores.replace(']', ' ');
		// getData
		Graph graph = new Graph(getData(portadores));
		// call path generator routine
		OLDPath[] resp = Kim.k_Shortest_Paths(graph, pontaA, PontaB, nRespostas);
		saveData(resp, p_xpes, p_dt_proc);
		System.out.println("</generatePaths time="
				+ (System.currentTimeMillis() - time) + ">");

	}

	private static void saveData(OLDPath[] paths, Integer p_xpes, Date p_dt_proc)
			throws ClassNotFoundException, SQLException {
		long time = System.currentTimeMillis();
		System.out.println("<saveData>");
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(connectionString,
				"ntg_dba2", "protege4");
		con.setAutoCommit(true);
		PreparedStatement ps = con
				.prepareStatement("INSERT INTO MIT_ENC2_NOS VALUES(?,?,?,?)");
		for (int i = 0; i < paths.length && paths[i] != null; i++) {
			ps.setInt(1, paths[i].getCost());
			ps.setString(2, paths[i].asString());
			ps.setInt(3, p_xpes.intValue());
			ps.setTimestamp(4, new Timestamp(p_dt_proc.getTime()));
			ps.addBatch();
		}
		ps.executeBatch();
		con.close();
		System.out.println("<saveData time="
				+ (System.currentTimeMillis() - time) + ">");
	}

	private static Set getData(String portadores)
			throws ClassNotFoundException, SQLException {
		System.out.println("<getData>");
		long time = System.currentTimeMillis();
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String sqlQuery = "SELECT distinct cam_ubi_origen_id AS pontaA,"
				+ "cam_ubi_destino_id AS pontaB FROM NTG_CAMINOS"
				+ " WHERE cam_ubi_origen_id <> cam_ubi_destino_id"
				+ " AND cam_estado_en_planta <> 'H'" + " AND cam_fon_id IN ("
				+ portadores + ")";
		Connection con = DriverManager.getConnection(connectionString,
				"ntg_dba2", "protege4");
		((OracleConnection) con).setDefaultRowPrefetch(2000);
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
		con.close();
		return arcs;
	}

	private static void cleanTable(Integer p_xpes)
			throws ClassNotFoundException, SQLException {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		Connection con = DriverManager.getConnection(connectionString,
				"ntg_dba2", "protege4");
		con.prepareStatement(
				"DELETE FROM MIT_ENC2_NOS WHERE nos_xpes=" + p_xpes).execute();
		con.commit();
		con.close();
	}

	public static void main(String[] args) {
		try {
			for (int i = 1; i < 140000; i *= 2) {
				System.out.println(i);
				generatePaths(new Integer(106945), new Integer(111234),
						"[157],[159],[165],[169],[170],[392],[393]", i,
						new Integer(9999), new Date(System.currentTimeMillis()));
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}