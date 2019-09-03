# Ruby

## Quick Review - difference between block/proc/lambda

All this talk of blocks, procs, and lambdas might have your head spinning. Let’s take a minute to clarify exactly what each one is:

* A block is just a bit of code between do..end or {}. It’s not an object on its own, but it can be passed to methods like .each or .select.
* A proc is a saved block we can use over and over.
* A lambda is just like a proc, only it cares about the number of arguments it gets and it returns to its calling method rather than returning immediately.

There are obviously lots of cases in which blocks, procs, and lambdas can do similar work, but the exact circumstances of your program will help you decide which one you want to use.

## Compte-rendu formation (à retravailler)

Formation sur le Framework Rails en présence de Arnaud Morisset, Hugo Fabre et Quentin Buirette, dispensé par Nicolas Cavigneaux 

Les points abordés :
Ruby – Enumerable et Comparable
Active Model
Active Record
Helpers
Mailers
Débogage


I - Enumerable et Comparable

Enumerable et Comparable sont deux modules provenant de Ruby. Les includes de ces modules se nomment des Mix-In.
Souvent lié à un besoin métier, le module Comparable permet notamment de mettre en place le Spaceship operator au sein d’une classe :

	include Comparable

	# Spaceship operator function
	# @return -1, 0 or 1 when <, = or >
	def <=>(other)
		str.size <=> other.str.size
end


Le module Enumerable est lui beaucoup plus complexe et implemente de nombreuses méthodes très utiles, par exemple :

all? et any? --> qui se traduisent par tous ? et au moins ?
chunk -->permet de couper un tableau en sous tableau
even --> récupérer les éléments qui sont pair
collect --> même chose que «map», permet de créer un tableau
flatten --> mettre un tableau à plat
	Il existe aussi «flat-map» qui est plus performant mais qui ne fonctionne que sur deux niveaux seulement.
count --> Compte le nombre d’objet (sans paramètres)
length / size /count --> n’ont pas le même comportement
	Cependant length et size sont équivalent sauf si la collection n’est pas encore chargé. Dans ce cas, size est plus performant.
counter_cache --> à définir
detect = find / select = find_all
include? --> Vérifier si tel élément est inclut
max / min --> avec arguments
max_by --> Comparaison sur paramètres
none? --> Inverse de any?
one? --> Est-ce qu’il en existe un ? return la 1ère occurence
reduce / inject --> à définir
to_a --> Conversion en tableau
to_h --> Conversion en HashTab
take --> Prendre les x premiers éléments d’un tableau
sample --> Fonction random (aléatoire)
take_while --> Récupère les éléments d’un tableau tant que la condition (while) est respectée
zip --> Permet de concaténer 2 tableaux en tableau de 2 dimensions

Il existe de nombreux autres modules disponibles par le biais de Ruby. Cette liste non-exhaustive en présente quelques uns :

Module «etc» --> 
	Fournit des accès au système d’exploitation Linux
https://ruby-doc.org/stdlib-1.9.3/libdoc/etc/rdoc/Etc.html

Module «FileUtils» -->
	Fournit des accès au système de fichier Linux
https://ruby-doc.org/stdlib-1.9.3/libdoc/fileutils/rdoc/FileUtils.html

Module «Json» -->
	Permet de gérer le format JavaScript Object Notation
http://ruby-doc.org/stdlib-2.0.0/libdoc/json/rdoc/JSON.html

Module «Kernel» -->
	Le module Kernel est inclut par la classe Object
https://ruby-doc.org/core-2.3.2/Kernel.html
	NB : Les méthodes du module Kernel soulèvent des exceptions



Il existe également une multitude de Class interne à Ruby dont ces quelques unes :

Logger -->
	Classe qui fournit un utilitaire de Logging permettant de retourner 	 des erreurs avec leurs niveaux d’importance.
http://ruby-doc.org/stdlib-2.1.0/libdoc/logger/rdoc/Logger.html

Thread -->
	Classe permettant de créer et gérer des threads
https://ruby-doc.org/core-2.2.0/Thread.html
	NB : Il ne s’agit pas de Thread système

Net -->
	Classe et module pour gérer les différents protocoles réseaux
