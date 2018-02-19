// La classe abstraite des transactions, qui décompose le code
// en la transaction elle-même et sa procédure d'avortement.

public abstract class AbstractTransaction implements Runnable {

    public String name;

    public String getName() {
        return this.name;
    }

    // Lit et écrit à travers la mémoire transactionnelle.
    abstract public void transaction() throws AbortException, InterruptedException;

    // Avorte proprement.
    abstract public void aborted();

    // Gère l'avortement de transaction() avec aborted()
    public void run() {
        try {
            this.transaction();
        } catch (AbortException e) {
            this.aborted();
        } catch (InterruptedException e) {
            System.out.println("C'est dommage!");
        }
    }
}
