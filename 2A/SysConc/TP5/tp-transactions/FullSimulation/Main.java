import java.lang.reflect.InvocationTargetException;

import java.io.IOException;
import java.io.FileNotFoundException;
import java.io.File;
import java.util.concurrent.ExecutionException;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.NoSuchElementException;

import java.util.Collections;
import java.util.Set;
import java.util.HashSet;
import java.util.Map;
import java.util.HashMap;
import java.util.List;
import java.util.LinkedList;
import java.util.Arrays;
import java.util.ArrayList;

import java.util.Random;

import java.util.Scanner;

// La class principale qui lance la mémoire transactionnelle et
// gère les I/O de la simulation pas à pas.

public class Main {

    // La mémoire transactionnelle
    static public TMAbstract tm = null;

    // Le générateur de nombres aléatoires qui permet de simuler
    // des écritures.
    static private Random rand = new Random();

    // L'horloge globale
    static private int clock = 0;
    // La map liant chaque transaction au temps qu'elle a gaspillé.
    static private Map<String,Integer> useless =
        new HashMap<String,Integer>();
    // La map liant chaque transaction à la valeur de l'horloge lorsqu'elle
    // s'est bloquée.
    static private Map<String,Integer> whenBlocked =
        new HashMap<String,Integer>();
    // La map liant chaque transaction au temps qu'elle a passé bloquée.
    static private Map<String,Integer> blocked =
        new HashMap<String,Integer>();
    // La map liant chaque transaction au temps qu'elle a utilisé
    // utilement.
    static private Map<String,Integer> useful =
        new HashMap<String,Integer>();

    // La map liant chaque transaction à sa séquence d'actions
    static private Map<String,Map<Integer,String[]>> init =
        new HashMap<String,Map<Integer,String[]>>();

    // La map liant chaque transaction à sa séquence d'actions en
    // attente (s'il est bloqué).
    static private Map<String,Map<Integer,String[]>> afterBlocking =
        new HashMap<String,Map<Integer,String[]>>();
    // La map liant les instants de l'horloge aux actions de transactions
    // qui s'y déroulent.
    static private Map<Integer,Map<String,String[]>> planning =
        new HashMap<Integer,Map<String,String[]>>();
    // La map liant chaque transaction à son état actuel.
    static private Map<String, TransactionState> states =
        new HashMap<String, TransactionState>();

    // La map liant chaque transaction à la queue bloquante permettant de
    // lui envoyer des instructions.
    static private Map<String, BlockingQueue<String[]>> instructions =
        new HashMap<String, BlockingQueue<String[]>>();
    // La map liant chaque transaction à la queue bloquante permettant de
    // recevoir ses réponses.
    static private Map<String, BlockingQueue<String>> responses =
        new HashMap<String, BlockingQueue<String>>();



    public static void main(String[] args)
        throws InterruptedException, IOException, FileNotFoundException {

        try {
            Main.parse(new File(args[0]));
        } catch (ClassNotFoundException | ClassCastException err) {
            System.out.println(
                    "Cette classe de mémoire transactionnelle n'existe pas.");
            System.exit(0);
        } catch (NumberFormatException err) {
            System.out.println(
                    "Les t_objets contiennent un entier.");
            System.exit(0);
        } catch (NoSuchMethodException |
                InstantiationException |
                IllegalAccessException |
                InvocationTargetException err) {
            System.out.println("Erreur d'instanciation.");
            System.exit(0);
        } catch (NoSuchElementException err) {
            System.out.println(
                    "Le fichier de spécification doit respecter la forme donnée"+
                    "dans le sujet.");
            System.exit(0);
        }

        int min = 0;
        String output = null;
        Set<String> toWait = null;
        while (!Main.planning.isEmpty() ||
               Main.states.containsValue(TransactionState.RUNNING))
        {
            min = Collections.min(Main.planning.keySet());
            Main.clock = min;
            System.out.println("Temps "+min);
            for (String transaction : Main.planning.get(min).keySet()) {
                Main.simulate(transaction,
                              Main.planning.get(min)
                                           .get(transaction));
            }
            Thread.sleep(100);
            toWait =
                new HashSet<String>(Main.planning.get(min).keySet());
            toWait.addAll(Main.afterBlocking.keySet());
            for (String transaction : toWait) {
                output = Main.responses.get(transaction).poll();
                if (output != null) {
                    System.out.println(transaction+" : "+output);
                } else {
                    System.out.println(transaction+" bloquée");
                }
                Main.updateState(transaction, output);
            }
            Main.planning.remove(min);
        }

        Main.display();

    }


