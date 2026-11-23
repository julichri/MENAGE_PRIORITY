# Priorité du ménage — installation très simple

## 1. Créer le petit espace de données gratuit
1. Ouvrez **supabase.com**, créez un compte gratuit puis cliquez **New project**.
2. Donnez un nom à votre projet, choisissez un mot de passe de base de données et une région proche de chez vous. Attendez que le projet soit prêt.
3. Dans le menu gauche, ouvrez **SQL Editor**, puis **New query**.
4. Ouvrez le fichier `schema.sql` de ce dossier avec un éditeur de texte, sélectionnez tout et copiez. Collez le texte dans SQL Editor puis cliquez **Run**. Les tables sont créées ou mises à jour sans doublonner les colonnes.
5. Dans Supabase, ouvrez **Project Settings** (roue dentée) → **API**. Copiez **Project URL** et la clé publique **anon / publishable** (pas la clé `service_role` ni une clé secrète).

> **Mise à jour d’une installation existante :** il faut relancer le fichier complet `schema.sql` dans **Supabase → SQL Editor → New query → Run** pour créer les nouvelles colonnes de tâches. Cette opération est idempotente et conserve les politiques RLS.

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
5. Dans **Tâches**, ajoutez ou modifiez le temps par occurrence, la fréquence, la personne responsable, le type, les jours et le moment préféré. L’estimation hebdomadaire est affichée.
6. L’onglet **Planning** crée une proposition de lundi à dimanche, répartit les occurrences, estime la charge par jour et personne, et permet de cocher les tâches faites. **Régénérer** refait la proposition. Les coches sont locales à l’appareil et à la semaine ISO courante.
7. L’onglet **Compte rendu** classe les priorités, affiche la durée hebdomadaire, le responsable et le type, montre le détail par personne et permet de copier un résumé.

## Nouveautés de cette version
- Formulaire d’ajout et d’édition des tâches avec durée d’occurrence, fréquence (quotidienne, N fois/semaine, hebdomadaire, aux deux semaines ou mensuelle), responsable, corvée/loisir, jours préférés et moment.
- Planning hebdomadaire automatique : tâches quotidiennes présentes chaque jour; fréquences multiples espacées; équilibrage de la charge; tâches de loisir orientées vers vendredi et week-end; filtre par personne et totaux hebdomadaires.
- Les cases « fait » sont stockées dans `localStorage` par semaine ISO; elles ne sont pas synchronisées avec Supabase.
- Les données métier (membres, tâches, évaluations) restent synchronisées via l’API REST Supabase; paramètres de connexion, état de planification et coches restent locaux.

## Utiliser le QR pour relier un autre appareil
Dans **Réglages**, vérifiez l’adresse de l’application (en local, saisissez votre adresse Netlify ou GitHub Pages), puis cliquez **Créer / actualiser le QR**. Scannez-le sur l’autre appareil : il ouvrira l’application et remplira les réglages Supabase. Le lien de copie fait la même chose.

**Sécurité :** le QR et son lien contiennent l’adresse Supabase et la clé `anon` (publique). Les politiques RLS du fichier SQL autorisent l’accès anonyme en lecture et modification pour une petite application familiale ; toute personne qui possède ces informations peut consulter ou modifier les données. Ne publiez pas le QR ou le lien. N’utilisez jamais une clé `service_role` ou une clé secrète dans l’application. Utilisez un projet séparé si vous ne voulez pas partager vos données.

## Dépannage
- **Erreur concernant les nouvelles colonnes** : relancez le fichier complet `schema.sql` dans **Supabase → SQL Editor**. La page indique aussi clairement cette marche à suivre si la base n’est pas encore à jour.
- **Erreur de connexion** : vérifiez que le Project URL et la clé sont copiés sans espaces, et que `schema.sql` a bien été exécuté sans erreur.
- Ouvrez le site avec son adresse **https://** pour le service hors connexion et l’installation comme application.
- Si les évaluations semblent en retard, changez d’onglet : les données sont actualisées à chaque changement d’onglet.

## Fichiers distribués
`index.html`, `manifest.json`, `sw.js`, `icon.svg`, `schema.sql` et `LISEZMOI.md` sont inclus à la racine de `menage-pwa.zip`.
