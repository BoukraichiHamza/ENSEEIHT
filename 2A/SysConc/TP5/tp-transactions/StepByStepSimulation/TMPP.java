import java.util.Map;
import java.util.HashMap;
import java.util.Set;
import java.util.HashSet;

// Une mémoire transactionnelle pessimiste
// à base de verrous non-bloquants.

public class TMPP extends TMAbstract {

    // La map qui lie chaque t_objet au verrou
    // non-bloquant qui en protège l'accès.
    private Map<String,TrySharedLock> locks;
    // La map qui lie chaque transaction à l'ancienne
    // valeur des objets dans lesquels elle a écrit.
    private Map<String,Map<String,Integer>> oldVals;
    // La map qui lie chaque transaction à l'ensemble des
    // t_objets qu'elle a lu.
    private Map<String,Set<String>> readSets;
    // La map qui lie chaque transaction à l'ensemble des
    // t_objets dans lesquels elle a écrit.
    private Map<String,Set<String>> writeSets;

    public TMPP(Map<String,Integer> t_objects) {

        this(t_objects, new HashSet<String>());
    }

    public TMPP(Map<String,Integer> t_objects,
                           Set<String> transactions) {

        this.transactions = transactions;
        this.t_objects = t_objects;

        this.locks = new HashMap<String,TrySharedLock>();
        for (String name : this.t_objects.keySet()) {
            this.locks.put(name, new TrySharedLock());
        }

        this.oldVals = new HashMap<String,Map<String,Integer>>();
        this.readSets = new HashMap<String,Set<String>>();
        this.writeSets = new HashMap<String,Set<String>>();
        for (String name : this.transactions) {
            this.oldVals.put(name, new HashMap<String,Integer>());
            this.readSets.put(name, new HashSet<String>());
            this.writeSets.put(name, new HashSet<String>());
        }
    }

    // Nettoye les variables de toute valeur liée à la
    // transaction.
    private void remove(String transaction) {

        this.transactions.remove(transaction);
        this.oldVals.remove(transaction);
        this.readSets.remove(transaction);
        this.writeSets.remove(transaction);
    }

    // Libère tous les verrous pris par une transaction et
    // nettoye les variables de la mémoire transactionnelle.
    private void unlock_all(String transaction) {

        Set<String> readWriteSet = new HashSet<String>(this.readSets.get(transaction));
        readWriteSet.addAll(this.writeSets.get(transaction));

        for (String t_object : readWriteSet) {
            locks.get(t_object).release(transaction);
        }

        this.remove(transaction);
    }

    public boolean newTransaction(AbstractTransaction transaction) {

        if(this.transactions.contains(transaction.getName())) {
            return false;
        }

        this.transactions.add(transaction.getName());
        this.oldVals.put(transaction.getName(), new HashMap<String,Integer>());
        this.readSets.put(transaction.getName(), new HashSet<String>());
        this.writeSets.put(transaction.getName(), new HashSet<String>());
        (new Thread(transaction)).start();
        return true;
    }

    public int read(String transaction, String t_object) throws AbortException {

        Set<String> readWriteSet = new HashSet<String>(this.readSets.get(transaction));
        readWriteSet.addAll(this.writeSets.get(transaction));
        if (!readWriteSet.contains(t_object)) {
            boolean lock = locks.get(t_object).try_shared(transaction);
            if (!lock) {
                this.abort(transaction);
            }
            readSets.get(transaction).add(t_object);
        }

        return this.t_objects.get(t_object);
    }


    public void write(String transaction,
                      String t_object,
                      int value) throws AbortException {

        if (!writeSets.get(transaction).contains(t_object)) {
            boolean lock = locks.get(t_object).try_exclusive(transaction);
            if (!lock) {
                this.abort(transaction);
            }
            writeSets.get(transaction).add(t_object);
            this.oldVals.get(transaction)
                        .put(t_object,this.t_objects.get(t_object));
        }

        this.t_objects.put(t_object, value);
    }


    public void abort(String transaction) throws AbortException {

        for (String t_object : writeSets.get(transaction)) {
            System.out.println(t_object+
                               " "+
                               oldVals.get(transaction).get(t_object));
            this.t_objects.put(t_object, oldVals.get(transaction)
                                                .get(t_object));
        }

        this.unlock_all(transaction);

        throw new AbortException();
    }


    public void commit(String transaction) throws AbortException {

        this.unlock_all(transaction);
    }

}