    public static void parse(File spec)
    throws FileNotFoundException, ClassNotFoundException, ClassCastException,
           NumberFormatException, NoSuchMethodException, InstantiationException,
           IllegalAccessException, InvocationTargetException,
           NoSuchElementException
    {
        Scanner scan = new Scanner(spec);
        String line = null;
        String[] splitLine = null;
        String[] header = null;
        String[] commands = null;

        // Parser la ligne d'initialisation.
        line = scan.nextLine();
        splitLine = Main.clean(line.split(" "));
        Class<? extends TMAbstract> classTM =
            Class.forName(splitLine[0]).asSubclass(TMAbstract.class);
        Class<?>[] classArgs = {Map.class};
        Map<String,Integer> t_objects = new HashMap<String,Integer>();
        for (int i = 1; i < splitLine.length ; i++) {
            t_objects.put(splitLine[i],0);
        }
        tm = classTM.getDeclaredConstructor(classArgs)
            .newInstance(t_objects);


        // Parser le reste du fichier.
        String name = null;
        String type = null;
        String[] command = null;
        int offset;


        while(scan.hasNextLine()) {
            line = scan.nextLine();
            splitLine = line.split(":");
            header = Main.clean(splitLine[0].split(" "));
            commands = Main.clean(splitLine[1].split(";"));

            name = header[0];
            type = header[1];

            instructions.put(name,
                    new LinkedBlockingQueue<String[]>());
            responses.put(name,
                    new LinkedBlockingQueue<String>());
            if (type.equals("S")) {
                tm.newTransaction(new SimulatedSuperTransaction(
                            name,
                            Main.tm,
                            instructions.get(name),
                            responses.get(name),
                            rand));
            } else {
                tm.newTransaction(new SimulatedTransaction(
                            name,
                            Main.tm,
                            instructions.get(name),
                            responses.get(name),
                            rand));
            }
            states.put(name,TransactionState.RUNNING);

            offset = 1;
            Main.init.put(name, new HashMap<Integer,String[]>());
            for (int i=0; i < commands.length; i++) {
                command = Main.clean(commands[i].split(" "));

                if (command[0].equals("process")) {
                    offset += Integer.parseInt(command[1]);
                } else {
                    Main.init.get(name).put(offset,command);
                    if (!planning.containsKey(offset))
                    {
                        Main.planning.put(offset,
                                new HashMap<String,String[]>());
                    }
                    Main.planning.get(offset).put(name,command);
                    offset++;
                }
            }

            Main.useless.put(name,0);
            Main.useful.put(name,0);
            Main.blocked.put(name,0);
        }
    }



    // Une fonction qui enlève les String vides d'un tableau
    // de string (pour le parsing.
    public static String[] clean(String[] dirty) {
        List<String> clean =
            new ArrayList<String>(Arrays.asList(dirty));
        clean.removeAll(Arrays.asList(""));
        return clean.toArray(new String[clean.size()]);
    }



    // Envoie les instructions à la mémoire transactionnelle.
    private static void simulate(String transaction, String[] command)
        throws InterruptedException, IOException, FileNotFoundException
    {
        String output = null;
        if (Main.states.get(transaction) != TransactionState.ABORTED) {
            Main.instructions
                .get(transaction)
                .put(command);
        }
    }



    // Met à jour l'état de la transaction.
    public static void updateState(String transaction, String output) {
        if (output == null &&
            Main.states.get(transaction) != TransactionState.BLOCKED)
        {
            Main.block(transaction);
        } else if (output != null &&
                   Main.states.get(transaction).equals(TransactionState.BLOCKED))
        {
            Main.unblock(transaction);
        } else if (output != null && output.contains("relancée")) {
            Main.relaunch(transaction);
        } else if (output != null && output.contains("avortée")){
            Main.abort(transaction);
        } else if (output != null && output.contains("validée")) {
            Main.commit(transaction);
        }
    }



