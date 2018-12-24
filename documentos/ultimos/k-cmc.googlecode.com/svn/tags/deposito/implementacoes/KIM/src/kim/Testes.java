package kim;

import graph.Graph;
import graph.OLDPath;
import graph.UndirectedArc;

import java.io.FileReader;
import java.io.StreamTokenizer;
import java.sql.SQLException;
import java.util.Iterator;
import java.util.Vector;

public class Testes {

	public Testes(String filename, int k) {
		try {
			Vector testes = new Vector();
			Vector arcs = getData(filename);
			Graph graph = new Graph(kim.Main.getData());

			long times[] = new long[arcs.size() * 2];
			Iterator i = arcs.iterator();
			int j = 0;
			while (i.hasNext()) {
				UndirectedArc testeArc = (UndirectedArc) i.next();
				times[j] = System.currentTimeMillis();
				testes.add(Kim.k_Shortest_Paths(graph, testeArc.getPontaA(),
						testeArc.getPontaB(), k));
				times[j] = System.currentTimeMillis() - times[j];
				j++;
				times[j] = System.currentTimeMillis();
				testes.add(Kim.k_Shortest_Paths(graph, testeArc.getPontaB(),
						testeArc.getPontaA(), k));
				times[j] = System.currentTimeMillis() - times[j];
				j++;
			}
			i = arcs.iterator();
			j = 0;
			System.out.println(k + "-shortest paths times");
			while (i.hasNext()) {
				UndirectedArc testArc = (UndirectedArc) i.next();
				System.out.println(testArc.getPontaA() + "-"
						+ testArc.getPontaB() + " = " + times[j++]);
				System.out.println(testArc.getPontaB() + "-"
						+ testArc.getPontaA() + " = " + times[j++]);
			}

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public void printTestes(Vector testes, Vector arcs) {
		System.out.println("<Paths>");

		Iterator l = testes.iterator();
		Iterator i = arcs.iterator();
		while (i.hasNext()) {
			UndirectedArc arc = (UndirectedArc) i.next();
			OLDPath paths[] = (OLDPath[]) l.next();
			System.out.println("<Start =" + arc.getPontaA() + " Target="
					+ arc.getPontaB() + ">");
			for (int h = 0; h < paths.length; h++)
				System.out.println(paths[h]);
			System.out.println("</Start =" + arc.getPontaA() + " Target="
					+ arc.getPontaB() + ">");
			paths = (OLDPath[]) l.next();
			System.out.println("<Start =" + arc.getPontaB() + " Target="
					+ arc.getPontaA() + ">");
			for (int h = 0; h < paths.length; h++)
				System.out.println(paths[h]);
			System.out.println("</Start =" + arc.getPontaB() + " Target="
					+ arc.getPontaA() + ">");
		}
		System.out.println("</Paths>");
	}

	public static Vector getData(String fileName) {
		Vector arcs = new Vector();
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

	public static void main(String args[]) {
		new Testes(args[0], Integer.parseInt(args[1]));
	}
}