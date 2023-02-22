from utils import * 

nE = int(input("Entrez le nombre d'équipes qui participent au championnat: "))
nJ = int(input("Entrez le nombre de jours du championnat: "))
names = input("Avez-vous un fichier contenant les noms d'équipes (y/n) ? ")
if names == 'y':
    fichier_noms = input("Entrez le chemin menant au fichier des noms d'équipes: ")
else :
    fichier_noms= None


source = "./championnat.cnf"
dest = "./championnat.txt"
    
creerCNF(nE, nJ) # par défaut dans championnat.cnf
    
commande = "glucose -model "+source+" "+dest
os.system(commande)
res = decoder(dest, nE, nJ, fichier_noms)
if res != None:
    print(res)
else:
    print("Cette théorie n'est pas satisfiable :(")


exit(0)