http://ruby-doc.org/stdlib-1.9.3/libdoc/net/http/rdoc/Net.html

PathName -->
	Permet d’effectuer des actions sur un fichier et récupérer son Path
https://ruby-doc.org/stdlib-2.1.0/libdoc/pathname/rdoc/Pathname.html


	
























irb  Interpréteur de commandes de Ruby
rails console  Interpréteur de commandes de Rails

Une classe est différente d’un module :
classe : Permet de gérer l’état d’un objet
module : exécute bêtement du code


Différence entre le Require (loadpath) et le Require_relative(Ressource). 
require_relative est un substitut commode du require
Exemple :





Les différents outils pour la doc :
Rdoc  outil interne de génération de doc
Yard  Gem de génération de doc
Dev Docs via Dash ou Zeal  Parcourir la doc hors connexion
NB : Il vaut mieux consulter la doc le plus souvent possible


Principe de Duck Tipping  Peu importe le type injecté en paramètre, Ruby regarde comment ca fonctionne et retourne le même type (sauf si conversion).
Ex : Si ca fait coin-coin, alors c’est un canard


Précision sur les champs concernant les prix :
Il ne faut jamais utiliser des champs de type « float » car pas fiable. On préféra le type décimal ou encore numeric pour Postgres SQL.

Différence entre self et @ :
self  Appel de méthodes sur l’objet
name  Variable locale, existe seuelement dans le block courant
@name  Variable d’instance non accessible depuis l’extérieur
@@name  Variable de classe






ACTIVE RECORD

Active Model :

Active Model est le socle de l’active Record. Par ailleurs, on peut utiliser l’active model sans l’active record si les données n’ont pas vocations à être persistées. 

Active Record est donc une surcouche de Active Model


Dirty Attributes  Permet d’effectuer du tracking de modification d’un objet et de ses attributs, c’est à dire lors de la mise en place d’un historique des modifications (comme les changements d’adresses auprès des organismes par exemple).
Ex : object.changed ?

Les callbacks :

Les callbacks de l’active Model dispense seulement le Framework pour les callbacks.
Les différents callbacks :
After Initialyse
Before / After save
Before / After create
Before / After validation
Before / After delete

NB : Dans Rails, la logique métier, les callbacks et la persistance sont intimement liés

Notion de throw halt  a def

Notion de cache :
Si l’on possède un cache, on peut définir des règles directement par un callback :

After_initialize
After_touch
Belongs_to :company, touch : true
NB : touch ne fonction que avec belongs_to et permet de déprécier le cache

Transaction des callbacks :
Les callbacks vont aussi nous permettre de vérifier l’exécution des requêtes. On veut par exemple sauvegarder le panier d’un utilisateur seulement si l’adresse est correctement persisté en Bdd. Si le panier se persiste mais pas l’adresse, alors on annule les requêtes.

Les conversions :
Chaque table possède un ID unique. Les conversions se chargent par exemple de convertir le nom du model en lowercase afin de répondre aux conventions.
NB : Il existe une méthode pour réécrire les URL ➔ to_param



Les validations :

Permet de valider un ou plusieurs attributs. Par exemple, on veut pouvoir refuser un formulaire si un champ n’est pas rempli. Cf : empty?
NB : Il est plus judicieux de valider un objet plutôt que simplement son id par exemple.

Quelques points concernant les validations :
Il existe des méthodes pour incrémenter ou décrémenter des count, il n’est donc pas nécessaire de réinventer la roue.
La méthode toggle! permet d’inverser les valeurs d’un booléen.
La méthode valid? est très importante, notamment dans la gestion des erreurs.
NB : create et update intègre déjà la méthode valid? dans le cycle des callbacks
full_messages  récupère un tableau de message d’erreur, lié à la méthode valid?
Ex : 
x.valid?
x.error
x.full_messages

Dans certains cas spécifiques, on peut mettre en place un principe de méta-programmation si nécessaire :
On souhaite dans cette exemple renvoyer une erreur si login de l’admin ne commence pas par ‘a’ :

ROLES.each do |role|
define_method :’’#(role) ?’’ { self.role == role }
end

	def check_admin_login
		if admin?
			Error.add( :should_start_with_a) unless login.start_with(a)
		end
	end

