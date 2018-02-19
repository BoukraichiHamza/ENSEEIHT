import java.util.concurrent.BlockingQueue;
import java.util.Random;

// Une transaction qui attend des instructions et renvoie des
// réponses. Elle sert à simuler pas à pas les accès concurrents
// à la mémoire transactionnelle.

public class SimulatedTransaction extends AbstractTransaction {

    private TMAbstract tm;
    // La queue bloquante pour recevoir des instructions.
    public BlockingQueue<String[]> instructions;
    // La queue bloquante pour renvoyer le résultat de l'opération.
    public BlockingQueue<String> response;
    // Un booléen de sortie de boucle.
    private boolean committed;
    // Un générateur de nombres aléatoires pour simuler les écritures.
    private Random rand;

    public SimulatedTransaction(String name,
                                TMAbstract tm,
                                BlockingQueue<String[]> instructions,
                                BlockingQueue<String> response,
                                Random rand) {
        this.name = name;
        this.tm = tm;
        this.instructions = instructions;
        this.response = response;
        this.committed = false;
        this.rand = rand;
    }

    // Traite la commande reçue.
    public void handle(String[] instruction) throws AbortException {
        try {
            String responseTM = null;
            switch (instruction[0]) {
                case "read" : if(instruction.length == 2 &&
                                  this.tm.getTObjects().keySet().contains(instruction[1]))
                              {
                                  responseTM = instruction[1]+
                                               " -> "+
                                               this.tm.read(this.name,
                                                            instruction[1]);
                              } else {
                                  responseTM = "La lecture "
                                               + "a la forme "
                                               + "'<transaction read "
                                               + "<t_object>'";
                              }
                              break;
                case "write" : if(instruction.length == 2 &&
                                   this.tm.getTObjects().keySet().contains(instruction[1]))
                               {
                                   int value = this.rand.nextInt(100);
                                   this.tm.write(this.name,
                                                 instruction[1],
                                                 value);
                                   responseTM = instruction[1]+
                                                " <- "+
                                                value;
                               } else {
                                   responseTM = "L'écriture "
                                                + "a la forme "
                                                + "'<transaction> write "
                                                + "<t_object>'";
                               }
                               break;
                case "commit" : if(instruction.length == 1) {
                                    this.tm.commit(this.name);
                                    responseTM = this.name + " validée";
                                    this.committed = true;
                                } else {
                                    responseTM = "La validation a la forme "+
                                                 "'<transaction> commit'";
                                }
                                break;
                case "abort" : this.tm.abort(this.name);
                               break;
            }
            this.response.put(responseTM);
        } catch (InterruptedException e) {
            System.out.println("Interruption de la transaction "+this.getName());
        }
    }


    public void transaction() throws AbortException {
        try {
            while (!committed) {
                String[] instruction = this.instructions.take();
                this.handle(instruction);
            }
        } catch (InterruptedException e) {
            System.out.println("Interruption de la transaction "+this.getName());
        }
    }


    public void aborted() {
        try {
            this.response.put(this.name + " avortée");
        } catch (InterruptedException e) {
        }
    }


}
