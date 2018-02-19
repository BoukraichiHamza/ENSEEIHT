import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;

// La classe abstraite des Mémoires Transactionnelles, qui
// définit les variables obligatoires.

public abstract class TMAbstract implements TMInterface {

    // La map liant les noms des t_objets à leurs valeurs.
    public Map<String,Integer> t_objects;
    // L'ensemble des noms de transactions en cours.
    public Set<String> transactions;

    // Retourne l'ensemble des noms de transactions en cours.
    public Set<String> getTransactions() {
        return new HashSet<String>(this.transactions);
    }

    // Retourne l'ensemble des noms de t_objets.
    public Map<String,Integer> getTObjects() {
        return new HashMap<String,Integer>(this.t_objects);
    }

}
