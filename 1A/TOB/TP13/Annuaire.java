import java.util.*;

public class Annuaire {
	/** Les personnes et leurs bureaux respectifs. */
	private Map<String, String> bureaux;

	/** Construire un annuaire vide. */
	public Annuaire() {
		this.bureaux = new HashMap<>();
	}

	/** Enregistre une nouvelle personne et son bureau */
	public void enregistrerArrivee(String personne, String bureau) {
		if ((personne == null) || (bureau == null)) {
			throw new NullPointerException();
		}

		/* Verification de l'existence de la personne */
		if (this.bureaux.containsKey(personne)) {
			throw new DejaPresentException();
		}

		/* Ajout de la nouvelle personne */
		this.bureaux.put(personne, bureau);
	}

	/** Retourne le bureau occupé par une personne. */
	public String bureau(String personne) {
		if (personne == null) {
			throw new NullPointerException();
		}

		/* Verification de l'existence de la personne */
		if (!this.bureaux.containsKey(personne)) {
			throw new PersonnelInconnuException();
		}

		/* Retourner le bureau occupé */
		return this.bureaux.get(personne);
	}

	/* Modifier le bureau d'une personne */
	public void modifierBureau(String personne, String bureau) {
		if ((personne == null) || (bureau == null)) {
			throw new NullPointerException();
		}

		/* Verification de l'existence de la personne */
		if (!this.bureaux.containsKey(personne)) {
			throw new PersonnelInconnuException();
		}

		/* Ajout de la nouvelle valeur */
		this.bureaux.put(personne, bureau);
	}

	/** Retourne le personnel de l'annuaire. */
	public Set<String> personnels() {
		return this.bureaux.keySet();
	}

	/** Retourne les bureaux occupés de l'annuaire. */
	public Set<String> bureaux() {
		return new HashSet<String>(this.bureaux.values());
	}

	/** Enregistre le départ d'une personne de l'annuaire. */
	public void enregistrerDepart(String personne) {
		if (personne == null) {
			throw new NullPointerException();
		}

		/* Verification de l'existence de la personne */
		if (!this.bureaux.containsKey(personne)) {
			throw new PersonnelInconnuException();
		}
		/* Enregistrement du départ */
		this.bureaux.remove(personne);
	}

	/** Retourne les bureaux et la liste des occupants de l'annuaire. */
	public Map<String, Set<String>> occupationBureaux() {
		Map<String, Set<String>> occupation = new HashMap<>();
		for (Map.Entry<String, String> affectation : this.bureaux.entrySet()) {
			String nom = affectation.getKey();
			String bureau = affectation.getValue();
			Set<String> noms = occupation.get(bureau);
			if (noms == null) {
				noms = new HashSet<>();
				occupation.put(bureau, noms);
			}
			noms.add(nom);
		}
		return occupation;

	}

	/** Retourne les personnes occupant un même bureau. */
	public Set<String> personnels(String bureau) {
		if (bureau == null) {
			throw new NullPointerException();
		}

		Set<String> personnels = new HashSet<String>();
		for (Map.Entry<String, String> affectation : this.bureaux.entrySet()) {
			if (affectation.getValue().equals(bureau)) {
				personnels.add(affectation.getKey());
			}
		}
		return personnels;
	}

}
