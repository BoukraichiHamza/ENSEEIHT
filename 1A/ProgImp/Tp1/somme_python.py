#Hamza BOUKRAICHI groupe H
# programme affichant la somme des entiers entre n et m
#Fonction sommation
#Fonction qui calcule la somme des entiers compris entre deux entiers
#m et n entiers
#type retourné entier représentant la somme des entiers
#précondition n>=m>=0
#postcondition Somme>=0
def somme(m,n):
    S=0
    for i in range(m,n+1):
        S=S+i
    return S #S est la valeur retournér de la somme des entiers entre n et m

#Test avec des valeurs constantes
print(somme(5,7))

#Test avec des valeurs lues au clavier
m=int(input("entrer m>=0 "))
n=int(input("entrer n>m>=0 "))
if n<m or m<0:
    print("préconditions non vérifiées")
else :
    print(somme(m,n))
