import java.util.Set;
import java.util.HashSet;

// Un verrou non-bloquant avec deux modes : partagé pour
// des lectures en parallèle et exclusif pour une écriture seule.

public class TrySharedLock {

    private boolean exclusive;
    private Set<String> holders;

    public TrySharedLock() {
        this.exclusive = false;
        this.holders = new HashSet<String>();
    }

    // Demande en exclusion mutuelle le verrou en mode partagé.
    public synchronized boolean try_shared(String asker) {
        if (exclusive) {return false;}
        this.holders.add(asker);
        return true;
    }

    // Demande en exclusion mutuelle le verrou en mode exclusif.
    public synchronized boolean try_exclusive(String asker) {
        if (this.holders.isEmpty() ||
            (this.holders.size() == 1 && this.holders.contains(asker)))
        {
            this.holders.add(asker);
            this.exclusive = true;
            return true;
        } else {
            return false;
        }
    }

    // Relache en exclusion mutuelle le verrou.
    public synchronized void release(String holder) {
        if (this.holders.contains(holder)) {
            this.holders.remove(holder);
            this.exclusive = false;
        }
    }

}
