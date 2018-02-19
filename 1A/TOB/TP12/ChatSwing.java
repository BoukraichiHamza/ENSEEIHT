import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import java.util.Observable;
import java.util.Observer;

public class ChatSwing extends JFrame implements Observer {

	/* Modele */
	private Chat chat;

	/* La vue */
	private JTextArea messages = new JTextArea(15, 20);
	private JLabel pseudo = new JLabel();
	private JTextField texte = new JTextField(20);
	private JButton boutonFermer = new JButton("Fermer");
	private JButton boutonOk = new JButton("OK");

	/* Constructeur */
	public ChatSwing(Chat chat, String pseudo) {
		super("Chat de " + pseudo);
		this.chat = chat;
		this.chat.addObserver(this);
		this.pseudo.setText(pseudo);

		Container cont = this.getContentPane();
		cont.setLayout(new BorderLayout());

		/* Construction de la vue */
		cont.add(boutonFermer, BorderLayout.NORTH);
		cont.add(new JScrollPane(messages), BorderLayout.CENTER);

		JPanel discussion = new JPanel(new FlowLayout());
		discussion.add(this.pseudo);
		discussion.add(texte);
		discussion.add(boutonOk);
		cont.add(discussion, BorderLayout.SOUTH);

		/* Listener */
		ActionFermer actionfermer = new ActionFermer();
		ActionOk actionok = new ActionOk();
		this.boutonFermer.addActionListener(actionfermer);
		this.boutonOk.addActionListener(actionok);
		this.texte.addActionListener(actionok);
		this.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		/* Calcul de la taille et affichage */
		this.pack();
		this.setVisible(true);
	}

	/* Fonction update */
	public void update(Observable o, Object arg) {
		messages.append("" + arg + "\n");
	}

	/* Fonction pour fermer */
	public void close() {
		this.chat.deleteObserver(ChatSwing.this);
		this.chat.ajouter(new MessageTexte(this.pseudo.getText(), " s'est déconnecté."));
	}

	public class ActionFermer implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			close();
		}
	}

	public class ActionOk implements ActionListener {
		public void actionPerformed(ActionEvent e) {
			Message newmsg = new MessageTexte(pseudo.getText(), texte.getText());
			texte.setText("");
			chat.ajouter(newmsg);
		}
	}

}
