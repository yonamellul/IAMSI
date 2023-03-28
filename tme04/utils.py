import time
import os


# #### Fonctions utiles


def equipe(fichier_noms, num):
    '''
    renvoie le nom de l'equipe numéro num
    '''
    f = open(fichier_noms, "r")
    lines = f.readlines()
    nom = lines[num]
    return nom[:len(nom)-1]

def decoderListe(liste, nE):
    for elem in liste:
        j,x,y = decodage(elem, nE)
        print(elem, " : jour", j,", equipe", x, " vs. equipe", y)

def creerCNF(nE, nJ, chemin="./championnat.cnf"):

    f = open(chemin, "w")
    title = "c title\n"
    nl = "c\n"
    intro = "p cnf " + str(nbVar(nE, nJ)) +" "+ str(nbClauses(nE, nJ))+ "\n"
    c = encoder(nE,nJ)
    f.writelines([title, nl, intro, c])
    f.close()
    
def nbVar(nE, nJ):
    return nJ*nE*(nE-1)

def getK(nE, nJ, j, x, y):
    return j*nE**2 + x*nE + y + 1

def decodage(k, nE):
    k = k-1
    y = k%nE
    k = k//nE
    x = k%nE
    j = k//nE
    
    return j, x, y

def atLeastOne(liste):
    res = ""
    for elem in liste:
        res+= str(elem) +" "
    res += "0\n"
    return res 

def atMostOne(liste):
    n = len(liste)
    res = ""
    for i in range(n):
        for j in range(i, n):
            if i != j:
                res += str(-liste[i]) + " " + str(-liste[j]) + " 0\n"
                
    return res

def encoderC1(nE, nJ):
    res = ""
    for j in range(nJ):
        for x in range(nE):
            liste = []
            for y in range(nE):
                if x != y:
                    liste.append(getK(nE, nJ, j, x, y))
                    liste.append(getK(nE, nJ, j, y, x))

                    
            res += atMostOne(liste)
            
    return res


def nbClausesC1(nE, nJ):
    return int(nJ * nE * ((2*nE-2) * (2*nE -3))/2)

def encoderC2(nE, nJ):
    res = ""
    l1 = []
    l2 = []
    for equipe in range(nE):        
        for y in range(equipe, nE):
            l1 = []
            l2 = []
            if equipe != y:
                for j in range(nJ):
                    l1.append(getK(nE, nJ, j, equipe, y))
                    l2.append(getK(nE, nJ, j, y, equipe))
            
                res += atLeastOne(l1) + atMostOne(l1)
                res += atLeastOne(l2) + atMostOne(l2)
    return res

def nbClausesC2(nE, nJ):
    return int(nE*(nE-1) * (1+((nJ*(nJ-1))/2)))

def encoder(nE, nJ):
    return "c contraintes de types C1\n"+encoderC1(nE, nJ) +"c contraintes de types C2\n"+ encoderC2(nE, nJ)


def nbClauses(nE, nJ):
    return nbClausesC1(nE, nJ) + nbClausesC2(nE, nJ)

def decoder(ficher, nE, nJ, fichier_noms= None):
    res = ""
    file = open(ficher, "r")
    ligne = file.readline()
    if ligne == "UNSAT\n":
        return None
    else:
        words = ligne.split()
        for w in words[:len(words)-1]:
            if w != 'c':
                i = int(w)
                if i>0 and w:
                    j,x,y = decodage(i, nE)
                    res+= "Le "+str(j+1)
                    if j == 0:
                        res += "er jour"
                    else:
                        res += "ème jour"
                    if fichier_noms != None:
                        res += ", l'équipe "+equipe(fichier_noms, x)+" affrontera l'équipe "+equipe(fichier_noms, y)+" à domicile. \n"
                    else:
                        res += ", l'équipe "+str(x+1)+" affrontera l'équipe "+str(y+1)+" à domicile. \n"

    file.close()
    return res

def optimiser_nJ(nE_min = 1, nE_max = 4):
  
    nJ_best = [0 for i in range( nE_max - nE_min + 1 )] 
    
    for nE in range( nE_min, nE_max + 1 ):
        t_start = time.time()
        nJ = 1
        while time.time() - t_start < 10:
            source = "./championnat.cnf" #source tmp
            dest = "./championnat.txt" #destination tmp
            creerCNF(nE, nJ)
            commande = "glucose -model "+source+" "+dest
            os.system(commande)

            if decoder('./championnat.txt', nE, nJ) != None:
                nJ_best[ nE - nE_min ] = nJ
                break
            nJ += 1
            
    return nJ_best


