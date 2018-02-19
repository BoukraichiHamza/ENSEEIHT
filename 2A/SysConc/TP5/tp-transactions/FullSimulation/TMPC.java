import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;

// Une mémoire transactionnelle optimiste
// à base de vérification à la validation.

public class TMPC extends TMAbstract {

    // La map qui lie chaque transaction à la valeur
    // initiale des objets dans lesquels elle a écrit.
    private Map<String,Map<String,Integer>> oldVals;
    // La map qui lie chaque transaction à la nouvelle
    // valeur des objets dans lesquels elle a écrit.
    private Map<String,Map<String,Integer>> newVals;
    // La map qui lie chaque transaction aux objets
    // qu'elle a lus.
    private Map<String,Set<String>> readObjs;


    public TMPC(Map<String,Integer> t_objects) {
        this(t_objects, new HashSet<String>());
    }


    public TMPC(Map<String,Integer> t_objects,
                        Set<String> transactions) {

        this.transactions = transactions;
        this.t_objects = t_objects;
        this.oldVals = new HashMap<String,Map<String,Integer>>();
        this.newVals = new HashMap<String,Map<String,Integer>>();
        this.readObjs = new HashMap<String,Set<String>>();
        for (String name : this.transactions) {
            this.oldVals.put(name, new HashMap<String,Integer>());
            this.newVals.put(name, new HashMap<String,Integer>());
            this.readObjs.put(name, new HashSet<String>());
        }
    }


    private void remove(String transaction) {

        this.transactions.remove(transaction);
        this.oldVals.remove(transaction);
        this.newVals.remove(transaction);
        this.readObjs.remove(transaction);
    }


    public boolean newTransaction(AbstractTransaction transaction) {
        if(this.transactions.contains(transaction.getName())) {
            return false;
        }

        this.transactions.add(transaction.getName());
        this.oldVals.put(transaction.getName(), new HashMap<String,Integer>());
        this.newVals.put(transaction.getName(), new HashMap<String,Integer>());
        this.readObjs.put(transaction.getName(), new HashSet<String>());
        (new Thread(transaction)).start();
        return true;
    }


    public int read(String transaction, String t_object) throws AbortException {

        if (!this.readObjs.get(transaction).contains(t_object)) {
        	if (!this.oldVals.get(transaction).containsKey(t_object)) {
				this.oldVals.get(transaction).put(t_object, this.t_objects.get(t_object));
            	this.newVals.get(transaction).put(t_object, this.t_objects.get(t_object));
            }
            this.readObjs.get(transaction).add(t_object);
        }
        return this.newVals.get(transaction).get(t_object);
    }


    public void write(String transaction,
                      String t_object,
                      int value) throws AbortException {

        if (!this.oldVals.get(transaction).containsKey(t_object)) {
            this.oldVals.get(transaction).put(t_object, this.t_objects.get(t_object));
        }
        this.newVals.get(transaction).put(t_object, value);
    }


    public void abort(String transaction) throws AbortException {

        this.remove(transaction);
        throw new AbortException();
    }


    public synchronized void commit(String transaction) throws AbortException {
		for (String t_object : this.readObjs.get(transaction)) {
			if (!this.t_objects.get(t_object)
								.equals(this.oldVals.get(transaction)
													.get(t_object)))
			{
				this.abort(transaction);
			}
		}

		for (String t_object : this.newVals.get(transaction).keySet()) {
			this.t_objects.put(t_object,this.newVals.get(transaction)
													.get(t_object));
		}
        this.remove(transaction);
    }

}
