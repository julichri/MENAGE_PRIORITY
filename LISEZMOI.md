# Priorité du ménage — installation très simple

## 1. Créer le petit espace de données gratuit
1. Ouvrez **supabase.com**, créez un compte gratuit puis cliquez **New project**.
2. Donnez un nom à votre projet, choisissez un mot de passe de base de données et une région proche de chez vous. Attendez que le projet soit prêt.
3. Dans le menu gauche, ouvrez **SQL Editor**, puis **New query**.
4. Ouvrez le fichier `schema.sql` de ce dossier avec un éditeur de texte, sélectionnez tout et copiez. Collez le texte dans SQL Editor puis cliquez **Run**. Les tables sont créées ou mises à jour sans doublonner les colonnes; `disponibilites` et ses politiques RLS sont également créées de manière idempotente.
5. Dans Supabase, ouvrez **Project Settings** (roue dentée) → **API**. Copiez **Project URL** et la clé publique **anon / publishable** (pas la clé `service_role` ni une clé secrète).

> **Mise à jour d’une installation existante :** il faut relancer le fichier complet `schema.sql` dans **Supabase → SQL Editor → New query → Run** pour créer/mettre à jour les colonnes de tâches et la table `disponibilites`. Cette opération est idempotente et conserve les politiques RLS.

## 2. Mettre l’application en ligne
**Option Netlify Drop (la plus simple)**
1. Allez sur **app.netlify.com/drop** et connectez-vous ou créez un compte.
2. Décompressez le fichier ZIP sur votre ordinateur. Faites glisser le dossier qui contient directement `index.html`, `manifest.json`, `sw.js`, `schema.sql`, `LISEZMOI.md` et `icon.svg` sur la zone Netlify Drop.
3. Netlify vous donne une adresse publique qui finit par `netlify.app`. Ouvrez-la.

**Ou GitHub Pages**
1. Créez un compte sur **github.com**, puis créez un nouveau dépôt public.
2. Envoyez les six fichiers contenus dans ce ZIP à la racine du dépôt (ouvrez le ZIP avant de téléverser).
3. Dans le dépôt, allez dans **Settings → Pages**. Sous **Build and deployment**, choisissez **Deploy from a branch**, la branche `main` et le dossier `/ (root)`, puis **Save**.
4. Attendez la publication. L’adresse du site apparaît dans la page Pages. Ouvrez-la.

## 3. Relier Supabase et commencer
1. Dans l’application, allez à **Réglages**.
2. Collez le **Project URL** dans le premier champ et la clé **anon / publishable** dans le second.
3. Cliquez **Tester la connexion**. Si le test réussit, c’est prêt. La connexion est mémorisée sur cet appareil.
4. Ajoutez les personnes dans **Membres** et évaluez ensemble les tâches. Sept exemples sont ajoutés automatiquement lorsque la table des tâches est vide : corvées quotidiennes ou récurrentes et jeu en famille.
5. Dans **Tâches**, ajoutez ou modifiez le temps par occurrence, la fréquence, la personne responsable, le type, les jours préférés et le créneau préféré (matin, midi, après-midi, soir ou indifférent). L’estimation hebdomadaire est affichée.
6. Dans **Disponibilités**, définissez pour chaque personne les plages libres de 30 minutes, du lundi au dimanche, de 8 h à 22 h. Touchez ou faites glisser sur la grille (tactile ou souris) pour cocher/décocher. Le motif se répète chaque semaine par défaut; décochez l’option pour une disponibilité ponctuelle. Les états sont conservés sur l’appareil et dans le JSON `members.availability` de Supabase.
7. Le planning place une tâche uniquement dans une plage contiguë libre suffisante, par pas de 30 minutes; une tâche plus longue que les plages libres reste non planifiée. Il indique les tâches non placées et signale une journée sans disponibilité; les quotidiennes sont proposées chaque jour seulement si un créneau est utilisable. Les tâches récurrentes gardent un espacement et les loisirs privilégient vendredi soir/week-end. **Régénérer** refait la proposition. Les coches sont locales à l’appareil et à la semaine ISO courante.
7. L’onglet **Compte rendu** classe les priorités, affiche la durée hebdomadaire, le responsable et le type, montre le détail par personne et permet de copier un résumé.

## Disponibilités et mise à jour
- Grille par membre : 7 jours en colonnes et 28 lignes de 30 minutes de 8 h à 22 h. Touchez ou faites glisser à la souris ou au doigt pour sélectionner/désélectionner. Les anciens créneaux sont migrés ainsi : Matin 8–11 h, Midi 11–14 h, Après-midi 14–18 h, Soir 18–22 h. Le format Supabase existant `members.availability` (JSONB) est conservé; le JSON contient désormais les 7 tableaux de 28 demi-heures. Le réglage de répétition hebdomadaire est activé par défaut.
- Les disponibilités restent disponibles en local si la table Supabase manque. Dans ce cas, l’application affiche un message; exécutez de nouveau le fichier complet `schema.sql` dans **Supabase → SQL Editor → New query → Run** pour créer la table et ses politiques RLS.
- Après mise à jour des fichiers de l’application, rechargez la page; le cache du service worker est renouvelé (`menage-shell-v10`).

