# PLUGIN LOUP GAROU

[TOC]

## À propos

Le mode Loup-Garou est un mode inspiré du jeu de société [Les Loups-Garous de Thiercelieux](https://fr.wikipedia.org/wiki/Les_Loups-garous_de_Thiercelieux) reprenant son fonctionnement ainsi que sa manière d'être joué, à la seule différence qu'aucun maître du jeu n'est requis, le déroulement de chaque partie étant entièrement automatisé :

- Déroulement de la partie automatisé ;
- Rôles du jeu de base et nouveaux rôles ;
- Utilisable sur n'importe quelle map.

## Développement

Vous devez installer Java et Maven pour le développement du plugin.

Vous devez aussi installer spigot avec BuildTools.jar dans le dossier `lib` (si il n'existe pas, créez-le).

```bash
mkdir lib
cd lib
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
java -jar BuildTools.jar --rev 1.15.1
```

Si vous utilisez l'image docker pour le développement, vous devez installer Docker et docker-compose.
Puis, exécuter les commandes suivantes :

```
docker-compose up --build -d
docker-compose up -d
```

Ensuite vous devez builder le plugin.

```bash
mvn clean install
```

## Installation

### Dépendances requises
- [ProtocolLib](https://www.spigotmc.org/resources/protocollib.1997/)

### Installation classique
**Minecraft 1.15.1 est requis.**  
Pour installer le plug-in, merci de suivre les étapes suivantes:
  - Téléchargez Spigot 1.15.1 ([accessible ici](https://gitlab.papierpain.fr/minecraft/spigot/-/package_files/4/download)) et lancez une fois le serveur
  - Dans le dossier `plugins`, insérez [ProtocolLib](https://www.spigotmc.org/resources/protocollib.1997/) et [LoupGarou.jar](https://gitlab.papierpain.fr/minecraft/plugin-loup-garou/-/package_files/11/download)
  - Redémarrez votre serveur puis donnez vous les permissions administrateur (/op <votre_pseudo> dans la console)
  - Allez sur la map et ajoutez les points de spawn sur chaque dalle `/lg addSpawn`
  - Connectez-vous au serveur et choisissez les rôles à utiliser avec `/lg roles set <ROLE> <MONTANT>`
	  - ⚠️ Il faut qu'il y ait autant de places dans les rôles que de joueur pour lancer une partie
  - Vous pouvez démarrer la partie avec `/lg start <pseudo>` 
	  - ⚠️ N'oubliez pas de mettre votre pseudo. Exemple : `/lg start leomelki` 

### Installation avec docker (Alternative)

> Revoir le process !!!

> **Tip :** Il faut accepter les conditions d'utilisations de Mojang en modifiant le fichier `minecraft_data/eula.txt`

## Commandes

`/lg roles` : Retourne la liste des rôles dans la partie  
`/lg roles set <ID> <MONTANT>` : Définit le nombre de joueurs pour un certain rôle  
`/lg addSpawn` : Ajoute un point de spawn (emplacement de joueur)  
`/lg start <PSEUDO>` : Lance la partie  
`/lg end <PSEUDO>` : Arrête une partie  
`/lg reloadConfig` : Recharge la configuration  
`/lg joinAll` : À utiliser après avoir changé les rôles  

## Crédits

- Chef de Projet : [Shytoos](https://twitter.com/shytoos_)
- Développement : [Leomelki](https://twitter.com/leomelki)
- Mapping : [Cosii](https://www.youtube.com/channel/UCwyOcA41QSk590fl9L0ys8A)

## Aide

Par soucis de temps, nous ne pouvons pas faire de support au cas par cas, mais vous pouvez rejoindre notre serveur [Discord](https://discord.gg/Squeezie) pour trouver de l'aide auprès de la communauté.

### Questions fréquentes

- Que faire en cas de problème d'affichage (votes bloqués au dessus des têtes, etc...) ?  

Cela arrive après avoir `reload` au cours d'une partie, tous les joueurs qui ont ce problème doivent se déconnecter et se reconnecter.

- Pourquoi la partie ne se lance pas ?  

Il faut taper la commande `/lg start <PSEUDO>` en mettant le pseudo d'un des joueurs qui sera présent dans la partie. Si cela ne fonctionne toujours pas, c'est parce qu'il n'y a pas suffisamment de rôles pour le nombre de joueurs, il doit y avoir le même nombre de rôles qu'il y aura de joueurs dans la partie. N'oubliez pas de taper `/lg joinAll` après avoir modifié la liste des rôles.

- J'ai mal placés mes spawns ou je veux utiliser une nouvelle map, comment faire ?  

Il suffit d'ouvrir le fichier `plugins\LoupGarou\config.yml` et de supprimer les points de spawn.

- Puis-je mettre plusieurs fois le même rôle dans une seule partie ?

Cela est possible pour les rôles `Loup-Garou`, `Villageois` et `Chasseur`.
D'autres rôles peuvent aussi marcher mais n'ont pas été testés avec plusieurs joueurs ayant ce rôle dans une seule partie. C'est à vos risques et périls.

- Le tour du loup noir (ou tout autre type de loup garou) ne passe pas.

Il vous faut au minimum un loup garou normal lorsque vous mettez d'autres types de loups dans la partie.

## Indications pour les développeurs

Ce plugin LoupGarou ayant été modifié de nombreuses fois, parfois dans des timings tendus, le code n'est pas très propre. Aussi, il n'est pas documenté.  

Vous devez utiliser `Lombok` et `Maven` pour modifier ce projet. 
Vous devez aussi installer la repository `Spigot` avec [BuildTools](https://www.spigotmc.org/wiki/buildtools/).

**Cependant, si l'envie vous prend de modifier ou d'utiliser le code ici présent en partie, ou dans sa totalité, merci de créditer [Leomelki](https://twitter.com/leomelki) et [Shytoos](https://twitter.com/shytoos_).
Une utilisation commerciale est cependant interdite. Merci de vous référer aux informations de [license](#license)**

### Ajouter des rôles

Ce plugin de Loup-Garou est organisé autour d'un système d'événements, disponibles dans le package `fr.leomelki.loupgarou.events`.  
N'ayant pas le temps de les documenter, vous devriez comprendre vous-même quand ils sont appelés.

Pour vous aider à créer des rôles, copiez des rôles ayant déjà été créés pour ainsi les modifier.

⚠️ Ce projet a été créé de façon à ce que les rôles soient (presque) totalement indépendants du reste du code (LGGame, LGPlayer...).  
Merci de garder cela en tête lors du développement de nouveaux rôles : utilisez un maximum les évènements et, s'il en manque, créez-les !

#### Quelques classes utiles
`LGGame` : Contient le coeur du jeu, à modifier le minimum possible !  
`LGPlayer` : Classe utilisée pour intéragir avec les joueurs et stocker leurs données, à modifier le minimum possible !  
`LGVote` : Système gérant les votes.  
`RoleSort`: Classement de l'apparition des rôles durant la nuit. 

## License
[![License Logo (CC BY-NC)](https://licensebuttons.net/l/by-nc/3.0/88x31.png)](https://creativecommons.org/licenses/by-nc/4.0/legalcode.fr)

Creative Commons BY-NC (https://creativecommons.org/licenses/by-nc/4.0/)

Informations légales : https://creativecommons.org/licenses/by-nc/4.0/legalcode
