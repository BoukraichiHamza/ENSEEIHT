// L'interface des Mémoires Transactionnelles, qui définit leur API.

public interface TMInterface {

    // Ajoute les variables nécessaires à une nouvelle transaction
    // et l'instancie.
    // Renvoie true si la transaction n'existait pas déjà.
    public boolean newTransaction(AbstractTransaction transaction);

    // Essaye de lire un t-objet pour une transaction.
    public int  read(String transaction, String t_object)
                    throws AbortException;

    // Essaye d'écrire dans un t-objet pour une transaction.
    public void write(String transaction, String t_object, int value)
                    throws AbortException;

    // Avorte une transaction.
    public void abort(String transaction)
                    throws AbortException;

    // Essaye de valider une transaction.
    public void commit(String transaction)
                    throws AbortException;

}