## Disponibilités et mise à jour
- Pour activer la synchronisation des disponibilités, relancez le fichier complet `schema.sql` dans **Supabase → SQL Editor → New query → Run**. La table `disponibilites` et ses politiques RLS sont créées de manière idempotente.
- Si cette table n’existe pas, l’application conserve les choix sur cet appareil et affiche un message de synchronisation; relancez `schema.sql`.
- Le cache hors ligne a été renouvelé (`menage-shell-v10`); rechargez la PWA après la mise à jour.

## Nouveautés de cette version
- Onglet **Disponibilités** : grille par membre, par jour (lundi à dimanche) et par créneau (matin, midi, après-midi, soir), avec préréglages « Tout dispo », « Soirs + week-end » et « Week-end seulement ». Les nouvelles personnes sont disponibles partout par défaut.
- Le planning respecte les disponibilités, équilibre les charges en minutes, évite les doublons par jour, conserve les occurrences quotidiennes/espacées et privilégie le vendredi soir ou le week-end pour les loisirs.
- Formulaire d’ajout et d’édition des tâches avec durée d’occurrence, fréquence (quotidienne, N fois/semaine, hebdomadaire, aux deux semaines ou mensuelle), responsable, corvée/loisir, jours préférés et créneau préféré.
- Planning hebdomadaire automatique : tâches quotidiennes présentes chaque jour; fréquences multiples espacées; équilibrage de la charge; tâches de loisir orientées vers vendredi et week-end; filtre par personne et totaux hebdomadaires.
- Les cases « fait » sont stockées dans `localStorage` par semaine ISO; elles ne sont pas synchronisées avec Supabase.
- Les données métier (membres, tâches, évaluations) et disponibilités restent synchronisées via l’API REST Supabase si la table existe; paramètres de connexion, état de planification et coches restent locaux.

## Utiliser le QR pour relier un autre appareil
Dans **Réglages**, vérifiez l’adresse de l’application (en local, saisissez votre adresse Netlify ou GitHub Pages), puis cliquez **Créer / actualiser le QR**. Scannez-le sur l’autre appareil : il ouvrira l’application et remplira les réglages Supabase. Le lien de copie fait la même chose.

**Sécurité :** le QR et son lien contiennent l’adresse Supabase et la clé `anon` (publique). Les politiques RLS du fichier SQL autorisent l’accès anonyme en lecture et modification pour une petite application familiale ; toute personne qui possède ces informations peut consulter ou modifier les données. Ne publiez pas le QR ou le lien. N’utilisez jamais une clé `service_role` ou une clé secrète dans l’application. Utilisez un projet séparé si vous ne voulez pas partager vos données.

## Dépannage
- **Erreur concernant les nouvelles colonnes** : relancez le fichier complet `schema.sql` dans **Supabase → SQL Editor**; cela crée également la table de disponibilités. La page indique aussi clairement cette marche à suivre si la base n’est pas encore à jour.
- **Erreur de connexion** : vérifiez que le Project URL et la clé sont copiés sans espaces, et que `schema.sql` a bien été exécuté sans erreur.
- Ouvrez le site avec son adresse **https://** pour le service hors connexion et l’installation comme application.
- Si les évaluations semblent en retard, changez d’onglet : les données sont actualisées à chaque changement d’onglet.

## Fichiers distribués
`index.html`, `manifest.json`, `sw.js`, `icon.svg`, `schema.sql` et `LISEZMOI.md` sont inclus à la racine de `menage-pwa.zip`.

## Disponibilités et créneaux préférés
Dans **Disponibilités**, cochez les créneaux Matin, Midi, Après-midi et Soir pour chaque jour de la semaine et chaque membre. Les trois boutons de préréglage appliquent Tout dispo, Soirs + week-end ou Week-end seulement. Les nouveaux membres sont disponibles partout par défaut.

Dans le formulaire de tâche, le créneau préféré est facultatif; l’algorithme tente ce créneau, puis les voisins. Un responsable fixé n’est planifié que s’il est disponible. Pour « À répartir », l’app choisit la personne disponible la moins chargée en minutes. Les tâches quotidiennes sont créées chaque jour; les tâches récurrentes évitent les doublons; les loisirs privilégient vendredi soir et le week-end. Si aucun membre n’est disponible, l’occurrence est signalée dans « Non planifiable (aucune dispo) ».

Les colonnes `members.availability` (jsonb) et `tasks.preferred_slot` (text) sont initialisées avec des valeurs par défaut sans effacer les lignes existantes. Si l’ancien schéma Supabase est encore déployé, les préférences sont gardées dans le stockage local et un avertissement s’affiche : relancez `schema.sql` pour synchroniser.
