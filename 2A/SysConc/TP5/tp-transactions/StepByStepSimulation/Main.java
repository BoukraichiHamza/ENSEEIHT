import java.lang.reflect.InvocationTargetException;
import java.io.File;
import java.io.IOException;
import java.io.FileNotFoundException;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.LinkedList;
import java.util.Arrays;
import java.util.ArrayList;
import java.util.Scanner;

// La class principale qui lance la mémoire transactionnelle et
// gère les I/O de la simulation pas à pas.

public class Main {

    static public TMAbstract tm = null;
    static private boolean exit = false;

    // La map liant chaque transaction à la queue bloquante pour lui envoyer
    // des instructions.
    static private Map<String, BlockingQueue<String[]>> instructions =
        new HashMap<String, BlockingQueue<String[]>>();
    // La map liant chaque transaction à la queue bloquante pour recevoir
    // ses réponses.
    static private Map<String, BlockingQueue<String>> responses =
        new HashMap<String, BlockingQueue<String>>();
    // L'ensemble des transactions bloquées.
    static private Set<String> blocked =
        new HashSet<String>();



    public static void main(String[] args)
    throws InterruptedException, IOException, FileNotFoundException {

        Scanner scan = new Scanner(System.in);
        String line;
        String[] commands;

        while (!exit) {
            System.out.print("> ");
            line = scan.nextLine();
            commands = Main.clean(line.split(" "));
            if (commands[0].equals("run")) {
                Scanner reader = new Scanner(new File(commands[1]));
                while(reader.hasNextLine()) {
                    line = reader.nextLine();
                    System.out.println("> "+line);
                    commands = Main.clean(line.split(" "));
                    System.out.println(Main.handle(commands));
                }
            } else {
                System.out.println(Main.handle(commands));
            }
        }

        System.exit(0);
    }


    // Une fonction qui enlève les String vides d'un tableau
    // de string (pour le parsing.
    public static String[] clean(String[] dirty) {
        List<String> clean =
            new ArrayList<String>(Arrays.asList(dirty));
        clean.removeAll(Arrays.asList(""));
        return clean.toArray(new String[clean.size()]);
    }