    // Enlève du planning les instructions restantes d'une transaction
    // bloquée.
    private static void block(String transaction) {
        Main.afterBlocking.put(transaction, new HashMap<Integer,String[]>());
        for (Integer time : Main.planning.keySet()) {
            if (time != Main.clock &&
                Main.planning.get(time).containsKey(transaction))
            {
                Main.afterBlocking.get(transaction)
                            .put(time - Main.clock,
                                 Main.planning.get(time).remove(transaction));
            }
        }

        Main.states.put(transaction,TransactionState.BLOCKED);
        Main.whenBlocked.put(transaction,Main.clock);
    }



    // Remet dans le planning les instructions restantes d'une transaction
    // débloquée.
    private static void unblock(String transaction) {

        for (Integer time : Main.afterBlocking.get(transaction).keySet()) {
            int newTime = Main.clock+time;
            if (Main.planning.containsKey(newTime)) {
                Main.planning.get(newTime)
                    .put(transaction,
                            Main.afterBlocking.get(transaction).get(time));
            } else {
                Main.planning.put(newTime, new HashMap<String,String[]>());
                Main.planning.get(newTime)
                    .put(transaction,
                            Main.afterBlocking.get(transaction).get(time));
            }
        }

        Main.states.put(transaction,TransactionState.RUNNING);
        if (Main.blocked.containsKey(transaction)) {
            Main.blocked.put(transaction,
                             Main.blocked.get(transaction)+
                             (Main.clock - Main.whenBlocked.get(transaction)));
        } else {
            Main.blocked.put(transaction,
                             Main.clock - Main.whenBlocked.get(transaction));
        }

        Main.afterBlocking.remove(transaction);
    }



    // Met à jour le planning lorsqu'une superTransaction est relancée.
    private static void relaunch(String transaction) {
        for (Integer time : Main.planning.keySet()) {
            if (time != Main.clock) {
                Main.planning.get(time).remove(transaction);
            }
        }

        for (Integer time : Main.init.get(transaction).keySet()) {
            int newTime = Main.clock+time;
            if (Main.planning.containsKey(newTime)) {
                Main.planning.get(newTime)
                    .put(transaction,
                            Main.init.get(transaction).get(time));
            } else {
                Main.planning.put(newTime, new HashMap<String,String[]>());
                Main.planning.get(newTime)
                    .put(transaction,
                            Main.init.get(transaction).get(time));
            }
        }

        Main.useless.put(transaction,Main.clock);
    }


    // Avorte proprement une transaction.
    private static void abort(String transaction) {
        for (Integer time : Main.planning.keySet()) {
            if (time != Main.clock) {
                Main.planning.get(time).remove(transaction);
            }
        }

        Main.states.put(transaction,TransactionState.ABORTED);
        Main.useless.put(transaction,Main.clock);
    }


    // Valide proprement une transaction.
    private static void commit(String transaction) {
        Main.states.put(transaction,TransactionState.COMMITTED);
        Main.useful.put(transaction,
                        Main.clock-
                        (Main.useless.get(transaction)
                         +Main.blocked.get(transaction)));
    }



    // Affiche les résultats de la simulation.
    public static void display() {

        int minTime = 0;
        int seqTime = 0;

        System.out.print(System.lineSeparator());

        for (String transaction : Main.states.keySet()) {
            switch (Main.states.get(transaction)) {
                case COMMITTED:
                    System.out.println("Transaction "+transaction+" validée");
                    break;
                case ABORTED:
                    System.out.println("Transaction "+transaction+" avortée");
                    break;
            }
            System.out.println(
                    Main.useless.get(transaction)+" unités de temps gaspillées");
            System.out.println(
                    Main.blocked.get(transaction)+" unités de temps attendues");
            System.out.println(
                    Main.useful.get(transaction)+" unités de temps utiles");

            minTime = Math.max(minTime,
                               Collections.max(Main.init.get(transaction)
                                                        .keySet()));
            seqTime += Collections.max(Main.init.get(transaction).keySet());
        }

        System.out.print(System.lineSeparator());

        System.out.println("Temps total : "+Main.clock);
        System.out.println("Temps optimal : "+minTime);
        System.out.println("Temps séquentiel : "+seqTime);

    }
}
