Transactions et mémoire transactionnelle
========================

Cette archive contient
- un répertoire `StepByStepSimulation`, correspondant au shell utile pour les sections 3 et 4 du sujet
- un répertoire `FullSimulation` correspondant au simulateur utile pour la section 5 du sujet

Utilisation du shell (`StepByStepSimulation`)
---------------------
- *Compilation* : `make`
- *Exécution* : `make run`

Le fichier scenario0 correspond au premier scénario de la section 3, pour le protocole PP.

*Remarque* : Evitez de soumettre au shell des opérations pour des transactions bloquées.
En effet, le shell se comporte de manière douteuse dans le cas où des opérations lui
sont soumises pour une transaction bloquée : il les accepte quand même (ce qui est laxiste)
puis plante lorsque la transaction est débloquée (ce qui est un vilain bug). 

Utilisation du simulateur (`FullSimulation`)
---------------------
- *Compilation* : `make`
- *Exécution* : `java Main <nom_scénario>`

Les fichiers `scenario1`, `scenario2` et `scenario3` correspondent
aux scénarios proposés dans la section 5.