    // Vérifie la bonne forme des instructions et les envoie à la
    // mémoire transactionnelle.
    private static String handle(String[] commands)
    throws InterruptedException, IOException, FileNotFoundException {
        String output = null;
        switch (commands[0]) {
            case "exit" :
                Main.exit = true;
                output = "Arrêt de la mémoire transactionnelle.";
                break;
            case "init" :
                if (commands.length < 3) {
                    output = "L'initialisation a la forme 'init <tm> (t_object,valeur)'.";
                } else {
                    try {
                        Class<? extends TMAbstract> classTM =
                           Class.forName(commands[1]).asSubclass(TMAbstract.class);
                        Class<?>[] classArgs = {Map.class};
                        Map<String,Integer> t_objects = new HashMap<String,Integer>();
                        String buffer = null;
                        String[] buffers = null;
                        for (int i = 2; i < commands.length ; i++) {
                            buffer = commands[i];
                            buffers = buffer.replaceAll("[()]", "").split(",");
                            t_objects.put(buffers[0],Integer.parseInt(buffers[1]));
                        }
                        tm = classTM.getDeclaredConstructor(classArgs)
                                    .newInstance(t_objects);
                        Main.instructions =
                            new HashMap<String, BlockingQueue<String[]>>();
                        Main.responses =
                            new HashMap<String, BlockingQueue<String>>();
                        Main.blocked =
                            new HashSet<String>();
                        output = "Initialisation de la mémoire transactionnelle.";
                    } catch (ClassNotFoundException | ClassCastException e) {
                        output =
                            "Cette classe de mémoire transactionnelle n'existe pas.";
                        output += "\nLes choix possibles sont " + Arrays.toString(Main.findDerivedClasses("TMAbstract"));
                    } catch (NumberFormatException e) {
                        output =
                            "Les t_objets contiennent un entier.";
                    } catch (NoSuchMethodException |
                             InstantiationException |
                             IllegalAccessException |
                             InvocationTargetException e) {
                        output = "Erreur d'instanciation.";
                    }
                }
                break;
            case "new" :
                if (commands.length != 2) {
                    output =
                        "L'ajout de transaction a la forme 'new <transaction>'";
                } else {
                    instructions.put(commands[1],
                                     new LinkedBlockingQueue<String[]>());
                    responses.put(commands[1],
                                  new LinkedBlockingQueue<String>());
                    if (!tm.newTransaction(new SimulatedTransaction(
                                          commands[1],
                                          Main.tm,
                                          instructions.get(commands[1]),
                                          responses.get(commands[1]))))
                    {
                        output = "Nom déjà pris.";
                    } else {
                        output = "Transaction "+commands[1]+" créée.";
                    }
                }
                break;
            case "help" :
                output =
                    "La liste des commandes disponibles est :\n"+
                    "  - 'init <tm> (t_object,valeur)' permet d'instancier une mémoire "+
                    "transactionnelle de la classe donnée avec les noms d'objets "+
                    "fournis. Choix possibles pour <tm>: "+
                    Arrays.toString(Main.findDerivedClasses("TMAbstract"))+"\n"+
                    "  - 'new <transaction>' permet de créer une transaction.\n"+
                    "  - 'list' permet de lister les transactions et les objets.\n"+
                    "  - '<transaction> read <t_objet>' permet à une transaction "+
                    "de lire l'entier stocké dans un objet.\n"+
                    "  - '<transaction> write <t_objet> <valeur' permet "+
                    "à une transaction d'écrire dans un objet.\n"+
                    "  - '<transaction> commit' permet à une transaction "+
                    "de se valider.\n"+
                    "  - '<transaction> abort' permet à une transaction "+
                    "de s'avorter.\n"+
                    "  - 'exit' permet de quitter le simulateur.";
                break;
            case "list" :
                if (commands.length != 1) {
                    output =
                        "La liste des transactions et t_objets a la forme 'list'";
                } else if (Main.tm == null) {
                    output = "La mémoire transactionnelle n'a pas encore été créée!";
                } else {
                    Set<String> transactions = Main.tm.getTransactions();
                    Map<String,Integer> t_objects = Main.tm.getTObjects();
                    output =
                        "Transactions : "+Main.tm.getTransactions()
                                                 .toString()
                                                 .replaceAll("\\[", "")
                                                 .replaceAll("\\]", "")+"\n"+
                        "T_Objets :";
                    for (String t_object : t_objects.keySet()) {
                        output = output+"\n"+t_object+" "+t_objects.get(t_object);
                    }
                }
                break;
            default :
                if ((Main.tm != null) &&
                    (Main.tm.getTransactions().contains(commands[0]))) {
                    Main.instructions
                    .get(commands[0])
                    .put(Arrays
                         .copyOfRange(commands,1,commands.length)
                        );
                    Thread.sleep(100);
                    output = Main.responses.get(commands[0]).poll();
                    if (output == null) {
                        output = commands[0]+" bloquée";
                        Main.blocked.add(commands[0]);
                    }
                } else {
                    output = "Commande invalide.";
                }
                break;
        }
        String waitedOutput = null;
        for (String transaction : Main.blocked) {
            waitedOutput = Main.responses.get(transaction).poll();
            if (waitedOutput != null) {
                System.out.println(transaction+" débloquée : "+waitedOutput);
                Main.blocked.remove(transaction);
            }
        }
        return output;
    }

    /**
     * @brief Given a class name it finds all the classes that can be instantiated and that
     * derive from it. It only looks for .class files in the current directory.
     * @param baseClassName The name of the base class.
     * @return The list of classes derived from the input class.
     */
    static String[] findDerivedClasses(String baseClassName)
    {
        List<String> classList = new LinkedList<String>();
        // get the list of files
        String[] files = (new File(".")).list();
        // The base class from which the different policy must derive
        Class<?> interf = null;
        try {
            interf = Class.forName (baseClassName);
        } catch (ClassNotFoundException e) {
            System.err.println ("Panic: ne trouve pas l'interface "+baseClassName+" :"+e);
            System.exit (1);
        }
        // look for the classes deriving from the give base class
        for (int i = 0; i < files.length; i++) {
            Class<?> implementation;
            final String extension = ".class";
            if (files[i].endsWith(extension)) {
                String classname = files[i].substring (0, files[i].length()-extension.length());
                try {
                    implementation = Class.forName (classname);
                } catch (ClassNotFoundException e) {
                    implementation = null;
                }
                // add it to the list if it exists and it is a derived class 
                if ((implementation != null) && 
                		(! classname.equals(baseClassName)) && 
                		interf.isAssignableFrom (implementation)) {
                    classList.add (classname);
                }
            }
        }
        // if it is empty there's something wrong...
        if (classList.isEmpty()) {
            System.out.println ("Aucune implantation de "+baseClassName+" trouvee !");
            System.exit (1);
        }
        return classList.toArray (new String[0]);
    }
}