validate-associated  Validation si le ou les objets associés sont tous valides. Fonctionne avec tous les types d’association. 
NB: on ne doit surtout pas mettre le validate-associated des deux côtés d’une association, sous peine de créer une boucle infinie ?

uniqueness  Valide si la valeur de l’attribut est unique avant de persister.
with_options  Permet de regrouper des validations dans une condition, si l’utilisateur est admin par exemple.


Naming :

Récupération d’un nom différent en fonction de différentes méthodes
Overriding Naming Conventions :
Permet de changer le nom des tables, etc…



Serialization :

Permet de serializer à notre guise
Translation :
Gère l’ensemble des translations liées aux models


Si un projet web n’a pas la nécessité de créer des comptes utilisateurs ou pour des besoins très léger ne nécessitant pas la mise en place de Devise, on peut mettre en place un simple système de connexion à l’aide de : SecurePassword


Notion de optimistic et pessimiste locking
Permet de ne pas effectuer plusieurs opérations sur le même objet. Il s’agit d’une sorte de Mutex lié à l’active record

Active STI (Single Table Inheritance)
Principe où l’on utilise une seule table à travers plusieurs Classe


Active Resources :

Gérer les ressources externes comme celles provenant des API en REST


Les migrations :

Rails est un Framework très puissant qui simplifie énormément le travail des développeurs. Néanmoins, il faut toujours veiller à l’intégrité du code et des données. C’est pourquoi, lors de la génération de modèles avec relations, il est conseillé de porter une attention particulière sur les contraintes, les index et les valeurs par défaut.
Pour aller toujours plus loin !!!
Attention aux migrations. Il s’agit d’un outil très puissant qui demande une réflexion avant emploie. Par exemple, il est important à des moments du projet de rejouer toutes les migrations afin d’assurer leurs bons fonctionnement.
En outre, lors de l’ajout d’un champ avec une contrainte sur une table existante, il faut veiller à générer une valeur par défaut pour les données déjà présente.
Cf : Architecture des logiciels
Par ailleurs, il est conseillé de mettre en place les Foreign Keys lors des relations one to one, one to many, many to one dans un soucis de garantie des données et notamment pour employer efficacement le : inverse_of. Il s’agit de mettre en place des relations qui peuvent aller dans les deux sens, le but étant d’éviter les appels redondant vers la base de données alors que les données sont déjà chargé (= optimisation du requêtage).

Dans le cas des relations one to one, one to many ou many to one, dans les fichiers des modèles correspondants, il est donc important de préciser au niveau des « belong_to » et des « has_many » l’option « inverse_of ».
Cf : Nested_attributes ➔ inverse_of



Pour les relations many to many, il existe deux types :
Simple
Complexe (avec utilisation de through)


Les associations :

belongs_to  dans le cas d’une liaison one to one ou one to many, belongs_to possède la clé étrangère.
has_one  dans le cas d’une relation one to one
has_many  dans le cas d’une relation many to one ou many to many.
Has_many :through  Dans le cas d’une relation de type many to many seulement. Permet de lier deux tables à travers une troisième et simplifie également l’écriture grâce aux raccourcis. En effet, si une table Document est liée à des paragraphes à travers des sections, on pourra accéder aux paragraphes directement depuis document.
Associations Polymorphique  Permet de lier un model à plusieurs autres par le biais d’une seule association.
NB : belongs_to ne match plus une table mais un symbole polymorphique.
Self Join  Auto référencement, permet de créer une relation au sein d’un même model :



NB : Ici on veillera à ajouter un index manager dans une migration
NBB : Rails 5 intègre automatiquement le validate presence (ici manager)
 


Lors de la génération d’un fichier de migration, on peut utiliser l’option « reversible » qui permet de définir un up et un down dans une partie du fichier de migration…


NB : Postgres possède de nombreuses extensions qui peuvent être activées en fonction des besoins. Il appartient aux développeurs de penser optimisation. Si la base de données peut traiter des données à la place de la surcouche applicative, il est nécessaire de mettre en place ces mécanismes pour améliorer les performances globales.




Les controllers :

Dans un soucis de performance et pour respecter les bonnes pratiques de Rails, les controllers se doivent d’être le plus léger possible.

La logique métier doit se trouver dans les models.

	Les filtres :

