# vps
Sécurisez votre serveur dédidé (VPS) de manière optimale

Utiliser ce script pour changer rapidement le port par défaut et créer un utilisateur sudo sur votre serveur.

Utilisez ce script seulement en tant que `root`

## Options
#### Change le port par défaut du serveur
#### Désactive la connexion au serveur en tant que `root`
#### Création d'utilisateur sudo


### Installation
```bash
	apt-get update
	apt-get install git
	cd /opt/
	git clone https://github.com/camoo/vps.git
  ```

### Utilisation
```bash
	cd /opt/vps
	./my_server.sh -p 100 -u sudo_user --passwd sercret
  ```
### Test
Cette commande doit être lancée depuis votre machine locale
```bash
	ssh -p100 sudo_user@_votre_IP
  ```

Pour en savoir plus sur la connexion par clé publique/privée pour plus de sécurité lisez l'article suivant: [Sécurisez votre serveur dédidé (VPS) de manière optimale](https://www.camoo.hosting/blog/13/securisez-votre-serveur-dedie.html)