before
around
after

On pourrait définir une méthode privée dans l’ Application_controller si le filtre doit agir de manière globale, mais il faut éviter.

On préfèrera créer un concern ou isoler un comportement en fonction d’un segment de l’application. Par exemple, si on met en place un filtre pour l’espace administration d’une application, on pourra créer un controller spécifique qui héritera d’application_controller et qui sera parent de tous les controllers admin nécessitant l’application du filtre.

Dans ce cas précis, on veillera également à créer un dossier dans le dossier controller qui correspondra aux controllers admin.

	Les formats de réponse :

Le Framework rails nous permet de définir des formats de réponse spécifique. On souhaite par exemple envoyer de la data au format json. Il existe plusieurs méthodes permettant de répondre à cette problématique (ex : to_json, has_json…).
NB : pour le format json, il existe la gem jbuilder

On peut en outre créer un layout spécifique à un format, si l’on souhaite exporter au format pdf par exemple.
	
	Les Strong Parameters :

Rails fournit une interface pour protéger les attributs du mass assignment. Néanmoins, il est possible de whitelister ces attributs de manière à pouvoir les utiliser.


Les cookies :

Un cookie possède une taille limitée (+- 4ko). Il ne faut jamais sauvegarder un objet dans un cookie, seulement des primitifs et surtout pas de données critiques.
Il existe néanmoins un moyen de crypter de la data dans les cookies.
Cf : ActionDispatch ::Cookies

Alors que les cookies sont présents côté client, la session est accessible du côté serveur.



Les helpers :

Les helpers sont présents pour répondre aux problématiques liées aux rendus. En effet, on peut y définir des méthode permettant de générer du contenu HTML, ou d’en faciliter l’utilisation (ex : mise en place d’un fil d’arianne, génération de menu…).
Grossièrement, les helpers nous permettent d’intégrer une logique liée à la vue au sein du modèle MVC.


Dégogage :

Présentation de byebug, outil de dégogage en ligne de commande.
Cf : https://hackademy.io/tutoriel-videos/introduction-ruby-le-debogueur


Les Tests :

Les tests sont d’importances cruciales dans un souci de gestion de projet, d’intégration continue et d’évolutivité d’une application.
C’est pourquoi il faut veiller à ajouter / modifier des tests à chaque modification durant le développement. 
En terme d’importance, il faut surtout privilégier les models car ils représentent la logique métier.
Cf : gem mini-test
On peut également écrire des tests spécialisés à l’aide de l’option describe.

NB : Rails 5  Certains tests standard ont été supprimés. Cette prise de position est avant tout du à la mise en avant de tests d’intégration, qui correspondent grossièrement à des tests effectués par des utilisateurs finaux.

Best practices :

On veillera a ne tester seulement que notre code, pas celui provenant de l’extérieur (ex : API externe, gem…). En revanche, on peut tout de même tester les appels aux gems par exemple.

	Mocks et Stubs :
Mocks : Permet de s’assurer des bons appels aux lib avec les bons paramètres et éventuellement avec un return. Un mock est spécifique et lié à un objet afin de vérifier son comportement.
Stubs : Il s’agit de mettre en place une réponse toute faite à un appel de méthode. On ne vérifie plus le comportement de l’objet mais plus le bon fonctionnement des méthodes en retournant une réponse spécifique.









OTHERS 

1 – Sucre syntaxique

Il existe un sucre syntaxique sous Ruby qui permet de raccourcir l’expression d’une méthode

// Exemple d’expression standard
a.max_by { |s| s.size }

// Exemple du sucre syntaxique
a.max_by (&:size)


2 – Range

Range représente l’intervalle entre 2 valeurs

// Range inclusif
(1..9).to_a

// Range exclusif à la dernière occurrence
(1…9).to_a


Attention : Update est différent de Update! :
update : retourne un booléen
update! : lève une exception Raise

Différence entre Destroy et Delete :
destroy : fait appel au Framework Rails (callbacks, etc…)
delete : suppression au niveau SQL seulement

Différence entre Join et Include :
Join : Jointure SQL avec condition sur les objets liés
Include : Préchargement de l’objet lié, utile pour les performances car on évite de requêter à nouveau.
